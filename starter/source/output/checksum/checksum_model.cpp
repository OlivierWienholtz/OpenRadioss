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
#define _FCALL 


class MD5Checksum {
std::list<std::tuple<int,std::string, md5_state_t, std::string>>  md5_states;     // List of options : active flag,id, title, checksum digest
private:

  void new_checksum( std::string title){
  // CHECKSUM/START was met, create a new checksum state
    md5_state_t new_md5;
    md5_init(&new_md5);
    std::string md5_digest(16,'0');
    md5_states.push_front(std::make_tuple(1,title,new_md5,md5_digest));
  };

  void process_checksum(std::string line){
  // Add line to all active MD5 digests
      for (auto& item : md5_states ) {
         if (std::get<0>(item) == 1){
            md5_state_t state = std::get<2>(item);
            md5_append( &state, (const md5_byte_t *) line.c_str(), line.length() );
            std::get<2>(item) = state;
         }
        }
  };

  void end_checksum(){
  // Finish the MD5 checksum for the last active state
      int state=-1;
      for (auto& item : md5_states ) {
            state=std::get<0>(item);
             if (state == 1) {
                std::get<0>(item) = 0;   // Set Active flag to 0

                // Finish the MD5 checksum
                md5_state_t state = std::get<2>(item);
                unsigned char md5[16];
                md5_finish (&state, md5);  

                // Add MD5 in hexadecimal format in tuplet
                std::ostringstream formatted_line;
                for (int i = 0; i < 16; ++i) {
                    formatted_line << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(md5[i]);
                }
                std::get<3>(item)=formatted_line.str();
                break;
             }
      }
  };

  int  file_read(std::string filename,int level){
  // Read the file and process it line by line
       std::string chksum_start=( "/CHECKSUM/START");
       std::string chksum_end=(   "/CHECKSUM/END");
       std::string chksum_include=( "#include ");
       std::fstream new_file;
       new_file.open(filename, std::ios::in);
       
       // Stop  after 15 levels of recursion
       if (level > 15) return 0;

       if ( !new_file.is_open() ) {
          return -1;
       }

       std::string line;
       while (std::getline(new_file, line)) {

         // Search for /CHECKSUM/START keyword
         if (line == chksum_start) {
           std::string title;
           std::getline(new_file, title);
           new_checksum(title);
           continue;
         }
         // Search for /CHECKSUM/END keyword
         if (line == chksum_end) {
           end_checksum();
           continue;
         }

         std::string comp=line.substr(0,chksum_include.length());
         if (comp == chksum_include) {
           // Process include files
           std::string include_file = line.substr(chksum_include.length());
           include_file.erase(remove(include_file.begin(), include_file.end(), ' '), include_file.end());
           // debug std::cout << "Include file: " << include_file << std::endl;
           file_read(include_file, level + 1);
           continue;
         }

         if (line[0] == '#') {
           // Skip comment lines
           continue;
         }
         process_checksum(line);
        
       }
       new_file.close();
       return 0;
      }

public:
   // constructor
   MD5Checksum()
   {};

   void MD5Checksum_parse(std::string filenam)  {
      file_read(filenam,0);
   };

   void MD5Checksum_count(int * count)  {
     *count= md5_states.size();
   }

   void MD5Checksum_member(int * N,char* checksum_title,int *len_title,char* checksum,int * len_checksum)  {
    int count= md5_states.size();
    if (*N > count) {
      std::cout << "Error: N=" << *N << " is greater than the number of checksums " << count << std::endl;
      checksum[0]='\0';
      checksum_title[0]='\0';
      *len_checksum=0;
      *len_title=0;
    }else{
      auto it = md5_states.begin();
      std::advance(it, *N-1); // Move iterator to the N-th element (0-based index)

      // Copy checksum_title
      int size_title = std::get<1>(*it).size();
      std::get<1>(*it).copy(checksum_title ,size_title);
      checksum_title[size_title]='\0';
      *len_title=size_title;

      // Copy checksum
      int size_checksum = std::get<3>(*it).size();
      std::get<3>(*it).copy(checksum ,size_checksum);
      checksum[size_checksum]='\0';
      *len_checksum=size_checksum;

      // std::cout << "Member " << *N << " Checksum : " << std::get<1>(*it) << " " <<  std::get<3>(*it) << std::endl;
    }
  }

   void print(){
      // Print the checksum list
      std::cout << "Checksum list " << std::endl;
      std::cout << "==============" << std::endl;
      for (const auto& item : md5_states){
        if (std::get<0>(item) == 0){
            std::cout << "Checksum : " << std::get<1>(item) << " " <<  std::get<3>(item) << std::endl;
        }
      }
   }

   std::list<std::string> get_checksums(){
      std::list<std::string> checksums;
      for (const auto& item : md5_states){
        if (std::get<0>(item) == 0){
            std::string chksum_item=std::get<1>(item)+"_"+std::get<3>(item);
            checksums.push_back(chksum_item);
        }
      }
      return checksums;
   }


};


class Verify_checksum {
#ifdef DEBUG
  int debug=1;
#else
  int debug=0;
#endif

  private:
  std::string format_as_4_digits(int number) {
      std::ostringstream oss;
      oss << std::setw(4) << std::setfill('0') << number; // Format as 4 digits with leading zeros
      return oss.str();
  }

