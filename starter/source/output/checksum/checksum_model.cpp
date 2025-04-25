#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <list>
#include <stdio.h>
#include <stdlib.h>
#include <sstream>
#include <string.h>
#include <md5.h>
#include <filesystem>
#include <algorithm>
#define _FCALL 

using namespace std;

class MD5Checksum {
list<tuple<int,string, md5_state_t, string>>  md5_states;     // List of options : active flag,id, title, checksum digest

private:
  // Debug flag
  // Set to 1 to enable debug mode, 0 to disable it
#ifdef DEBUG
  int debug=1;
#else
  int debug=0;
#endif
  // -----------------------------------------------------------------------------------
  // Function to remove carriage return characters from a string
  // -----------------------------------------------------------------------------------
  void remove_carriage_return(std::string& line) {
     line.erase(std::remove(line.begin(), line.end(), '\r'), line.end());
  }

  // -----------------------------------------------------------------------------------
  // Tool : Return the separator for the file path according to the OS
  // output:
  // separator : "/" for Unix, "\" for Windows
  // -----------------------------------------------------------------------------------
  string separator(){
    // -----------------------------------------------------------------------------------
      #ifdef _WIN64
        return "\\"; // Windows separator
      #else
        return "/";  // Unix separator
      #endif
    }
  // -----------------------------------------------------------------------------------
  // Tool : get directory path from a file path
  // -----------------------------------------------------------------------------------
    std::string get_path(const std::string& filepath) {
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

  // ------------------------------------------------------------------------------------------------------------------------
  void new_checksum( string title, list<tuple<int,string, md5_state_t, string>> *md5_states_tmp){
  // ------------------------------------------------------------------------------------------------------------------------  
  // CHECKSUM/START was met, create a new checksum state
  // input:
  // title : title of the checksum
  // input / output:
  // md5_states_tmp : list of checksums computed in the file
  // ------------------------------------------------------------------------------------------------------------------------
    md5_state_t new_md5;
    md5_init(&new_md5);
    string md5_digest(16,'0');
    md5_states_tmp->push_front(make_tuple(1,title,new_md5,md5_digest));
  };

  // ------------------------------------------------------------------------------------------------------------------------
  // Add line to all active MD5 digests
  // input:
  // line : string to be added to the checksum
  // input / output:
  // md5_states_tmp : list of checksums computed in the file
  // ------------------------------------------------------------------------------------------------------------------------
  void process_checksum(string line, list<tuple<int,string, md5_state_t, string>> *md5_states_tmp){
  // ------------------------------------------------------------------------------------------------------------------------
      for (auto& item : *md5_states_tmp ) {
         if (get<0>(item) == 1){
            md5_state_t state = get<2>(item);
            md5_append( &state, (const md5_byte_t *) line.c_str(), line.length() );
            get<2>(item) = state;
         }
        }
  };

  // --------------------------------------------------------------------------------------------------------------------
  // /CHECKSUM/STOP : Finish the MD5 checksum for the first active state
  // --------------------------------------------------------------------------------------------------------------------
  // input / output 
  // md5_states_tmp : list of checksums computed in the file
  // --------------------------------------------------------------------------------------------------------------------
  void end_checksum(list<tuple<int,string, md5_state_t, string>> *md5_states_tmp){
  // --------------------------------------------------------------------------------------------------------------------
      int state=-1;
      for (auto& item : *md5_states_tmp ) {
            state=get<0>(item);
             if (state == 1) {
                get<0>(item) = 0;   // Set Active flag to 0

                // Finish the MD5 checksum
                md5_state_t state = get<2>(item);
                unsigned char md5[16];
                md5_finish (&state, md5);  

                // Add MD5 in hexadecimal format in tuplet
                ostringstream formatted_line;
                for (int i = 0; i < 16; ++i) {
                    formatted_line << hex << setw(2) << setfill('0') << static_cast<int>(md5[i]);
                }
                get<3>(item)=formatted_line.str();
                break;
             }
      }
  };

  // --------------------------------------------------------------------------------------------------------------------
  // Finalize checksum : After deck file processing : finalize all active checksums (/CHECKSUM/STOP missing) 
  // --------------------------------------------------------------------------------------------------------------------
  // input / output 
  // md5_states_tmp : list of checksums computed in the file
  // --------------------------------------------------------------------------------------------------------------------
  void finalize_checksum(list<tuple<int,string, md5_state_t, string>> *md5_states_tmp){
    // --------------------------------------------------------------------------------------------------------------------
        int state=-1;
        for (auto& item : *md5_states_tmp ) {
              state=get<0>(item);
               if (state == 1) {
                  get<0>(item) = 0;   // Set Active flag to 0
  
                  // Finish the MD5 checksum
                  md5_state_t state = get<2>(item);
                  unsigned char md5[16];
                  md5_finish (&state, md5);  
  
                  // Add MD5 in hexadecimal format in tuplet
                  ostringstream formatted_line;
                  for (int i = 0; i < 16; ++i) {
                      formatted_line << hex << setw(2) << setfill('0') << static_cast<int>(md5[i]);
                  }
                  get<3>(item)=formatted_line.str();
               }
        }
    };
  // -----------------------------------------------------------------------------------------------------------------------------
  // main checksum computation function
  // read the input deck line by line , commpute checksums between CHECKSUM/START and CHECKSUM/END
  // ------------------------------------------------------------------------------------------------------------------------------
  // input:
  // filename,string : name of the file to be read
  // level,int    : recursion level (used to limit the number of include files)
  // output:
  // md5_states_tmp : list of checksums computed in the file
  // ------------------------------------------------------------------------------------------------------------------------------
  int  file_read(string filename,string deck_directory,int level,list<tuple<int,string, md5_state_t, string>> *md5_states_tmp){
  // -----------------------------------------------------------------------------------------------------------------------------
       string chksum_start=( "/CHECKSUM/START");
       string chksum_end=(   "/CHECKSUM/END");
       string chksum_include=( "#include ");
       fstream new_file;
       new_file.open(filename, ios::in);
       
       // Stop  after 15 levels of recursion
       if (level > 15) return 0;

       if ( !new_file.is_open() ) {
          return -1;
       }

       string line;
       while (getline(new_file, line)) {

          remove_carriage_return(line); // Remove carriage return characters
          // Search for /CHECKSUM/START keyword
         if (line == chksum_start) {
           string title;
           getline(new_file, title);
           remove_carriage_return(title); // Remove carriage return characters
           new_checksum(title,md5_states_tmp);
           continue;
         }
         // Search for /CHECKSUM/END keyword
         if (line == chksum_end) {
           end_checksum(md5_states_tmp);
           continue;
         }

         string comp=line.substr(0,chksum_include.length());
         if (comp == chksum_include) {
           // Process include files
           string include_file = line.substr(chksum_include.length());
           if (deck_directory.length() > 0){
              include_file = deck_directory+separator()+include_file; // Get the path of the file
           }
           if (debug){
              cout << "Include file: " << include_file << endl;
           }
        //   include_file.erase( remove(include_file.rbegin(), include_file.end(), ' '), include_file.end());
           // debug cout << "Include file: " << include_file << endl;
           file_read(include_file,deck_directory, level + 1,md5_states_tmp);
           continue;
         }

         if (line[0] == '#') {
           // Skip comment lines
           continue;
         }
         process_checksum(line,md5_states_tmp);
        
       }
       new_file.close();
       return 0;
      }

public:
   // --------------------------------------------------------------------------------------------------------   
   // constructor
   // --------------------------------------------------------------------------------------------------------
   MD5Checksum()
   // --------------------------------------------------------------------------------------------------------
   {};

   void MD5Checksum_parse(string filenam)  {
      list<tuple<int,string, md5_state_t, string>>  md5_states_tmp;
      string deck_directory = get_path(filenam); // Get the directory of the file
      file_read(filenam,deck_directory,0,&md5_states_tmp);
      finalize_checksum(&md5_states_tmp); // Finalize all active checksums
      // intvert the list to have it in deck order
      for (const auto& item : md5_states_tmp){
          md5_states.push_front(item); // Add the checksums to the main list
      }

      md5_states_tmp.clear(); // Clear the temporary list
   };

   // --------------------------------------------------------------------------------------------------------
   // CPP / Fortran interface : Get the number of checksums
   // -------------------------------------------------------------------------------------------------------- 
   void MD5Checksum_count(int * count)  {
   // --------------------------------------------------------------------------------------------------------
     *count= md5_states.size();
   }

   // --------------------------------------------------------------------------------------------------------
   // CPP / Fortran interface : Get the N-th checksum
   // --------------------------------------------------------------------------------------------------------
   // input:
   // N : checksum number to be retrieved
   // output:
   // checksum_title : title of the checksum
   // len_title : length of the checksum title
   // checksum : checksum value
   // len_checksum : length of the checksum value
   // --------------------------------------------------------------------------------------------------------
   void MD5Checksum_member(int * N,char* checksum_title,int *len_title,char* checksum,int * len_checksum)  {
   // --------------------------------------------------------------------------------------------------------
    int count= md5_states.size();
    if (*N > count) {
      cout << "Error: N=" << *N << " is greater than the number of checksums " << count << endl;
      checksum[0]='\0';
      checksum_title[0]='\0';
      *len_checksum=0;
      *len_title=0;
    }else{
      auto it = md5_states.begin();
      advance(it, *N-1); // Move iterator to the N-th element (0-based index)

      // Copy checksum_title
      int size_title = get<1>(*it).size();
      get<1>(*it).copy(checksum_title ,size_title);
      checksum_title[size_title]='\0';
      *len_title=size_title;

      // Copy checksum
      int size_checksum = get<3>(*it).size();
      get<3>(*it).copy(checksum ,size_checksum);
      checksum[size_checksum]='\0';
      *len_checksum=size_checksum;

      // cout << "Member " << *N << " Checksum : " << get<1>(*it) << " " <<  get<3>(*it) << endl;
    }
  }

   // --------------------------------------------------------------------------------------------------------
   // Get the list of all computed checksums 
   // --------------------------------------------------------------------------------------------------------
   // output:
   // computed checksums in hexadecimal format
   // --------------------------------------------------------------------------------------------------------
   list<string> get_checksums(){
   // --------------------------------------------------------------------------------------------------------
      list<string> checksums;
      for (const auto& item : md5_states){
        if (get<0>(item) == 0){
            string chksum_item=get<1>(item)+"_"+get<3>(item);
            checksums.push_back(chksum_item);
        }
      }
      return checksums;
   }

   // ------------------------
   // print the checksum list
   // ------------------------
   void print(){
   // ------------------------
      cout << "Checksum list " << endl;
      cout << "==============" << endl;
      for (const auto& item : md5_states){
        if (get<0>(item) == 0){
            cout << "Checksum : " << get<1>(item) << " " <<  get<3>(item) << endl;
        }
      }
   }

// End of class MD5Checksum
};


// Class to verify the checksum of a starter input file
// The class will parse the .out files and compare the checksums with the ones computed in the input deck
// The class will also compute the checksum of the input deck if not already done
class Verify_checksum {

