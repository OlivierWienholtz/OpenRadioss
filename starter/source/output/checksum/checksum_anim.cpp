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

// For linux compilation :
// g++   -DMAIN -o ../exec/chk_anim source/output/checksum/anim_check.cpp*
// For Windows compilation :
// icx -DANIM_MAIN -Ishare/includes   -o ..\exec\chk_anim source\output\checksum\anim_check.cpp  ws2_32.lib

// To launch check_anim :
// chk_anim  animationFile 

#include <checksum_anim.h>


  inline void AnimCheckSum::SWAP_MANY2BYTES(uint16_t *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = htons((intPtr[ptrIndex]));
    }
  }

  inline void AnimCheckSum::SWAP_MANY4BYTES(int *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = ntohl((intPtr[ptrIndex]));
    }
  }

  inline void AnimCheckSum::SWAP_MANY8BYTES(double *intPtr, size_t number){
    for (size_t ptrIndex = 0; ptrIndex < (number); ptrIndex++){
        intPtr[ptrIndex] = htobe64(intPtr[ptrIndex]);
    }
  }

  inline void AnimCheckSum::SWAP_BYTESINDATA(void *itemList, size_t itemCount, size_t sizeOfItem){
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

  // ****************************************
  // read in file
  // ****************************************
  int AnimCheckSum::Ufread(void *pchar, size_t sizeOfItem,
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



// *****************************************
// Read Animation fime & retrieve checksums
// *****************************************
std::list<std::string> AnimCheckSum::CheckSum(FILE *inf)
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
    
                if (strncmp(tmpText, "CHKSUM_",7) == 0 )
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



#ifdef ANIM_MAIN
// *******************
int main(int argc, char **argv)
{
    std::list<std::string> checksum_list;
    AnimCheckSum animCheckSum;
    FILE *inf;
    if (argc < 2)
    {
        cout << "Call a filename"
             << "\n";
        exit(1);
    }
#ifdef _WIN64
    fopen_s(&inf,argv[1], "rb");
#else
    inf = fopen(argv[1], "rb");
#endif
    if (!inf)
    {
        cout << "Can't open input file " << argv[1] << "\n";
        exit(1);
    }

    checksum_list=animCheckSum.CheckSum(inf);
    cout << "Checksum list " << endl;
    cout << "==============" << endl;
    for (const auto& item : checksum_list){
        cout << "Checksum : " << item << endl;
    }
    cout << "==============" << endl;

    exit(0);
}
#endif
