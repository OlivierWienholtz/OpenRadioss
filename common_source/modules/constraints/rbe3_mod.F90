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
!===================================================================================================

      !||====================================================================
      !||    rbe3_mod   ../common_source/modules/rbe3_mod.F90
      !||--- called by ------------------------------------------------------
      !||====================================================================
      module rbe3_mod

         #include "my_real.inc"

         integer, parameter :: irbe3_variables = 10      !< first dimension of irbe3

         type rbe3_mpi
            integer, DIMENSION(:), ALLOCATABLE :: iad_rbe3  !< #entities to communicate / points to fr_rbe3
            integer, DIMENSION(:), ALLOCATABLE :: fr_rbe3   !< entities to communicate
         end type rbe3_mpi

         type rbe3_
           integer nrbe3
           integer,dimension(:,:),allocatable ::  irbe3  !< irbe3(irbe3_variables,nrbe3)  IRBE3 main array
           integer,dimension(:),allocatable   ::  lrbe3  !< lrbe3 array IRBE3 main array
           integer irotg                                 !< Global Rotational flag, >0 if one RBE3 has rot option, 0 else.
           integer irotg_sz                              !< Number of values to communicate : 5 if irotg==0, 10 else.
           type (rbe3_mpi) :: mpi

         end type rbe3_


      contains

      !! \brief allocate rbe3 type
      !! \details
      !||====================================================================
      !||    brent_algo     ../common_source/modules/root_finding_algo_mod.F90
      !||--- uses       -----------------------------------------------------
      !||    constant_mod   ../common_source/modules/constant_mod.F
      !||====================================================================
      subroutine allocate_rbe3( rbe3 )
         type(rbe3_) :: rbe3
         allocate( rbe3%irbe3(irbe3_variables,rbe3%nrbe3) )
      end subroutine allocate_rbe3

      end module rbe3_mod
