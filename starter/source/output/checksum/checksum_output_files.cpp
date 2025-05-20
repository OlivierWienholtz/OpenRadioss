//Copyright>    OpenRadioss
//Copyright>    Copyright (C) 1986-2025 Altair Engineering Inc.
//Copyright>
//Copyright>    This program is free software: you can redistribute it and/or modify
//Copyright>    it under the terms of the GNU Affero General Public License as published by
//Copyright>    the Free Software Foundation, either version 3 of the License, or
//Copyright>    (at your option) any later version.
//Copyright>
//Copyright>    This program is distributed in the hope that it will be useful,
//Copyright>    but WITHOUT ANY WARRANTY; without even the implied warranty of
//Copyright>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//Copyright>    GNU Affero General Public License for more details.
//Copyright>
//Copyright>    You should have received a copy of the GNU Affero General Public License
//Copyright>    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//Copyright>
//Copyright>
//Copyright>    Commercial Alternative: Altair Radioss Software
//Copyright>
//Copyright>    As an alternative to this open-source version, Altair also offers Altair Radioss
//Copyright>    software under a commercial license.  Contact Altair to discuss further if the
//Copyright>    commercial version may interest you: https://www.altair.com/radioss/.

#include <checksum_output_files.h>
  // -----------------------------------------------------------------------------------
  // Dos2Unix : function to remove (cr) characters from a string
  // -----------------------------------------------------------------------------------
  void CheckSum_Output_Files::remove_cr(std::string& line) {
    line.erase(std::remove(line.begin(), line.end(), '\r'), line.end());
  }

  // -----------------------------------------------------------------------------------
  // Remove trailing blanks from a string
  // -----------------------------------------------------------------------------------
  void CheckSum_Output_Files::remove_trailing_blanks(std::string& str) {
    str.erase(std::find_if(str.rbegin(), str.rend(), [](unsigned char ch) {
        return !std::isspace(ch);
    }).base(), str.end());
  }

  inline void CheckSum_Output_Files::SWAP_MANY2BYTES(uint16_t *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = htons((intPtr[ptrIndex]));
    }
  }

  inline void CheckSum_Output_Files::SWAP_MANY4BYTES(int *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = ntohl((intPtr[ptrIndex]));
    }
  }

  inline void CheckSum_Output_Files::SWAP_MANY8BYTES(double *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = htobe64(intPtr[ptrIndex]);
    }
  }

  inline void CheckSum_Output_Files::SWAP_BYTESINDATA(void *itemList, size_t itemCount, size_t sizeOfItem){
    uint16_t *uint16_tCopy;
    int *intCopy;
    double *doubleCopy;
    switch ((sizeOfItem)){
    case 1:
        break;
    case 2:
        uint16_tCopy = (uint16_t *)(itemList);
        SWAP_MANY2BYTES(uint16_tCopy, (itemCount));
        break;
    case 4:
        intCopy = (int *)(itemList);
        SWAP_MANY4BYTES(intCopy, (itemCount));
        break;
    case 8:
        doubleCopy = (double *)(itemList);
        SWAP_MANY8BYTES(doubleCopy, (itemCount));
        break;
    }
  }

  // read in file
  // ----------------------
  int CheckSum_Output_Files::Ufread(void *pchar, size_t sizeOfItem,
           size_t numItems,
           FILE *OpenedFile,
           bool text ){
    int ret = fread(pchar, sizeOfItem, numItems, OpenedFile);

    if (ret < 0){
        cout << "Error in reading file"
             << "\n";
    }
    SWAP_BYTESINDATA(pchar, numItems, sizeOfItem);
    if (text)
        ((char *)pchar)[sizeOfItem * numItems] = '\0';
    return ret;
  }

