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
   MD5Checksum()
   {};

   void MD5Checksum_parse(std::string filenam)  {
   // Main constructor
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
  std::cout << "Filename to process: "<< argv[1] << std::endl;
  std::string file=std::string(argv[1]);
  md.MD5Checksum_parse(file);
  std::cout <<  std::endl;
  md.print();
}
#endif