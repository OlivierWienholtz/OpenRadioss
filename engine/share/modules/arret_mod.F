Copyright>        OpenRadioss
Copyright>        Copyright (C) 1986-2023 Altair Engineering Inc.
Copyright>
Copyright>        This program is free software: you can redistribute it and/or modify
Copyright>        it under the terms of the GNU Affero General Public License as published by
Copyright>        the Free Software Foundation, either version 3 of the License, or
Copyright>        (at your option) any later version.
Copyright>
Copyright>        This program is distributed in the hope that it will be useful,
Copyright>        but WITHOUT ANY WARRANTY; without even the implied warranty of
Copyright>        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
Copyright>        GNU Affero General Public License for more details.
Copyright>
Copyright>        You should have received a copy of the GNU Affero General Public License
Copyright>        along with this program.  If not, see <https://www.gnu.org/licenses/>.
Copyright>
Copyright>
Copyright>        Commercial Alternative: Altair Radioss Software
Copyright>
Copyright>        As an alternative to this open-source version, Altair also offers Altair Radioss
Copyright>        software under a commercial license.  Contact Altair to discuss further if the
Copyright>        commercial version may interest you: https://www.altair.com/radioss/.
Chd|====================================================================
Chd|  ACCELERATION_DP_MOD           share/modules/acceleration_dp_mod.F
Chd|-- called by -----------
Chd|        RESOL                         source/engine/resol.F         
Chd|        SPMD_EXCH_A                   source/mpi/forces/spmd_exch_a.F
Chd|-- calls ---------------
Chd|====================================================================
      MODULE ARRET_MOD

        ! This module will hosts all variables need for ARRET() routine to 
        ! avoid passing tham as argument
C-----------------------------------------------
C   M o d u l e s
C-----------------------------------------------
        USE NAMES_AND_TITLES_MOD
C-----------------------------------------------

        ! ROOTNAME & CHRUN are used to pass names and titles
        TYPE (NAMES_AND_TITLES_)   :: NAMES_AND_TITLES 


      END MODULE ARRET_MOD