// Read Animation file & retrieve checksums
// --------------------------------------------------
std::list<std::string> CheckSum_Output_Files::Animation(FILE *inf)
{
    typedef unsigned char Boolean;

    int magic;     // object format
    int flagA[10]; // array of flags
    float a_time;  // state time

    // 3D GEOMETRY
    int nbElts3D = 0;             // number of 8nodes elements
    int nbParts3D = 0;            // number of parts
    int nbEFunc3D = 0;            // number of element scalar values
    int nbTens3D = 0;             // number of tensors
    int *connect3DA = nullptr;    // connectivity array of 8  nbElts3D
    Boolean *delElt3DA = nullptr; // are the elements deleted or not, array of nbElts3D
    int *defPart3DA = nullptr;    // part definition: array of nbParts3D
    char **pText3DA = nullptr;    // part name: array of nbParts3D
    char **fText3DA = nullptr;    // array of scalar name: nbEFunc3D
    float *eFunc3DA = nullptr;    // scalar value per element array of nbEFunc3D*nbElts3D
    char **tText3DA = nullptr;    // tensor name array of nbTens3D
    float *tensVal3DA = nullptr;  // tens value array of 6*nbTens3D*nbElt3D
    float *eMass3DA = nullptr;    // nbElt3D, elt mass
    int *elNum3DA = nullptr;      // nbElt3D, intern elt numbering

    // 2D GEOMETRY
    int nbFacets = 0;                           // number of 4nodes elements
    int nbNodes = 0;                            // total number of nodes
    int nbParts = 0;                            // number of parts
    int nbFunc = 0;                             // number of nodal scalar values
    int nbEFunc = 0;                            // number of element scalar values
    int nbVect = 0;                             // number of vectors
    int nbTens = 0;                             // number of tensors
    int nbSkew = 0;                             // number of skews
    uint16_t *skewShortValA = nullptr;          // array of the skew values defined in uint16_t * 3000 ;
    float *skewValA = nullptr;                  // array of the skew values for each elt
    float *coorA = nullptr;                     // coordinates array of 3*nbNodes
    int *connectA = nullptr;                    // connectivity array of 4 * nbFacets
    char *delEltA = nullptr;                    // are the elements deleted or not, array of nbFacets
    int *defPartA = nullptr;                    // part definition: array of nbParts
    uint16_t *normShortA = nullptr;             // facet normal in uint16_t : array of 3*nbNodes
    float *funcA = nullptr;                     // scalar value per node array of nbFunc*nbNodes
    float *eFuncA = nullptr;                    // scalar value per element array of nbEFunc*nbFacets

    char tmpText[128];
    int i;

    std::list<std::string> checksum_list;

    // read Animation file
    Ufread(&magic, sizeof(int), 1, inf);

    switch (magic){
      case FASTMAGI10:
      {
        Ufread(&a_time, sizeof(float), 1, inf); // time of the file
        Ufread(tmpText, sizeof(char), 81, inf); // Time text
        Ufread(tmpText, sizeof(char), 81, inf); // ModAnim text
        Ufread(tmpText, sizeof(char), 81, inf); // RadiossRun text
                                                // array of 10 flags
                                                //        flagA[0] defines if theflagA mass is saved or not
                                                //        flagA[1] defines if the node-element numbering arrays are saved or not
                                                //        flagA[2] defines format :if there is 3D geometry
                                                //        flagA[3] defines format :if there is 1D geometry
                                                //        flagA[4] defines hierarchy
                                                //        flagA[5] defines node/elt list for TH
                                                //        flagA[6] defines if there is a new skew for tensor 2D
                                                //        flagA[7] define if there is SPH format
                                                //        flagA[8] to flagsA[9] are not yet used

        Ufread(flagA, sizeof(int), 10, inf);
        // ********************
        // 2D GEOMETRY
        // ********************
        Ufread(&nbNodes, sizeof(int), 1, inf);  // number of nodes
        Ufread(&nbFacets, sizeof(int), 1, inf); // number of 4nodes elements
        Ufread(&nbParts, sizeof(int), 1, inf);  // number of parts
        Ufread(&nbFunc, sizeof(int), 1, inf);   // number of nodal scalar values
        Ufread(&nbEFunc, sizeof(int), 1, inf);  // number of elemt scalar values
        Ufread(&nbVect, sizeof(int), 1, inf);   // number of vector values
        Ufread(&nbTens, sizeof(int), 1, inf);   // number of tensor values
        Ufread(&nbSkew, sizeof(int), 1, inf);   // number of skews array of the skew values defined in uint16_t * 3000

        if (nbSkew)
        {
            skewShortValA = (uint16_t *)malloc(nbSkew * 6 * sizeof(uint16_t));
            skewValA = (float *)malloc(nbSkew * 6 * sizeof(float));
            Ufread(skewShortValA, sizeof(uint16_t), nbSkew * 6,
                   inf);
            for (i = 0; i < 6 * nbSkew; i++)
            {
                skewValA[i] = ((float)skewShortValA[i]) /
                              SHORT2FLOAT;
            }
        }

        // coordinates array: containing the x,y,z coordinates of each node
        coorA = (float *)malloc(3 * nbNodes * sizeof(float));
        Ufread(coorA, sizeof(float), 3 * nbNodes, inf);
        free(coorA);

        // element connectivity array with local node numbering [0 to (nbNodes-1)]
        if (nbFacets)
        {
            connectA = (int *)malloc(nbFacets * 4 * sizeof(int));
            Ufread(connectA, sizeof(int), nbFacets * 4, inf);
            free(connectA);

            // deleted elements : the deleted elements stay in their original parts,
            // the delEltA indicates which elements are deleted or not
            delEltA = (char *)malloc(nbFacets * sizeof(char));
            Ufread(delEltA, sizeof(char), nbFacets, inf);
            free(delEltA);
        }
        // parts definition: array containing an index on thelast facet which defines each part.
        if (nbParts != 0)
        {
            defPartA = (int *)malloc(nbParts * sizeof(int));
            Ufread(defPartA, sizeof(int), nbParts, inf);
            free(defPartA);

            // part texts which defines the name of each part Each name does not exceed 50 characters.
            for (i = 0; i < nbParts; i++){
                Ufread(tmpText, sizeof(char), 50, inf);
            }
        }
        // array of the norm values for each nodes the norm are defined in uint16_t * 3000

        normShortA = (uint16_t *)malloc(3 * nbNodes * sizeof(uint16_t));
        Ufread(normShortA, sizeof(uint16_t), 3 * nbNodes, inf);
        free(normShortA);

        // scalar values
        if (nbFunc + nbEFunc)
        {
            // array of total scalar functions names (nodal +  element)
            for (i = 0; i < (nbFunc + nbEFunc); i++)
            {
                Ufread(tmpText, sizeof(char), 81, inf);
    
                if (strncmp(tmpText, "ZCHKSM_",7) == 0 )
                {
                  std::string checksum(tmpText);
                  checksum = checksum.substr(7);
                  checksum_list.push_back(checksum);
                }

            }
            funcA = (float *)malloc(nbFunc * nbNodes * sizeof(float));
            eFuncA = (float *)malloc(nbEFunc * nbFacets * sizeof(float));
            if (nbFunc){
                Ufread(funcA, sizeof(float), nbNodes * nbFunc, inf);
            }

            if (nbEFunc){
                Ufread(eFuncA, sizeof(float), nbFacets * nbEFunc, inf);
            }
            free(funcA);
            free(eFuncA);
        }
      }
    }
  return checksum_list;
}

