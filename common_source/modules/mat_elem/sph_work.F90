!Copyright>        OpenRadioss
!Copyright>        Copyright (C) 1986-2024 Altair Engineering Inc.
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
      !||====================================================================
      !||    prop_param_mod         ../common_source/modules/mat_elem/prop_param_mod.F90
      !||--- called by ------------------------------------------------------
      !||    mat_elem_mod           ../common_source/modules/mat_elem/mat_elem_mod.F90
      !||    mulaw                  ../engine/source/materials/mat_share/mulaw.F90
      !||--- uses       -----------------------------------------------------
      !||    names_and_titles_mod   ../common_source/modules/names_and_titles_mod.F
      !||    ply_param_mod          ../common_source/modules/mat_elem/ply_param_mod.F90
      !||====================================================================
      module sph_work_mod
!=======================================================================================      
!! \brief  module to define type for buffers use in SPHPREP and SPHINT
!! \details 
#include "my_real.inc"

         type sph_work_
            integer, dimension(:), allocatable :: wreduce
            integer, dimension(:), allocatable ::  itag
            double precision, dimension(:,:,:), allocatable :: as6, a6
            my_real, dimension(:,:), allocatable :: as
            my_real, dimension(:,:), allocatable :: asphr
         end type sph_work_



      contains 
           subroutine init_sph_work
      end module sph_work_mod



