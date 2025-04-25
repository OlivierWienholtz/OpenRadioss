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
#include <checksum_model.h>
#include <checksum_anim.h>
#include <checksum_list.h>
using namespace std;


// Class to list the compute starter input file and parse output files for checksums
// -----------------------------------------------------------------------------------

  std::string List_checksum::get_path(const std::string& filepath) {
    // Find the last occurrence of the path separator
#ifdef _WIN64
    size_t pos = filepath.find_last_of("/\\");
    if (pos == std::string::npos) {
       pos = filepath.find_last_of("/");
    }
#else
    size_t pos = filepath.find_last_of("/");
#endif
    if (pos != std::string::npos) {
        // Extract the substring up to the last separator
        return filepath.substr(0, pos);
    }
    // If no separator is found, return an empty string
    return "";
}

  // -----------------------------------------------------------------------------------
  // Tool : Format the number as a 4-digit string with leading zeros for .out files
  // input:
  // number : integer to be formatted
  // output:
  // formatted string
  // -----------------------------------------------------------------------------------
  string List_checksum::format_as_4_digits(int number) {
  // -----------------------------------------------------------------------------------
      ostringstream oss;
      oss << setw(4) << setfill('0') << number;
      return oss.str();
  }

  // -----------------------------------------------------------------------------------
  // Tool : Format the number as a 3-digit string with leading zeros for Animation & Time History files
  // input:
  // number : integer to be formatted
  // output:
  // formatted string
  // -----------------------------------------------------------------------------------
  string List_checksum::format_as_3_digits(int number) {
    // -----------------------------------------------------------------------------------
        ostringstream oss;
        oss << setw(3) << setfill('0') << number;
        return oss.str();
    }
  
  // -----------------------------------------------------------------------------------
  // Dos2Unix : function to remove (cr) characters from a string
  // -----------------------------------------------------------------------------------
  void List_checksum::remove_cr(std::string& line) {
    line.erase(std::remove(line.begin(), line.end(), '\r'), line.end());
 }

  
  // -----------------------------------------------------------------------------------
  // Tool : Return the separator for the file path according to the OS
  // output:
  // separator : "/" for Unix, "\" for Windows
  // -----------------------------------------------------------------------------------
  string List_checksum::separator(){
  // -----------------------------------------------------------------------------------
    #ifdef _WIN64
      return "\\"; // Windows separator
    #else
      return "/";  // Unix separator
    #endif
  }

  // -----------------------------------------------------------------------------------
  // Compare two lists of checksums
  // input:
  // list1 : first list of checksums
  // list2 : second list of checksums
  // output:
  // 1 if the lists are equal, 0 if they are not equal
  // -----------------------------------------------------------------------------------
  int List_checksum::compare_lists(list<string> list1, list<string> list2){
  // -----------------------------------------------------------------------------------  
      if (list1.size() != list2.size()) {
          return 0; // Lists are not equal in size
      }
      auto it1 = list1.begin();
      auto it2 = list2.begin();
      while (it1 != list1.end() && it2 != list2.end()) {
          if (*it1 != *it2) {
              return 0; // Lists are not equal
          }
          ++it1;
          ++it2;
      }
      return 1; // Lists are equal
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
  list<string> List_checksum::parse_out_file(fstream *new_file){
  // -----------------------------------------------------------------------------------
      list<string> checksum_list;
      
      int not_found=1;
      string line;
      while (getline(*new_file, line) && not_found) {
        remove_cr(line); // Remove carriage return characters
        if (line == " CHECKSUMS" || line == "    CHECKSUMS") {                       // Engine output format has 1 space, Starter 
           if (getline(*new_file, line)){     // 2 blank lines
            if (getline(*new_file, line)){
              while( not_found && getline(*new_file, line) ){                   // Read all lines until "CHECKSUM :" is no more found
                 string comp=line.substr(0, 15);
                 if (comp == "    CHECKSUM : "){
                    
                    string checksum = line.substr(15);
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

  // -------------------------------------------------------------------------------------------------------------------------------------------------
  // Parse all .out files in the directory
  // input:
  // directory : directory where the .out files are located
  // rootname  : rootname of the .out files (without run number and extension)
  // output:
  // list of tuples (filename, checksum match)
  // The checksum match is 1 if the checksums are equal, 0 if they are not equal
  // -------------------------------------------------------------------------------------------------------------------------------------------------
  void List_checksum::parse_output_files(string directory, string rootname, list<tuple<string,list<string>>> *checksum_list){
  // -------------------------------------------------------------------------------------------------------------------------------------------------
    string sep=separator();
    int run_number=0;
    int found_out_file=1;

    while (found_out_file){
      
      // Construct the output file name
      string runnumber = format_as_4_digits(run_number);
      string outfile;
      if ( directory.length() > 0 ){
          outfile = directory + sep + rootname + "_" + runnumber + ".out";
      }else{
          outfile = rootname + "_" + runnumber + ".out";
      }
      
      fstream new_file;
      new_file.open(outfile, ios::in);

      if ( !new_file.is_open() ) {
          // cout << "Error: Unable to open file " << outfile << endl;
          found_out_file=0; // No more .out files to process
      }else{
             if (debug){
                cout << "Parsing file: " << outfile << endl;
             }
             list<string> checksum_list_out=parse_out_file( &new_file );
             checksum_list->push_back(make_tuple(outfile,checksum_list_out)); // Add the checksum list to the collection
             new_file.close();
      run_number++;
      }
    }
  }

  // -------------------------------------------------------------------------------------------------------------------------------------------------
  // Parse all Animation files in the directory
  // input:
  // directory : directory where the .out files are located
  // rootname  : rootname of the .out files (without run number and extension)
  // output:
  // list of tuples (filename, checksum match)
  // The checksum match is 1 if the checksums are equal, 0 if they are not equal
  // -------------------------------------------------------------------------------------------------------------------------------------------------
  void List_checksum::parse_animation_files(string directory, string rootname, list<tuple<string,list<string>>> *checksum_list){ 
  // -------------------------------------------------------------------------------------------------------------------------------------------------
    string sep=separator();
    int run_number=1;
    int found_out_file=1;

    while (found_out_file){
      // Construct the output file name
      string st_runnumber = format_as_3_digits(run_number);
      string anim_file;
      if ( directory.length() > 0 ){
          anim_file = directory + sep + rootname + "A" + st_runnumber;
      }else{
        anim_file = rootname + "A" + st_runnumber;
      }

      FILE *new_file;
#ifdef _WIN64
      fopen_s(&new_file, anim_file.c_str(), "rb");
#else
      new_file = fopen(anim_file.c_str(), "rb");
#endif

      if ( !new_file ) {
          // cout << "Error: Unable to open file " << anim_file << endl;
          found_out_file=0; // No more .out files to process
      }else{
             if (debug){
                cout << "Parsing file: " << anim_file << endl;
             }

             AnimCheckSum anim;
             list<string> checksum_list_out=anim.CheckSum( new_file );
             checksum_list->push_back(make_tuple(anim_file,checksum_list_out)); // Add the checksum list to the collection
             fclose(new_file);
      
            }
            run_number++;

      
    }
  }


  List_checksum::List_checksum()    // Constructor
  {};


  // -------------------------------------------------------------------------------
  // Compare the checksum from deck to output file
  // Computes input deck checksum & parse all output files to compare the results.
  // -------------------------------------------------------------------------------
  // input:
  // starter_input_file : string starter input filename (may contain path)
  // output:
  // list of checksums found in the .out file : format (filename, checksum list)
  // -------------------------------------------------------------------------------
  list<tuple<string,list<string>>> List_checksum::chk_list(string starter_input_file){
  // -------------------------------------------------------------------------------
    list<tuple<string,list<string>>>  checksum_list; // checksum list collection from all decks : filename, checksum list

    // Compute checksum from input deck
    MD5Checksum my_checksums;
    my_checksums.MD5Checksum_parse(starter_input_file);

    list<string> deck_checksum_list=my_checksums.get_checksums();    // Compute checksum from input deck

    // Add Starter computed checksum to the list
    checksum_list.push_back(make_tuple(starter_input_file,deck_checksum_list)); // Add the checksum list to the collection


    // Extract directory, filename, extension, rootname from starter_input_file
    string directory = get_path(starter_input_file); // Get the directory of the file
    string filename  = starter_input_file.substr(starter_input_file.find_last_of(separator()) + 1);
    string extension = filename.substr(filename.find_last_of('.'));

    string rootname;
    if (extension == ".rad"){
      rootname = filename.substr(0, filename.find_last_of('_'));
    }else{
      rootname = "unkown";
    }

    if (debug){
      cout <<  endl;
      cout << "Input file: " << starter_input_file << endl;
      cout << "Directory: " << directory << endl;
      cout << "Filename: " << filename << endl;
      cout << "Extension: " << extension << endl;    
      cout << "Rootname: " << rootname << endl;
      cout << endl;

      cout << "Commputed Checksum list from deck: " << endl;
      cout << "===================================" << endl; 
      for (const auto& item : deck_checksum_list){
        cout << item << endl;
      }
      cout << "==============================" << endl;
      cout << endl;
    }

    
    // Parse all .out files in the directory
    parse_output_files(directory, rootname, &checksum_list);

    // parse all animation files in the directory
    parse_animation_files(directory, rootname, &checksum_list);

    // print the checksum list from all output files
    if (debug){
      cout << "Checksum list from output files: " << endl;
      cout << "==============================" << endl; 
      for (const auto& item : checksum_list){
        cout << "File: " << get<0>(item) << endl;
        for (const auto& checksum : get<1>(item)){
          cout << "    "<< checksum << endl;
        }
        cout << "==============================" << endl; 
      }
    }
    return checksum_list ;
  }

// End of class Verify_checksum
// ------------------------------------------------------------------------------------------------------------------------





// ------------------------------------------------------------------------------------------------------------------------
// Main Standalone function to test the checksum tool
// The function will read the input file and compute the checksums
// The function will also parse the .out files and compare the checksums with the ones computed in the input deck
// The function will print the results to the console
// To build in Standalone mode, use the following command:
// On Windows:
// icx -DMAIN         -o ..\exec\checksum.exe -Ishare/includes -ID:\WS\GitHub\OpenRadioss_VS\OpenRadioss\extlib\md5\include source\output\checksum\checksum_list.cpp source\output\checksum\checksum_model.cpp source\output\checksum\checksum_anim.cpp D:\WS\GitHub\OpenRadioss_VS\OpenRadioss\extlib\md5\win64\md5.lib ws2_32.lib
// g++ -DMAIN -no-pie -o ../exec/checksum -Ishare/includes -I/mnt/d/WS/GitHub/OpenRadioss_VS/OpenRadioss/extlib/md5/include source/output/checksum/checksum_list.cpp source/output/checksum/checksum_model.cpp source/output/checksum/checksum_anim.cpp /mnt/d/WS/GitHub/OpenRadioss_VS/OpenRadioss/extlib/md5/linux64/libmd5.a   -std=c++14
// Add -DDEBUG for additional debug information
// ------------------------------------------------------------------------------------------------------------------------
#ifdef MAIN
int main(int argc, char *argv[])
{
  List_checksum verify_chksum_tool;
  cout << endl;
  cout << "Filename to process: "<< argv[1] << endl;
  string file=string(argv[1]);

  list<tuple<string,list<string>>>  list = verify_chksum_tool.chk_list(file);
  
  cout << endl;
  cout << "Checksum list from output files: " << endl;
  cout << "==============================" << endl << endl; 

  for (const auto& item : list){
    cout << "File: " << get<0>(item) << endl;
    for (const auto& checksum : get<1>(item)){
      string title=checksum.substr(0,checksum.length()-33); // Remove the checksum value
      string digest=checksum.substr(checksum.length()-32); // Keep only the checksum value
      cout << "    "<< title << " : " <<  digest << endl;
    }
    cout <<  endl; 
  }
}
#endif