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
Chd|  HM_READ_FAIL_USER             source/materials/fail/failuser/hm_read_fail_user.F
Chd|-- called by -----------
Chd|        HM_READ_FAIL                  source/materials/fail/hm_read_fail.F
Chd|-- calls ---------------
Chd|        ANCMSG                        source/output/message/message.F
Chd|        ARRET                         source/system/arret.F         
Chd|        HM_GET_INTV                   source/devtools/hm_reader/hm_get_intv.F
Chd|        HM_GET_STRING_INDEX           source/devtools/hm_reader/hm_get_string_index.F
Chd|        ST_USERLIB_LECR               source/user_interface/dyn_userlib.c
Chd|        USER_OUTPUT                   source/user_interface/user_output.F
Chd|        MESSAGE_MOD                   share/message_module/message_mod.F
Chd|        SUBMODEL_MOD                  share/modules1/submodel_mod.F 
Chd|====================================================================
      SUBROUTINE HM_READ_FAIL_USER(IRUP,IUSER_KEY,
     .                             USERL_AVAIL,
     .                             UPARAM,MAXUPARAM,NUPARAM,
     .                             NUVAR,IFUNC,MAXFUNC,NFUNC,
     .                             LSUBMODEL,
     .                             UNITAB_SUB,
     .                             MAT_ID,
     .                             ROOTNAME , ROOTNAME_LENGTH)
C-----------------------------------------------
C   ROUTINE DESCRIPTION :
C   ===================
C   Read user material failure - generic routine
C------------------------------------------------------------------
C   DUMMY ARGUMENTS DESCRIPTION:
C   ===================
C
C     NAME          DESCRIPTION                         
C
C     USERL_AVAIL   Flag if userlibrary was load
C     IS_AVAILABLE  Bool / Result of HM_interface
C     LSUBMODEL     SUBMODEL Structure.
C------------------------------------------------------------------
C
C-----------------------------------------------
C   M o d u l e s
C-----------------------------------------------
      USE MESSAGE_MOD
      USE SUBMODEL_MOD
      USE NAMES_AND_TITLES_MOD ,ONLY:NCHARLINE,LROOTNAME,NCHARTITLE
C-----------------------------------------------
C   I m p l i c i t   T y p e s
C-----------------------------------------------
#include      "implicit_f.inc"
C-----------------------------------------------
C   C o m m o n   B l o c k s
C-----------------------------------------------
#include      "units_c.inc"
C-----------------------------------------------
C   D u m m y   A r g u m e n t s
C-----------------------------------------------
      INTEGER IRUP
      INTEGER USERL_AVAIL
      INTEGER MAXUPARAM
      INTEGER NUPARAM 
      INTEGER NUVAR
      INTEGER NFUNC,MAXFUNC
      TYPE(SUBMODEL_DATA),INTENT(IN)      :: LSUBMODEL(*)
      INTEGER, DIMENSION(MAXFUNC)         :: IFUNC
      my_real, DIMENSION(MAXUPARAM)       :: UPARAM
      my_real, DIMENSION(4)               :: UNITAB_SUB
      CHARACTER(LEN=NCHARLINE)            :: IUSER_KEY
      INTEGER, INTENT(IN)                 :: ROOTNAME_LENGTH  ! INPUT deck rootname length
      CHARACTER(LEN=LROOTNAME),INTENT(IN) :: ROOTNAME         ! INPUT deck rootname

C-----------------------------------------------
C   L o c a l   V a r i a b l e s
C-----------------------------------------------
      CHARACTER(LEN=4096) :: SCR_FILE_NAME
      CHARACTER(LEN=NCHARLINE) :: RLINE
      CHARACTER (LEN=4) :: CRUP
      CHARACTER(LEN=NCHARTITLE) :: TITLE
      LOGICAL :: IS_AVAILABLE
      INTEGER NLINES,J,MAT_ID
      INTEGER SCR_FILE_NAME_LEN
!
      CHARACTER OPTION*256
      INTEGER SIZE
C-----------------------------------------------
      IF (USERL_AVAIL == 0)THEN
      ! ERROR to be printed & exit
        OPTION='/FAIL/'//IUSER_KEY
        SIZE=LEN_TRIM(OPTION)
        CALL ANCMSG(MSGID=1130,
     .              MSGTYPE=MSGERROR,C1=OPTION(1:SIZE),ANMODE=ANINFO)
        CALL ARRET(2)
      ENDIF

      CALL HM_GET_INTV ('Number_of_datalines' ,NLINES ,IS_AVAILABLE, LSUBMODEL)

      IF(NLINES > 0)THEN 

        ! Create tempo file  
        WRITE(CRUP,'(I4.4)')IRUP
        SCR_FILE_NAME='SI'//TRIM(ROOTNAME)//'_'//CRUP//'.scr'
        SCR_FILE_NAME_LEN=LEN_TRIM(SCR_FILE_NAME)
        OPEN(UNIT=30,FILE=TRIM(SCR_FILE_NAME),FORM='FORMATTED',RECL=NCHARLINE)

        ! Read & Dump in scratch file
        DO J=1,NLINES   
         CALL HM_GET_STRING_INDEX('arraydatalines', RLINE, J, NCHARLINE, IS_AVAILABLE)
         WRITE(30,FMT='(A)')TRIM(RLINE)
        ENDDO
        CLOSE(UNIT=30)
!
        CALL ST_USERLIB_LECR(IRUP,ROOTNAME,ROOTNAME_LENGTH,UPARAM,MAXUPARAM,NUPARAM,
     .                       NUVAR ,IFUNC,MAXFUNC,NFUNC,UNITAB_SUB,
     .                       MAT_ID)
        CALL USER_OUTPUT(IOUT,IRUP,ROOTNAME,ROOTNAME_LENGTH,1)
      ELSE
         ! Error MESSAGE_Mess
      ENDIF
!---------
      RETURN
      END