  int compare_lists(std::list<std::string> list1, std::list<std::string> list2){
      // Compare two lists of checksums
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
  std::list<std::string> parse_out_file(std::fstream *new_file){

      std::list<std::string> checksum_list;
      
      int not_found=1;
      std::string line;
      while (std::getline(*new_file, line) && not_found) {
        if (line == " CHECKSUMS" || line == "    CHECKSUMS") {                       // Engine output format has 1 space, Starter 
           if (std::getline(*new_file, line)){     // 2 blank lines
            if (std::getline(*new_file, line)){
              while( not_found && std::getline(*new_file, line) ){                   // Read all lines until "CHECKSUM :" is no more found
                 std::string comp=line.substr(0, 15);
                 if (comp == "    CHECKSUM : "){
                    
                    std::string checksum = line.substr(15);
                    checksum_list.push_back(checksum);

                    if (debug){
                      std::cout << "Checksum found: " << checksum << std::endl;
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

  std::string separator(){
    // Return the separator for the file path
    #ifdef _WIN64
      return "\\"; // Windows separator
    #else
      return "/";  // Unix separator
    #endif
  }


  std::list<std::tuple<std::string,int>>parse_output_files_compare(std::string directory, std::string rootname,std::list<std::string> checksum_list){
    
    std::list<std::tuple<std::string,int>> checksum_compared_list;
    std::string sep=separator();
    int run_number=0;
    int found_out_file=1;

    while (found_out_file){
      
      // Construct the output file name
      std::string st_runnumber = format_as_4_digits(run_number);
      std::string outfile = directory + sep + rootname + "_" + st_runnumber + ".out";


      std::fstream new_file;
      new_file.open(outfile, std::ios::in);

      if ( !new_file.is_open() ) {
          // std::cout << "Error: Unable to open file " << outfile << std::endl;
          found_out_file=0; // No more .out files to process
      }else{
             if (debug){
                std::cout << "Parsing file: " << outfile << std::endl;
             }
             std::list<std::string> checksum_list_out=parse_out_file( &new_file );
             new_file.close();
             int match;
             if (checksum_list_out.size() > 0){
                match = compare_lists(checksum_list, checksum_list_out);
             }else{
                match=0; // No checksum found in the output file
             }
             checksum_compared_list.push_back(std::make_tuple(outfile,match));
      run_number++;
      }
    }
    return checksum_compared_list;
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
  // list of checksums found in the .out file
  // -------------------------------------------------------------------------------
  std::list<std::tuple<std::string,int>>  compare_checksum(std::string starter_input_file){

    std::list<std::tuple<int,std::string>> checksum_compare_list;
    // Compute checksum from input deck
    MD5Checksum my_checksums;
    my_checksums.MD5Checksum_parse(starter_input_file);
    std::list<std::string> deck_checksum_list=my_checksums.get_checksums();


    // Extract directory, filename, extension, rootname from starter_input_file
    std::filesystem::path path(starter_input_file);
    std::string directory = path.parent_path().string();
    std::string filename  = path.filename().string();
    std::string extension = path.extension().string();

    std::string rootname;
    if (extension == ".rad"){
      rootname = filename.substr(0, filename.find_last_of('_'));
    }else{
      rootname = "unkown";
    }

    if (debug){
      std::cout <<  std::endl;
      std::cout << "Input file: " << starter_input_file << std::endl;
      std::cout << "Directory: " << directory << std::endl;
      std::cout << "Filename: " << filename << std::endl;
      std::cout << "Extension: " << extension << std::endl;    
      std::cout << "Rootname: " << rootname << std::endl;
      std::cout << std::endl;

      std::cout << "Commputed Checksum list from deck: " << std::endl;
      std::cout << "===================================" << std::endl; 
      for (const auto& item : deck_checksum_list){
        std::cout << item << std::endl;
      }
      std::cout << "==============================" << std::endl;
      std::cout << std::endl;
    }

    
    // Parse all .out files in the directory
    std::list<std::tuple<std::string,int>> out_list = parse_output_files_compare(directory, rootname, deck_checksum_list);
    return out_list;
  }

};


MD5Checksum md;

extern "C" {
  void checksum_creation(int * len_filename,char* filename) {
    int i;
    char * c_filename = (char*) malloc(*len_filename+1);
    for (i=0; i<*len_filename; i++){
      c_filename[i]=filename[i];
    }
    c_filename[*len_filename]='\0';
    std::string cpp_filename(c_filename);
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

#ifdef MAIN
int main(int argc, char *argv[])
{
  Verify_checksum verify_chksum_tool;
  std::cout << std::endl;
  std::cout << "Filename to process: "<< argv[1] << std::endl;
  std::string file=std::string(argv[1]);

  std::list<std::tuple<std::string,int>>  list = verify_chksum_tool.compare_checksum(file);
  std::cout << std::endl;
  std::cout << "Checksum list from output files: " << std::endl;
  std::cout << "==============================" << std::endl;
  for (const auto& item : list){
    std::cout << "File: " << std::get<0>(item) << " Checksum match: " << std::get<1>(item) << std::endl;
  }
  std::cout << "==============================" << std::endl;
  
}
#endif