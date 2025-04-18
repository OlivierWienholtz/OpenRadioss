!Copyright>        OpenRadioss
!Copyright>        Copyright (C) 1986-2025 Altair Engineering Inc.
!Copyright>
!Copyright>        This program is free software: you can redistribute it and/or modify
!Copyright>        it under the terms of the GNU Affero General Public License as published by
!Copyright>        the Free Software Foundation, either version 3 of the License, or
!Copyright>        (at your option) any later version.
!Copyright>
!Copyright>        This program is distributed in the hope that it will be useful,
!Copyright>        but WITHOUT ANY WARRANTY; without even the implied warranty of
!Copyright>        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!Copyright>        GNU Affero General Public License for more details.
!Copyright>
!Copyright>        You should have received a copy of the GNU Affero General Public License
!Copyright>        along with this program.  If not, see <https://www.gnu.org/licenses/>.
!Copyright>
!Copyright>
!Copyright>        Commercial Alternative: Altair Radioss Software
!Copyright>
!Copyright>        As an alternative to this open-source version, Altair also offers Altair Radioss
!Copyright>        software under a commercial license.  Contact Altair to discuss further if the
!Copyright>        commercial version may interest you: https://www.altair.com/radioss/.
module checksum_starter_option_mod

contains
!! \brief Compute MD5 checksum of input file sections.
!! \details Section starts with /CHECKSUM/START and ends with /CHECKSUM/END.
!! \details The result is a list of MD5 checksums for each sections.
!! \details This list is add in any Output files : .out, animation, H3D, TimeHistory, etc.
      !||====================================================================
      !||    checksum_option   ../starter/source/output/checksum/checksum_option.F90
      !||--- called by ------------------------------------------------------
      !||    lectur                 ../starter/source/model/sets/fill_igr.F
      !||====================================================================
       subroutine hm_read_checksum(LENI,INPUT,LENP,PATH)
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Modules
! ----------------------------------------------------------------------------------------------------------------------
       use file_descriptor_mod
       use names_and_titles_mod    
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Implicit none
! ----------------------------------------------------------------------------------------------------------------------
       implicit none
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Arguments
! ----------------------------------------------------------------------------------------------------------------------
       integer, intent(in) :: LENI
       integer, intent(in) :: LENP
       character(len=LENI), intent(in) :: INPUT
       character(len=LENP), intent(in) :: PATH
! ----------------------------------------------------------------------------------------------------------------------     
!                                                   Local variables
! ----------------------------------------------------------------------------------------------------------------------
       integer :: i
       integer :: checksum_option_count
       integer :: checksum_digest_count

       integer :: len_title
       integer :: len_checksum
       character(len=ncharline):: checksum_title
       character(len=64):: checksum


! ----------------------------------------------------------------------------------------------------------------------
!                                                   Body
! ----------------------------------------------------------------------------------------------------------------------
       call hm_option_count('/CHECKSUM/START', checksum_option_count)
       call checksum_count(checksum_digest_count)
       if (checksum_option_count > 0) then
            call checksum_creation(LENP+LENI,PATH(1:LENP)//INPUT(1:LENI))
            call checksum_count(checksum_digest_count)
            write(iout,'(a)') ''
            write(iout,'(a)') ''
            write(iout,'(a)') '    CHECKSUMS'
            write(iout,'(a)') '    ---------'
            write(iout,'(a)') ''
            do i=1,checksum_digest_count
                call checksum_read(i,checksum_title,len_title,checksum,len_checksum)
                write(iout,'(a,a,a,a)') '    CHECKSUM : ',checksum_title(1:len_title), '_',checksum(1:len_checksum)
            end do
       endif
       end subroutine hm_read_checksum

!! \brief Writes the MD5 checksum in Restart files
      !||====================================================================
      !||    checksum_restart   ../starter/source/output/checksum/checksum_option.F90
      !||--- called by ------------------------------------------------------
      !||    lectur                 ../starter/source/model/sets/fill_igr.F
      !||====================================================================
       subroutine checksum_restart()
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Modules
! ----------------------------------------------------------------------------------------------------------------------
              use names_and_titles_mod
              use file_descriptor_mod
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Implicit none
! ----------------------------------------------------------------------------------------------------------------------
              implicit none
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Arguments
! ----------------------------------------------------------------------------------------------------------------------
! ----------------------------------------------------------------------------------------------------------------------     
!                                                   Local variables
! ----------------------------------------------------------------------------------------------------------------------
              integer :: i,j
              integer :: checksum_digest_count
       
              integer :: len_title
              integer :: len_checksum
              character(len=ncharline):: checksum_title
              character(len=64):: checksum
              integer,dimension(ncharline):: i_checksum_title
              integer,dimension(64):: i_checksum
              character(len=ncharline):: assembled_checksum
              integer,dimension(ncharline):: i_assembled_checksum
              integer :: assembled_checksum_length
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Body
! ----------------------------------------------------------------------------------------------------------------------
       call checksum_count(checksum_digest_count)
       call  write_i_c(checksum_digest_count,1)
       if (checksum_digest_count > 0) then

            do i=1,checksum_digest_count

                call checksum_read(i,checksum_title,len_title,checksum,len_checksum)

                assembled_checksum(1:ncharline)=''
                assembled_checksum=checksum_title(1:len_title)//'_'//checksum(1:len_checksum)
                assembled_checksum_length=len_title+len_checksum+1
                ! Transform assembled_checksum_length to integer array
                do j=1,assembled_checksum_length
                     i_assembled_checksum(j)=ichar(assembled_checksum(j:j))
                end do

                call write_i_c(assembled_checksum_length,1)
                call write_i_c(i_assembled_checksum,assembled_checksum_length)
            end do

       endif
       end subroutine checksum_restart
end module checksum_starter_option_mod
