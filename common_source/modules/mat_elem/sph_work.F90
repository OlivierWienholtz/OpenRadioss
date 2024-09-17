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
            integer, dimension(:), allocatable :: wreduce            ! sphprep
            !
            integer, dimension(:), allocatable ::  itag              ! splissv
            double precision, dimension(:,:,:), allocatable :: as6   ! splissv
            double precision, dimension(:,:,:), allocatable ::  a6   ! splissv
            my_real, dimension(:,:), allocatable :: as               ! splissv
            my_real, dimension(:,:), allocatable :: asphr            ! splissv
            !
            my_real, DIMENSION(:), ALLOCATABLE :: WT                 ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: WGRADT             ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: WLAPLT             ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: LAMBDA             ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: WGRADTSM           ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: WTR                ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: LAMBDR             ! forintp
            my_real, DIMENSION(:), ALLOCATABLE :: WASIGSM            ! forintp
            my_real, DIMENSION(:,:), ALLOCATABLE :: WAR              ! forintp
            my_real, DIMENSION(:,:), ALLOCATABLE :: WGR              ! forintp
            my_real, DIMENSION(:,:), ALLOCATABLE :: WAR2             ! forintp
            my_real, DIMENSION(:,:), ALLOCATABLE :: STAB             ! forintp
         end type sph_work_

      contains 
! ======================================================================================================================
!                                                   init_sph_work
! ======================================================================================================================

         subroutine allocate_sph_work(sph_work,                              &
       &                              flag_wreduce,size_wreduce,             &
       &                              flag_sol_to_sph, size_itag,            &
       &                              size_as6, size_a6, size_as )
!=======================================================================================
!! \brief  subroutine to allocate the buffers used in SPHPREP and SPHINT
         use my_alloc_mod
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Implicit none
! ----------------------------------------------------------------------------------------------------------------------
         implicit none
!-----------------------------------------------
!   g l o b a l   p a r a m e t e r s
!-----------------------------------------------
#include "my_real.inc"
! ----------------------------------------------------------------------------------------------------------------------
!                                                   Arguments
! ----------------------------------------------------------------------------------------------------------------------
           integer,intent(in) :: size_wreduce
           integer,intent(in) :: flag_wreduce
           integer,intent(in) :: flag_sol_to_sph
           integer,intent(in) :: size_itag
           integer,intent(in) :: size_as6
           integer,intent(in) :: size_a6
           integer,intent(in) :: size_as
           type(sph_work_) :: sph_work

           if (flag_wreduce > 0) call my_alloc(sph_work%wreduce,size_wreduce)
           if (flag_sol_to_sph > 0) then
                 call my_alloc(sph_work%itag,size_itag)
                 allocate(sph_work%as6(6,3,8*size_as6))
                 allocate(sph_work%a6 (6,3,size_a6))
                 allocate(sph_work%as(3,8*size_as))
           endif
         end subroutine allocate_sph_work

      end module sph_work_mod