  public:
  // Debug flag
  // Set to 1 to enable debug mode, 0 to disable it
#ifdef DEBUG
  int debug=1;
#else
  int debug=0;
#endif

  private:
  // -----------------------------------------------------------------------------------
  // Tool : get directory path from a file path
  // -----------------------------------------------------------------------------------
  std::string get_path(const std::string& filepath) {
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
  string format_as_4_digits(int number) {
  // -----------------------------------------------------------------------------------
      ostringstream oss;
      oss << setw(4) << setfill('0') << number;
      return oss.str();
  }

  // -----------------------------------------------------------------------------------
  // Tool : Return the separator for the file path according to the OS
  // output:
  // separator : "/" for Unix, "\" for Windows
  // -----------------------------------------------------------------------------------
  string separator(){
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
  int compare_lists(list<string> list1, list<string> list2){
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
  list<string> parse_out_file(fstream *new_file){
  // -----------------------------------------------------------------------------------
      list<string> checksum_list;
      
      int not_found=1;
      string line;
      while (getline(*new_file, line) && not_found) {
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
  // Parse all .out files in the directory and compare the checksums with the ones computed in the input deck
  // input:
  // directory : directory where the .out files are located
  // rootname  : rootname of the .out files (without run number and extension)
  // checksum_list : list of checksums computed in the input deck
  // output:
  // list of tuples (filename, checksum match)
  // The checksum match is 1 if the checksums are equal, 0 if they are not equal
  // -------------------------------------------------------------------------------------------------------------------------------------------------
  void parse_output_files(string directory, string rootname,list<string> deck_checksum_list, list<tuple<string,list<string>>> *checksum_list){
  // -------------------------------------------------------------------------------------------------------------------------------------------------
    list<tuple<string,int>> checksum_compared_list;
    string sep=separator();
    int run_number=0;
    int found_out_file=1;

    while (found_out_file){
      
      // Construct the output file name
      string st_runnumber = format_as_4_digits(run_number);
      string outfile;
      if ( directory.length() > 0 ){
          outfile = directory + sep + rootname + "_" + st_runnumber + ".out";
      }else{
          outfile = rootname + "_" + st_runnumber + ".out";
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

  public:

  Verify_checksum()    // Constructor
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
  list<tuple<string,list<string>>> get_checksum(string starter_input_file){
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
    parse_output_files(directory, rootname, deck_checksum_list,&checksum_list);

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

}; 
// End of class Verify_checksum
// ------------------------------------------------------------------------------------------------------------------------


// ------------------------------------------------------------------------------------------------------------------------
// C/Fortran interface to the C++ class MD5Checksum
// The interface is used to create the checksum from the input deck and to read the checksums
// To be called from Starter.

MD5Checksum md;

extern "C" {
  void checksum_creation(int * len_filename,char* filename) {
    int i;
    char * c_filename = (char*) malloc(*len_filename+1);
    for (i=0; i<*len_filename; i++){
      c_filename[i]=filename[i];
    }
    c_filename[*len_filename]='\0';
    string cpp_filename(c_filename);
    free(c_filename);
    md.MD5Checksum_parse(cpp_filename);
  }

  void checksum_creation_(int * len_filename,char* filename) {
    checksum_creation(len_filename,filename);
  }

  void _FCALL CHECKSUM_CREATION(int * len_filename,char* filename) {
    checksum_creation(len_filename,filename);
  }

  void checksum_count(int * count) {
    md.MD5Checksum_count(count);
  }
  void checksum_count_(int * count) {
    checksum_count(count);
  }
  void _FCALL CHECKSUM_COUNT(int * count) {
    checksum_count(count);
  }

  void  checksum_read(int * count,char* checksum_title,int *len_title,char* checksum,int * len_checksum) {
    md.MD5Checksum_member(count,checksum_title,len_title,checksum,len_checksum);
  }
  void checksum_read_(int * count,char* checksum_title,int *len_title,char* checksum,int * len_checksum) {
    md.MD5Checksum_member(count,checksum_title,len_title,checksum,len_checksum);
  }
  void _FCALL CHECKSUM_READ(int * count,char* checksum_title,int *len_title,char* checksum,int * len_checksum) {
    md.MD5Checksum_member(count,checksum_title,len_title,checksum,len_checksum);
  }

}


// ------------------------------------------------------------------------------------------------------------------------
// Main Standalone function to test the checksum tool
// The function will read the input file and compute the checksums
// The function will also parse the .out files and compare the checksums with the ones computed in the input deck
// The function will print the results to the console
// To buimd in Standalone mode, use the following command:
// g++ -DMAIN -DDEBUG -no-pie -o ../exec/chksum -I/mnt/d/WS/GitHub/OpenRadioss_VS/OpenRadioss/extlib/md5/include source/output/checksum/checksum_model.cpp  /mnt/d/WS/GitHub/OpenRadioss_VS/OpenRadioss/extlib/md5/linux64/libmd5.a   -std=c++14
// Add -DDEBUG for additional debug information
// ------------------------------------------------------------------------------------------------------------------------
#ifdef MAIN
int main(int argc, char *argv[])
{
  Verify_checksum verify_chksum_tool;
  cout << endl;
  cout << "Filename to process: "<< argv[1] << endl;
  string file=string(argv[1]);

  list<tuple<string,list<string>>>  list = verify_chksum_tool.get_checksum(file);
  
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