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
module checksum_output_option_mod

!! \brief Engine checksum type
!! \details Hosts the checksums from input file.
!! \details item is to print them in output files : *.out, animation, H3D, TimeHistory
    use names_and_titles_mod , only : ncharline

    type checksum_option_
       integer checksum_count
       character(len=ncharline),dimension(:),allocatable :: checksums
    end type checksum_option_

contains
!! \brief reads checksum from result file
    !||====================================================================
    !||    checksum_option_read   
    !||--- called by ------------------------------------------------------
    !||    rdresb
    !||====================================================================
    subroutine checksum_option_read(checksum)
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
        type(checksum_option_), intent(inout) :: checksum
! ----------------------------------------------------------------------------------------------------------------------     
!                                                   Local variables
! ----------------------------------------------------------------------------------------------------------------------
        integer :: checksum_option_count
        integer :: i
        integer :: j
        integer :: checksum_digest_length
        integer,dimension(ncharline) :: checksum_digest
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Body
! ----------------------------------------------------------------------------------------------------------------------
        call read_i_c(checksum_option_count, 1)                !! Read number of checksums
        checksum%checksum_count = checksum_option_count

        allocate(checksum%checksums(checksum_option_count))
        checksum%checksums(1:checksum_option_count)(:)=''

        do i=1,checksum_option_count
            call read_i_c(checksum_digest_length, 1)
            call read_i_c(checksum_digest, checksum_digest_length)

            do j=1,checksum_digest_length
                checksum%checksums(i)(j:j) = char(checksum_digest(j))
            end do
        end do

       do i=1,checksum_option_count
            print *, 'checksum%checksums(',i,') = ', trim(checksum%checksums(i))
       end do 
    end subroutine checksum_option_read

    !! \brief reads checksum from result file
    !||====================================================================
    !||    checksum_option_write
    !||--- called by ------------------------------------------------------
    !||    rdresb
    !||====================================================================
    subroutine checksum_option_write(checksum)
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
                type(checksum_option_), intent(in) :: checksum
        ! ----------------------------------------------------------------------------------------------------------------------     
        !                                                   Local variables
        ! ----------------------------------------------------------------------------------------------------------------------
                integer :: i
                integer :: j
                integer :: checksum_digest_length
                integer,dimension(ncharline) :: checksum_digest
        ! ----------------------------------------------------------------------------------------------------------------------
        !                                                   Body
        ! ----------------------------------------------------------------------------------------------------------------------
                call write_i_c(checksum%checksum_count, 1)                !! write number of checksums
        
                do i=1,checksum%checksum_count

                    checksum_digest_length = len_trim(checksum%checksums(i))
                    do j=1,checksum_digest_length
                        checksum_digest(j)=ichar(checksum%checksums(i)(j:j))
                    end do
                    call write_i_c(checksum_digest_length, 1)
                    call write_i_c(checksum_digest, checksum_digest_length)

                end do
            end subroutine checksum_option_write

    !! \brief writes checksum in .out file
    !||====================================================================
    !||    checksum_option_write
    !||--- called by ------------------------------------------------------
    !||    rdresb
    !||====================================================================
            subroutine checksum_option_outfile(checksum)
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
                type(checksum_option_), intent(in) :: checksum
! ----------------------------------------------------------------------------------------------------------------------     
!                                                   Local variables
! ----------------------------------------------------------------------------------------------------------------------
                integer :: i
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Body
! ----------------------------------------------------------------------------------------------------------------------
                write(iout,'(a)') ''
                write(iout,'(a)') ' CHECKSUMS'
                write(iout,'(a)') ' ---------'
                write(iout,'(a)') ''

                do i=1,checksum%checksum_count
                    write(iout,'(a,a)') '    CHECKSUM : ',trim( checksum%checksums(i))
                end do
                write(iout,'(a)') ''
    
        end subroutine checksum_option_outfile        

end module checksum_output_option_mod

