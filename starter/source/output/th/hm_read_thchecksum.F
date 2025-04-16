Copyright>        OpenRadioss
Copyright>        Copyright (C) 1986-2025 Altair Engineering Inc.
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
      !||====================================================================
      !||    hm_read_thchecksum           ../starter/source/output/th/hm_read_thchecksum.F
      !||--- called by ------------------------------------------------------
      !||    hm_read_thgrou           ../starter/source/output/th/hm_read_thgrou.F
      !||--- calls      -----------------------------------------------------
      !||    ancmsg                   ../starter/source/output/message/message.F
      !||    fretitl2                 ../starter/source/starter/freform.F
      !||    hm_get_int_array_index   ../starter/source/devtools/hm_reader/hm_get_int_array_index.F
      !||    hm_get_intv              ../starter/source/devtools/hm_reader/hm_get_intv.F
      !||    hm_thvarc                ../starter/source/output/th/hm_read_thvarc.F
      !||    hord                     ../starter/source/output/th/hord.F
      !||    r2r_exist                ../starter/source/coupling/rad2rad/routines_r2r.F
      !||    zeroin                   ../starter/source/system/zeroin.F
      !||--- uses       -----------------------------------------------------
      !||    format_mod               ../starter/share/modules1/format_mod.F90
      !||    hm_option_read_mod       ../starter/share/modules1/hm_option_read_mod.F
      !||    message_mod              ../starter/share/message_module/message_mod.F
      !||    submodel_mod             ../starter/share/modules1/submodel_mod.F
      !||====================================================================
      SUBROUTINE HM_READ_THCHECKSUM(
     1      ITYP  ,KEY    ,
     3      IAD   ,IFI    ,ITHGRP,ITHBUF ,
     4      NV    ,VARE       ,
     5      NSNE,
     6      LITHBUFMX)
C
        USE MESSAGE_MOD
        USE SUBMODEL_MOD
        USE HM_OPTION_READ_MOD
        USE NAMES_AND_TITLES_MOD , ONLY : NCHARTITLE
        USE FORMAT_MOD , ONLY : FMW_I_A
C-----------------------------------------------
C   I m p l i c i t   T y p e s
C-----------------------------------------------
#include      "implicit_f.inc"
C-----------------------------------------------
C   C o m m o n   B l o c k s
C-----------------------------------------------
#include      "scr03_c.inc"
#include      "scr17_c.inc"
#include      "units_c.inc"
#include      "param_c.inc"
#include      "r2r_c.inc"
#include      "tabsiz_c.inc"
C-----------------------------------------------
C   D u m m y   A r g u m e n t s
C-----------------------------------------------
        INTEGER ITYP,INOPT1,
     .          ITHGRP(NITHGR),ITHBUF(LITHBUFMX),
     .          IFI,IAD,NV,NSNE 
        INTEGER,INTENT(IN) :: LITHBUFMX
        CHARACTER*10 VARE(NV),KEY
C-----------------------------------------------
C   L o c a l   V a r i a b l e s
C-----------------------------------------------
        INTEGER J,JJ, I,ISU,ID,NNE,NOSYS,J10(10),NTOT,KK,IER,
     .          OK,IGRS,NSU,K,L,JREC,CONT,IAD0,IADV,NTRI,
     .          IFITMP,IADFIN,NVAR,M,N,IAD1,IAD2,ISK,IPROC,
     .          IDSMAX,IDS,IDS_OBJ1,HM_NTHCHECKSUM
        CHARACTER(LEN=NCHARTITLE)::TITR
        CHARACTER, DIMENSION(10) :: VAR
        LOGICAL, DIMENSION(:), ALLOCATABLE :: FOUND
        LOGICAL :: IS_AVAILABLE
        INTEGER :: LEN_TITLE
        INTEGER :: LEN_CHECKSUM
        CHARACTER(LEN=NCHARLINE):: CHECKSUM_TITLE
        CHARACTER(LEN=64):: CHECKSUM