// Read Thime History file & retrieve checksums
// --------------------------------------------------
std::list<std::string> CheckSum_Output_Files::Time_History(FILE * curfile)
  {
    int i,j;
    int TH_Version;
    char NameRequest[100];
    char checksum[100];
    char string_value[101];
    float float_variable;
    int dummy_variable;
    int NUMMAT,NUMGEO,NVAR,NBELEM,NBSUBSF,NBPARTF,NSUBS;
    int NPART_NTHPART,NTHGRP2,NGLOB;
    int titleLength=0;
    std::list<std::string> checksum_list;

    Ufread(&dummy_variable,sizeof(int),1,curfile);

    // Time History Version
    Ufread(&TH_Version,sizeof(int),1,curfile);
    if(TH_Version >= 4021){
        titleLength = 100;
    }
    else if(TH_Version >= 3050){
        titleLength = 100;
    }
    else if(TH_Version >= 3041){
        titleLength = 80;
    }
    else{
        titleLength = 40;
    }

    // Deck rootname
    Ufread(string_value,sizeof(char),80,curfile,true);
    Ufread(&dummy_variable,sizeof(int),1,curfile);

    // deck version date
    Ufread(&dummy_variable,sizeof(int),1,curfile);
    Ufread(string_value,sizeof(char),80,curfile,true);
    Ufread(&dummy_variable,sizeof(int),1,curfile);

    if(TH_Version >= 3050)
    {
     // ADDITIONAL RECORDS
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        Ufread(&dummy_variable,sizeof(int),1,curfile);

        // 1ST RECORD : title length
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        Ufread(&dummy_variable,sizeof(int),1,curfile);

        // 2ND RECORD : FAC_MASS,FAC_LENGTH,FAC_TIME
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        Ufread(&float_variable,sizeof(float),1,curfile);
        Ufread(&float_variable,sizeof(float),1,curfile);
        Ufread(&float_variable,sizeof(float),1,curfile);
        Ufread(&dummy_variable,sizeof(int),1,curfile);
    }

    // HIERARCHY INFO
    Ufread(&dummy_variable,sizeof(int),1,curfile);

    // NPART_NTHPART, NUMMAT, NUMGEO, NSUBS, NTHGRP2, NGLOB
    Ufread(&NPART_NTHPART,sizeof(int),1,curfile);
    Ufread(&NUMMAT,sizeof(int),1,curfile);
    Ufread(&NUMGEO,sizeof(int),1,curfile);
    Ufread(&NSUBS,sizeof(int),1,curfile);
    Ufread(&NTHGRP2,sizeof(int),1,curfile);
    Ufread(&NGLOB,sizeof(int),1,curfile);
    
    Ufread(&dummy_variable,sizeof(int),1,curfile);

    // NGLOB Value
    // -------------------------------------------------
    if(NGLOB > 0)
    {
        Ufread(&dummy_variable,sizeof(int),1,curfile);
        for(i=0;i<NGLOB;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
        }
        Ufread(&dummy_variable,sizeof(int),1,curfile);
    }

    // Part Description
    // -------------------------------------------------
    if(NPART_NTHPART > 0)
    {
        for(i=0;i<NPART_NTHPART;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(string_value,sizeof(char),titleLength,curfile,true);
            //cout << "Part title : " << string_value << endl;
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&NVAR,sizeof(int),1,curfile);            // NVAR : number of variables
            // cout << "NVAR : " << NVAR << endl;
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            if (NVAR > 0){
              int *dummy_array;
              dummy_array = (int*)malloc((NVAR+2)*sizeof(int));
              Ufread(dummy_array,sizeof(int),NVAR+2,curfile);
              free (dummy_array);
            }
        }
    }
    // Material Description
    // -------------------------------------------------
    if(NUMMAT > 0)
    {
        for(i=0;i<NUMMAT;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(string_value,sizeof(char),titleLength,curfile,true);
            //cout << "Mat title : " << string_value << endl;
            Ufread(&dummy_variable,sizeof(int),1,curfile);
        }
    }

    // Properties Description
    // -------------------------------------------------
    if(NUMGEO > 0)
    {
        for(i=0;i<NUMGEO;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(string_value,sizeof(char),titleLength,curfile,true);
            //cout << "Prop title : " << string_value << endl;
            Ufread(&dummy_variable,sizeof(int),1,curfile);
        }
    }

    // Subset Description
    // -------------------------------------------------
    if(NSUBS > 0)
    {
        for(i=0;i<NSUBS;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&NBSUBSF,sizeof(int),1,curfile);         // NBSUBSF
            Ufread(&NBPARTF,sizeof(int),1,curfile);         // NBPARTF
            Ufread(&NVAR,sizeof(int),1,curfile);
            Ufread(string_value,sizeof(char),titleLength,curfile,true);
            //cout << "Subset title : " << string_value << endl;
            //cout << "NBSUBSF : " << NBSUBSF << endl;
            //cout << "NBPARTF : " << NBPARTF << endl;
            //cout << "NVAR    : " << NBPARTF << endl;
            Ufread(&dummy_variable,sizeof(int),1,curfile);

            if (NBSUBSF > 0){
                int* dummy_array;
                dummy_array = (int*)malloc((NBSUBSF+2)*sizeof(int));
                Ufread(dummy_array,sizeof(int),NBSUBSF+2,curfile);
                free (dummy_array);
            }

            if (NBPARTF > 0){
                int *dummy_array;
                dummy_array = (int*)malloc((NBPARTF+2)*sizeof(int));
                Ufread(dummy_array,sizeof(int),NBPARTF+2,curfile);
                free (dummy_array);
            }

            if (NVAR > 0){
                int *dummy_array;
                dummy_array = (int*)malloc((NVAR+2)*sizeof(int));
                Ufread(dummy_array,sizeof(int),NVAR+2,curfile);
                free (dummy_array);
            }
        }
    }

    // Time History Group
    // -------------------------------------------------
    if(NTHGRP2 > 0)
    {
        for(i=0;i<NTHGRP2;i++){
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);
            Ufread(&dummy_variable,sizeof(int),1,curfile);

            Ufread(&NBELEM,sizeof(int),1,curfile);   // NBELEM
            Ufread(&NVAR,sizeof(int),1,curfile);     // NVAR

            Ufread(NameRequest,sizeof(char),titleLength,curfile,true);
            // cout << "TH Group title : " << NameRequest << endl;

            int isCheckSum = 0;
            if (strncmp(NameRequest, "CHECKSUM", 8) == 0) isCheckSum = 1;
            
            Ufread(&dummy_variable,sizeof(int),1,curfile);

            for(j=0;j<NBELEM;j++){
                Ufread(&dummy_variable,sizeof(int),1,curfile);
                Ufread(&dummy_variable,sizeof(int),1,curfile);
                Ufread(checksum,sizeof(char),titleLength,curfile,true);
                if (isCheckSum == 1){
                    
                    std::string checksum_str(checksum);
                    remove_trailing_blanks(checksum_str);
                    checksum_list.push_back(checksum_str);
                    //cout << "checksum : " <<  checksum_str << endl;
                }
                Ufread(&dummy_variable,sizeof(int),1,curfile);
            }

            int *dummy_array;
            dummy_array = (int*)malloc((NVAR+2)*sizeof(int));
            Ufread(dummy_array,sizeof(int),NVAR+2,curfile);
            free (dummy_array);
        }
    }
    return checksum_list;
  }

  // -----------------------------------------------------------------------------------
  // Parse the .out file and extract checksums
  // Returns a list of checksums
  // The function assumes that the .out file is in the same directory as the input file
  // -----------------------------------------------------------------------------------
  // input:
  // directory : directory where the .out file is located
  // rootname  : rootname of the .out file (without run number and extension)
  // run_number: run number to be used in the .out file name
  // output:
  // list of checksums found in the .out file
  // -----------------------------------------------------------------------------------
  std::list<std::string> CheckSum_Output_Files::Out_File(std::fstream *new_file){
    // -----------------------------------------------------------------------------------
        std::list<std::string> checksum_list;
        
        int not_found=1;
        std::string line;
        while (getline(*new_file, line) && not_found) {
          remove_cr(line); // Remove carriage return characters
          if (line == " CHECKSUM DIGESTS" || line == "    CHECKSUM DIGESTS") {         // Engine output format has 1 space, Starter 
             if (getline(*new_file, line)){                              // 2 blank lines
              if (getline(*new_file, line)){
                while( not_found && getline(*new_file, line) ){          // Read all lines until "CHECKSUM :" is no more found
                   std::string comp=line.substr(0, 15);
                   if (comp == "    CHECKSUM : "){
                      
                      std::string checksum = line.substr(15);
                      checksum_list.push_back(checksum);
  
                      if (debug){
                        cout << "Checksum found: " << checksum << endl;
                      }
  
                   }else{
                      not_found = 0;
                   }
                }
              }
  
             }
             not_found=0; // Stop reading the file, we found the checksum section
          }
        } 
        return checksum_list;
    }

    std::list<std::tuple<std::string,std::string>> CheckSum_Output_Files::Checksum_File(std::fstream *new_file){
        std::list<std::tuple<std::string,std::string>> checksum_list;
        int not_found=1;
        std::string line;
        while (getline(*new_file, line) && not_found) {
          remove_cr(line); // Remove carriage return characters
          if (line == " OUTPUT FILES CHECKSUM DIGESTS") {                // Engine output format has 1 space, Starter 

             if (getline(*new_file, line)){    
                                          // 1 blank lines
                while( not_found && getline(*new_file, line) ){          // Read all lines until "CHECKSUM :" is no more found
                   if (line.length() > 4){
                      std::string comp=line.substr(4);                   // Remove front blanks
                      size_t pos =comp.find_last_of(' ');
                      std::string checksum = comp.substr(pos+1);
                      std::string filename = comp.substr(0,pos);
                   
                      checksum_list.push_back(make_tuple(filename,checksum));
  
                   }else{
                      not_found = 0;
                   }
                }
  
             }
             not_found=0; // Stop reading the file, we found the checksum section
          }
        } 
        return checksum_list;
    }

