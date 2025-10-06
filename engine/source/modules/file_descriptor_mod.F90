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

!! \brief  Module intent is to provide a common location for all file descriptors
!||====================================================================
!||    file_descriptor_mod             ../engine/source/modules/file_descriptor_mod.F90
!||--- called by ------------------------------------------------------
!||    arret                           ../engine/source/system/arret.F
!||    checksum_option_checksum_file   ../common_source/modules/output/checksum_mod.F90
!||    checksum_option_outfile         ../common_source/modules/output/checksum_mod.F90
!||    checksum_restart_read           ../common_source/modules/output/checksum_mod.F90
!||    checksum_restart_write          ../common_source/modules/output/checksum_mod.F90
!||    mulawc                          ../engine/source/materials/mat_share/mulawc.F90
!||    pblast_alloc_error              ../common_source/modules/loads/pblast_mod.F90
!||    pblast_parameters__air_burst    ../common_source/modules/loads/pblast_mod.F90
!||    radioss2                        ../engine/source/engine/radioss2.F
!||    sigeps88                        ../engine/source/materials/mat/mat088/sigeps88.F90
!||    sigeps88c                       ../engine/source/materials/mat/mat088/sigeps88c.F90
!||    sigeps90                        ../engine/source/materials/mat/mat090/sigeps90.F
!||====================================================================
      module file_descriptor_mod

        ! Fortran file descriptor / same as units_c.inc
        ! --------------------------
      implicit none
        integer, parameter :: istdo=6
        integer, parameter :: iout=7
        ! Files
        integer, parameter :: restart=2           ! Restart file
        integer, parameter :: iuhis=3             ! Time history file
        integer, parameter :: iuhi_1=31           ! Mulitple Time history TA01A / _a.thy
        integer, parameter :: iuhi_2=32           ! Mulitple Time history T01B / _b.thy
        integer, parameter :: iuhi_3=33           ! Mulitple Time history T01C / _c.thy
        integer, parameter :: iuhi_4=34           ! Mulitple Time history T01D / _d.thy
        integer, parameter :: iuhi_5=35           ! Mulitple Time history T01E / _e.thy
        integer, parameter :: iuhi_6=36           ! Mulitple Time history T01F / _f.thy
        integer, parameter :: iuhi_7=37           ! Mulitple Time history T01G / _g.thy
        integer, parameter :: iuhi_8=38           ! Mulitple Time history T01H / _h.thy
        integer, parameter :: iuhi_9=39           ! Mulitple Time history TT01I / _i.thy
        integer, parameter :: iugeo=4             ! State file .sta / Outp file .sty
        integer, parameter :: icheckd=40          ! CHECK_DATA file (checkpoint restart)
        integer, parameter :: iunoi=10            ! Noise reading _@.thy
        integer, parameter :: iusc1=9             ! input scratch file (.tmp)
        integer, parameter :: iusc2=30            ! input scratch file 2 (.tmp)
        integer, parameter :: iusc3=50            ! Control file (.ctl)
        integer, parameter :: iuinimap=21         ! Inimap file (.inimap)
        integer, parameter :: IUDYNAIN=19833333   ! .dynain file
        ! Debug files
        integer, parameter :: idbg5=67            ! .adb, vdb,xdb file
        integer, parameter :: idbg8=68            ! .tdb (temp) file
        !
        integer, parameter :: ifxm=25             ! .tmp file for flexible bodies (main)
        integer, parameter :: ifxs=26             ! .tmp file for flexible bodies (secondary)
        integer, parameter :: ifixm=23            ! Eigenvalue file
        integer, parameter :: ifixm2=24           ! Eigenvalue file
        integer, parameter :: ieigm=27            ! Eigenvalue file
        integer, parameter :: fchecksum = 4566

        ! IDs for cur_fil_c (C / write_routines.c )
        ! -----------------------------------------
        integer, parameter :: fd_bin_th = 1
        integer, parameter :: fd_bin_rd_rst = 0  ! Restart reading : radioss2.F / rdresa.F / rdresb.F
        integer, parameter :: fd_bin_wr_rst = 2  ! Restart writing : wrrestp.F
      end module file_descriptor_mod