C-----------------------------------------------
C   E x t e r n a l   F u n c t i o n s
C-----------------------------------------------
        INTEGER,EXTERNAL :: HM_THVARC,R2R_EXIST
C-----------------------------------------------
        IS_AVAILABLE = .FALSE.
        NSNE = 0
        ! ID of the /TH
        ID = ITHGRP(1)
        ! Title of the /TH
        CALL FRETITL2(TITR,ITHGRP(NITHGR-LTITR+1),LTITR)
        ! Type of the /TH
        ITHGRP(2)=ITYP
        ITHGRP(3)=0
        IFITMP=IFI+1000
c
        ! Number of variables indicated by the user
        CALL CHECKSUM_COUNT(HM_NTHCHECKSUM)
        NVAR = 1
        ITHBUF(IAD) = 1
c
        ! Number of Objects IDs
        IDSMAX = HM_NTHCHECKSUM
        IDS_OBJ1 = 1
c
        ! Filling tables
        ITHGRP(6) = NVAR
        ITHGRP(7) = IAD
        IAD       = IAD+NVAR
        IFI       = IFI+NVAR
        NNE       = IDSMAX
        ITHGRP(4) = NNE
        ITHGRP(5) = IAD
        IAD2      = IAD+3*NNE
        ITHGRP(8) = IAD2
        NNE = 0    
C
        ! Loop over Objects IDs
        DO K = 1,IDSMAX
          IDS = 1
          IF (NSUBDOM > 0) THEN 
            IF (R2R_EXIST(ITYP,IDS) == 0) CYCLE
          ENDIF
          N = 1
          NNE  = NNE + 1
          NSNE = NSNE + 1
          ITHBUF(IAD) = N
          IAD = IAD+1
        ENDDO
C
        ITHGRP(4) = NNE
        IAD2      = ITHGRP(5)+3*NNE
        ITHGRP(8) = IAD2
        IFI       = IFI+3*NNE+40*NNE
        IAD       = ITHGRP(5)     
C
        DO I = 1,NNE
          N = ITHBUF(IAD)
              
          CHECKSUM_TITLE = ' '
          CHECKSUM = ' '
          CALL CHECKSUM_READ(I,CHECKSUM_TITLE,LEN_TITLE,CHECKSUM,LEN_CHECKSUM)    
          TITR = CHECKSUM_TITLE(1:LEN_TITLE)//'_'//CHECKSUM(1:LEN_CHECKSUM)

          ITHBUF(IAD+2*NNE) = I
          CALL FRETITL(TITR,ITHBUF(IAD2),LTITR)
          IAD=IAD+1
          IAD2=IAD2+40

        ENDDO    
C
        IAD = IAD2
C=======================================================================
C PRINTOUT
C=======================================================================
        IF(IPRI<1) RETURN
C
        N = ITHGRP(4)
        IAD1 = ITHGRP(5)
        NVAR=ITHGRP(6)
        IAD0=ITHGRP(7)
        IAD2=ITHGRP(8)
        WRITE(IOUT,'(//)')
        CALL FRETITL2(TITR,ITHGRP(NITHGR-LTITR+1),LTITR)
        WRITE(IOUT,'(A,I10,3A,I3,A,I5,2A)')' TH GROUP:',ITHGRP(1),',',TRIM(TITR),',',NVAR,' VAR',N, KEY,':'
        WRITE(IOUT,'(A)')' -------------------'
        WRITE(IOUT,'(10A10)')(VARE(ITHBUF(J)),J=1,NVAR)
        WRITE(IOUT,'(3A)')'    ',KEY,'        NAME '
        DO K=IAD1,IAD1+N-1
          CALL FRETITL2(TITR,ITHBUF(IAD2),40)
          IAD2=IAD2+40
          WRITE(IOUT,'(I10,X,A)')K-IAD1+1, TITR(1:LEN_TRIM(TITR))
        ENDDO
C
        RETURN
      END
