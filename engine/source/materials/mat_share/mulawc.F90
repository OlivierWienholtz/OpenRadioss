!opyright>        OpenRadioss
!opyright>        Copyright (C) 1986-2024 Altair Engineering Inc.
!opyright>
!opyright>        This program is free software: you can redistribute it and/or modify
!opyright>        it under the terms of the GNU Affero General Public License as published by
!opyright>        the Free Software Foundation, either version 3 of the License, or
!opyright>        (at your option) any later version.
!opyright>
!opyright>        This program is distributed in the hope that it will be useful,
!opyright>        but WITHOUT ANY WARRANTY; without even the implied warranty of
!opyright>        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!opyright>        GNU Affero General Public License for more details.
!opyright>
!opyright>        You should have received a copy of the GNU Affero General Public License
!opyright>        along with this program.  If not, see <https://www.gnu.org/licenses/>.
!opyright>
!opyright>
!opyright>        Commercial Alternative: Altair Radioss Software
!opyright>
!opyright>        As an alternative to this open-source version, Altair also offers Altair Radioss
!opyright>        software under a commercial license.  Contact Altair to discuss further if the
!opyright>        commercial version may interest you: https://www.altair.com/radioss/.
 !||====================================================================
 !||    mulawc_mod   ../engine/source/materials/mat_share/mulawc.F
 !||--- called by ------------------------------------------------------
 !||    cmain3       ../engine/source/materials/mat_share/cmain3.F
 !||====================================================================
MODULE MULAWC_MOD
CONTAINS
   !||====================================================================
   !||    mulawc                    ../engine/source/materials/mat_share/mulawc.F
   !||--- called by ------------------------------------------------------
   !||    cmain3                    ../engine/source/materials/mat_share/cmain3.F
   !||--- calls      -----------------------------------------------------
   !||    ancmsg                    ../engine/source/output/message/message.F
   !||    arret                     ../engine/source/system/arret.F
   !||    fail_biquad_c             ../engine/source/materials/fail/biquad/fail_biquad_c.F
   !||    fail_changchang_c         ../engine/source/materials/fail/changchang/fail_changchang_c.F
   !||    fail_cockroft_c           ../engine/source/materials/fail/cockroft_latham/fail_cockroft_c.F
   !||    fail_energy_c             ../engine/source/materials/fail/energy/fail_energy_c.F
   !||    fail_fabric_c             ../engine/source/materials/fail/fabric/fail_fabric_c.F
   !||    fail_fld_c                ../engine/source/materials/fail/fld/fail_fld_c.F
   !||    fail_fld_xfem             ../engine/source/materials/fail/fld/fail_fld_xfem.F
   !||    fail_gene1_c              ../engine/source/materials/fail/gene1/fail_gene1_c.F
   !||    fail_hashin_c             ../engine/source/materials/fail/hashin/fail_hashin_c.F
   !||    fail_hc_dsse_c            ../engine/source/materials/fail/hc_dsse/fail_hc_dsse_c.F
   !||    fail_hoffman_c            ../engine/source/materials/fail/hoffman/fail_hoffman_c.F
   !||    fail_inievo_c             ../engine/source/materials/fail/inievo/fail_inievo_c.F
   !||    fail_johnson_c            ../engine/source/materials/fail/johnson_cook/fail_johnson_c.F
   !||    fail_johnson_xfem         ../engine/source/materials/fail/johnson_cook/fail_johnson_xfem.F
   !||    fail_maxstrain_c          ../engine/source/materials/fail/max_strain/fail_maxstrain_c.F
   !||    fail_nxt_c                ../engine/source/materials/fail/nxt/fail_nxt_c.F
   !||    fail_orthbiquad_c         ../engine/source/materials/fail/orthbiquad/fail_orthbiquad_c.F
   !||    fail_orthenerg_c          ../engine/source/materials/fail/orthenerg/fail_orthenerg_c.F
   !||    fail_orthstrain_c         ../engine/source/materials/fail/orthstrain/fail_orthstrain_c.F
   !||    fail_puck_c               ../engine/source/materials/fail/puck/fail_puck_c.F
   !||    fail_rtcl_c               ../engine/source/materials/fail/rtcl/fail_rtcl_c.F
   !||    fail_setoff_c             ../engine/source/materials/fail/fail_setoff_c.F
   !||    fail_setoff_npg_c         ../engine/source/materials/fail/fail_setoff_npg_c.F
   !||    fail_setoff_wind_frwave   ../engine/source/materials/fail/fail_setoff_wind_frwave.F
   !||    fail_syazwan_c            ../engine/source/materials/fail/syazwan/fail_syazwan_c.F
   !||    fail_tab2_c               ../engine/source/materials/fail/tabulated/fail_tab2_c.F
   !||    fail_tab_c                ../engine/source/materials/fail/tabulated/fail_tab_c.F
   !||    fail_tab_old_c            ../engine/source/materials/fail/tabulated/fail_tab_old_c.F
   !||    fail_tab_old_xfem         ../engine/source/materials/fail/tabulated/fail_tab_old_xfem.F
   !||    fail_tab_xfem             ../engine/source/materials/fail/tabulated/fail_tab_xfem.F
   !||    fail_tbutcher_c           ../engine/source/materials/fail/tuler_butcher/fail_tbutcher_c.F
   !||    fail_tbutcher_xfem        ../engine/source/materials/fail/tuler_butcher/fail_tbutcher_xfem.F
   !||    fail_tensstrain_c         ../engine/source/materials/fail/tensstrain/fail_tensstrain_c.F
   !||    fail_tsaihill_c           ../engine/source/materials/fail/tsaihill/fail_tsaihill_c.F
   !||    fail_tsaiwu_c             ../engine/source/materials/fail/tsaiwu/fail_tsaiwu_c.F
   !||    fail_visual_c             ../engine/source/materials/fail/visual/fail_visual_c.F
   !||    fail_wierzbicki_c         ../engine/source/materials/fail/wierzbicki/fail_wierzbicki_c.F
   !||    fail_wilkins_c            ../engine/source/materials/fail/wilkins/fail_wilkins_c.F
   !||    fail_wind_frwave          ../engine/source/materials/fail/alter/fail_wind_frwave.F
   !||    fail_wind_xfem            ../engine/source/materials/fail/alter/fail_wind_xfem.F
   !||    m25delam                  ../engine/source/materials/mat/mat025/m25delam.F
   !||    nvar                      ../engine/source/input/nvar.F
   !||    prony_modelc              ../engine/source/materials/mat/mat066/prony_modelc.F
   !||    putsignorc3               ../engine/source/elements/shell/coqueba/cmatc3.F
   !||    rotov                     ../engine/source/airbag/roto.F
   !||    sigeps01c                 ../engine/source/materials/mat/mat001/sigeps01c.F
   !||    sigeps02c                 ../engine/source/materials/mat/mat002/sigeps02c.F
   !||    sigeps104c                ../engine/source/materials/mat/mat104/sigeps104c.F
   !||    sigeps107c                ../engine/source/materials/mat/mat107/sigeps107c.F
   !||    sigeps109c                ../engine/source/materials/mat/mat109/sigeps109c.F
   !||    sigeps110c                ../engine/source/materials/mat/mat110/sigeps110c.F
   !||    sigeps112c                ../engine/source/materials/mat/mat112/sigeps112c.F
   !||    sigeps119c                ../engine/source/materials/mat/mat119/sigeps119c.F
   !||    sigeps121c                ../engine/source/materials/mat/mat121/sigeps121c.F
   !||    sigeps122c                ../engine/source/materials/mat/mat122/sigeps122c.F
   !||    sigeps125c                ../engine/source/materials/mat/mat125/sigeps125c.F90
   !||    sigeps158c                ../engine/source/materials/mat/mat158/sigeps158c.F
   !||    sigeps15c                 ../engine/source/materials/mat/mat015/sigeps15c.F
   !||    sigeps19c                 ../engine/source/materials/mat/mat019/sigeps19c.F
   !||    sigeps22c                 ../engine/source/materials/mat/mat022/sigeps22c.F
   !||    sigeps25c                 ../engine/source/materials/mat/mat025/sigeps25c.F
   !||    sigeps25cp                ../engine/source/materials/mat/mat025/sigeps25cp.F
   !||    sigeps27c                 ../engine/source/materials/mat/mat027/sigeps27c.F
   !||    sigeps32c                 ../engine/source/materials/mat/mat032/sigeps32c.F
   !||    sigeps34c                 ../engine/source/materials/mat/mat034/sigeps34c.F
   !||    sigeps35c                 ../engine/source/materials/mat/mat035/sigeps35c.F
   !||    sigeps36c                 ../engine/source/materials/mat/mat036/sigeps36c.F
   !||    sigeps42c                 ../engine/source/materials/mat/mat042/sigeps42c.F
   !||    sigeps43c                 ../engine/source/materials/mat/mat043/sigeps43c.F
   !||    sigeps44c                 ../engine/source/materials/mat/mat044/sigeps44c.F
   !||    sigeps45c                 ../engine/source/materials/mat/mat045/sigeps45c.F
   !||    sigeps48c                 ../engine/source/materials/mat/mat048/sigeps48c.F
   !||    sigeps52c                 ../engine/source/materials/mat/mat052/sigeps52c.F
   !||    sigeps55c                 ../engine/source/materials/mat/mat055/sigeps55c.F
   !||    sigeps56c                 ../engine/source/materials/mat/mat056/sigeps56c.F
   !||    sigeps57c                 ../engine/source/materials/mat/mat057/sigeps57c.F
   !||    sigeps58c                 ../engine/source/materials/mat/mat058/sigeps58c.F
   !||    sigeps60c                 ../engine/source/materials/mat/mat060/sigeps60c.F
   !||    sigeps62c                 ../engine/source/materials/mat/mat062/sigeps62c.F
   !||    sigeps63c                 ../engine/source/materials/mat/mat063/sigeps63c.F
   !||    sigeps64c                 ../engine/source/materials/mat/mat064/sigeps64c.F
   !||    sigeps65c                 ../engine/source/materials/mat/mat065/sigeps65c.F
   !||    sigeps66c                 ../engine/source/materials/mat/mat066/sigeps66c.F
   !||    sigeps69c                 ../engine/source/materials/mat/mat069/sigeps69c.F
   !||    sigeps71c                 ../engine/source/materials/mat/mat071/sigeps71c.F
   !||    sigeps72c                 ../engine/source/materials/mat/mat072/sigeps72c.F
   !||    sigeps73c                 ../engine/source/materials/mat/mat073/sigeps73c.F
   !||    sigeps76c                 ../engine/source/materials/mat/mat076/sigeps76c.F
   !||    sigeps78c                 ../engine/source/materials/mat/mat078/sigeps78c.F
   !||    sigeps80c                 ../engine/source/materials/mat/mat080/sigeps80c.F
   !||    sigeps82c                 ../engine/source/materials/mat/mat082/sigeps82c.F
   !||    sigeps85c_void            ../engine/source/materials/mat/mat085/sigeps85c_void.F
   !||    sigeps86c                 ../engine/source/materials/mat/mat086/sigeps86c.F
   !||    sigeps87c                 ../engine/source/materials/mat/mat087/sigeps87c.F
   !||    sigeps88c                 ../engine/source/materials/mat/mat088/sigeps88c.F
   !||    sigeps93c                 ../engine/source/materials/mat/mat093/sigeps93c.F
   !||    sigeps96c                 ../engine/source/materials/mat/mat096/sigeps96c.F
   !||    startime                  ../engine/source/system/timer.F
   !||    stoptime                  ../engine/source/system/timer.F
   !||    urotov                    ../engine/source/airbag/uroto.F
   !||    xfem_crk_dir              ../engine/source/elements/xfem/xfem_crk_dir.F
   !||--- uses       -----------------------------------------------------
   !||    elbufdef_mod              ../common_source/modules/mat_elem/elbufdef_mod.F90
   !||    failwave_mod              ../common_source/modules/failwave_mod.F
   !||    law_usersh                ../engine/source/user_interface/law_usersh.F
   !||    mat_elem_mod              ../common_source/modules/mat_elem/mat_elem_mod.F90
   !||    message_mod               ../engine/share/message_module/message_mod.F
   !||    nlocal_reg_mod            ../common_source/modules/nlocal_reg_mod.F
   !||    sensor_mod                ../engine/share/modules/sensor_mod.F
   !||    sigeps125c_mod            ../engine/source/materials/mat/mat125/sigeps125c.F90
   !||    stack_mod                 ../engine/share/modules/stack_mod.F
   !||    table_mod                 ../engine/share/modules/table_mod.F
   !||====================================================================
   SUBROUTINE MULAWC(ELBUF_STR ,&
   &JFT      ,JLT      ,NEL      ,PM        ,FOR      ,MOM      ,&
   &GSTR     ,THK      ,EINT     ,OFF       ,DIR_A    ,DIR_B    ,&
   &MAT      ,AREA     ,EXX      ,EYY       ,EXY      ,EXZ      ,&
   &EYZ      ,KXX      ,KYY      ,KXY       ,GEO      ,THK_LY   ,&
   &PID      ,TF       ,NPF      ,MTN       ,DT1C     ,DM       ,&
   &BUFMAT   ,SSP      ,RHO      ,VISCMX    ,IPLA     ,IOFC     ,&
   &INDX     ,NGL      ,THKLY    ,MATLY     ,ZCFAC    ,MAT_ELEM ,&
   &SHF      ,GS       ,SIGY     ,THK0      ,EPSP     ,&
   &POSLY    ,IGEO     ,IPM      ,FAILWAVE  ,FWAVE_EL ,&
   &IFAILURE ,ALDT     ,TEMPEL   ,DIE       ,&
   &TABLE     ,IXFEM   ,ELCRKINI ,&
   &SENSORS  ,NG       ,&
   &DIR1_CRK ,DIR2_CRK ,IPARG    ,JHBE      ,ISMSTR   ,JTHE     ,&
   &TENSX    ,IR       ,IS       ,NLAY      ,NPT      ,IXLAY    ,&
   &IXEL     ,ITHK     ,F_DEF    ,ISHPLYXFEM,&
   &ITASK    ,ISUBSTACK,STACK     ,TSTAR    ,ALPE     ,&
   &PLY_EXX  ,PLY_EYY  ,PLY_EXY  ,PLY_EXZ   ,PLY_EYZ  ,PLY_F    ,&
   &VARNL    ,ETIMP    ,NLOC_DMG ,NLAY_MAX  ,LAYNPT_MAX,&
   &IMPL_S   ,IMCONV   ,NPROPGI, NPROPMI ,NPROPM  ,NPROPG,&
   &IMON_MAT ,NUMGEO   ,NUMSTACK, DT1       ,TT ,NXLAYMAX,&
   &IDEL7NOK ,USERL_AVAIL,MAXFUNC,NUMMAT,VARNL_NPTTOT,&
   &SBUFMAT  ,SDIR_A   ,SDIR_B   ,STF,NPARG,SNPC)
!-----------------------------------------------
!   M o d u l e s
!-----------------------------------------------
      USE constant_mod
      USE LAW_USERSH
      USE TABLE_MOD
      USE MAT_ELEM_MOD
      USE STACK_MOD
      USE FAILWAVE_MOD
      USE MESSAGE_MOD
      USE NLOCAL_REG_MOD
      USE SENSOR_MOD
      USE SIGEPS125C_MOD
      USE ELBUFDEF_MOD
      USE FILE_DESCRIPTOR_MOD
!-----------------------------------------------
!   I m p l i c i t   T y p e s
!-----------------------------------------------
      IMPLICIT NONE
#include "my_real.inc"
!-----------------------------------------------
!   D u m m y   A r g u m e n t s
!-----------------------------------------------
      INTEGER, INTENT(IN) :: IR
      INTEGER, INTENT(IN) :: IS
      INTEGER, INTENT(IN) :: JFT
      INTEGER, INTENT(IN) :: JLT
      INTEGER, INTENT(IN) :: NEL
      INTEGER, INTENT(IN) :: NPT
      INTEGER, INTENT(IN) :: MTN
      INTEGER, INTENT(IN) :: IPLA
      INTEGER, INTENT(IN) :: NG
      INTEGER, INTENT(IN) :: NLAY
      INTEGER, INTENT(IN) :: ISMSTR
      INTEGER, INTENT(IN) :: IXFEM
      INTEGER, INTENT(IN) :: IFAILURE
      INTEGER, INTENT(IN) :: JHBE
      INTEGER, INTENT(IN) :: IXLAY
      INTEGER, INTENT(IN) :: IXEL
      INTEGER, INTENT(IN) :: ITHK
      INTEGER, INTENT(IN) :: JTHE
      INTEGER, INTENT(IN) :: ISUBSTACK
      INTEGER, INTENT(IN) :: ITASK
      INTEGER, INTENT(IN) :: ISHPLYXFEM
      INTEGER, INTENT(IN) :: NLAY_MAX
      INTEGER, INTENT(IN) :: LAYNPT_MAX
      INTEGER, INTENT(IN) :: USERL_AVAIL        ! Flag for User libraries availability
      INTEGER, INTENT(IN) :: MAXFUNC            ! Maximum number of functions
      INTEGER, INTENT(IN) :: NXLAYMAX           ! XFEM Parameter, Maximum number of layers
      INTEGER, INTENT(IN) :: IMPL_S
      INTEGER, INTENT(IN) :: IMCONV
      INTEGER, INTENT(IN) :: NPROPGI
      INTEGER, INTENT(IN) :: NPROPMI
      INTEGER, INTENT(IN) :: NPROPM
      INTEGER, INTENT(IN) :: NPROPG
      INTEGER, INTENT(IN) :: IMON_MAT
      INTEGER, INTENT(IN) :: NUMGEO
      INTEGER, INTENT(IN) :: NUMMAT
      INTEGER, INTENT(IN) :: NUMSTACK
      INTEGER, INTENT(IN) :: VARNL_NPTTOT
      INTEGER, INTENT(IN) :: SBUFMAT
      INTEGER, INTENT(IN) :: SDIR_A
      INTEGER, INTENT(IN) :: SDIR_B
      INTEGER, INTENT(IN) :: STF
      INTEGER, INTENT(IN) :: NPARG
      INTEGER, INTENT(IN) :: SNPC
      INTEGER, INTENT(IN),DIMENSION(MVSIZ) :: MAT
      INTEGER, INTENT(IN),DIMENSION(MVSIZ) :: PID
      INTEGER, INTENT(IN),DIMENSION(MVSIZ) :: NGL
      INTEGER, INTENT(IN),DIMENSION(NPROPGI,NUMGEO) :: IGEO
      INTEGER, INTENT(IN),DIMENSION(NPROPMI,NUMMAT) :: IPM
      INTEGER, INTENT(IN),DIMENSION(NPARG) :: IPARG
      INTEGER, INTENT(IN),DIMENSION(SNPC)  :: NPF
      !
      INTEGER, INTENT(INOUT) :: IDEL7NOK           ! Element deletion flag for IDEL flag in contact interfaces
      INTEGER, INTENT(INOUT) :: IOFC
      INTEGER, INTENT(INOUT),DIMENSION(MVSIZ*NLAY_MAX) :: MATLY
      INTEGER, INTENT(INOUT),DIMENSION(MVSIZ*NLAY_MAX) :: INDX
      INTEGER, INTENT(INOUT),DIMENSION(NEL)            :: FWAVE_EL
      INTEGER, INTENT(INOUT),DIMENSION(NXLAYMAX,MVSIZ) :: ELCRKINI
      !
      my_real, INTENT(IN) :: DT1
      my_real, INTENT(IN) :: TT
      my_real, INTENT(IN),DIMENSION(NPROPM,NUMMAT) :: PM
      my_real, INTENT(IN),DIMENSION(NPROPG,NUMGEO) :: GEO
      my_real, INTENT(IN),DIMENSION(SBUFMAT)       :: BUFMAT
      my_real, INTENT(IN),DIMENSION(STF)           ::  TF
      !
      my_real, intent(inout) :: DM
      my_real, intent(inout), dimension(nel,5) :: FOR
      my_real, intent(inout), dimension(nel,3) :: MOM
      my_real, intent(inout), dimension(nel,8) :: GSTR
      my_real, intent(inout), dimension(nel)   :: THK
      my_real, intent(inout), dimension(nel,2) :: EINT
      my_real, intent(inout), dimension(nel)   :: EPSP
      my_real, intent(inout), dimension(nel,5) :: TENSX
      !
      my_real, intent(inout), dimension(mvsiz) :: KXX
      my_real, intent(inout), dimension(mvsiz) :: KYY
      my_real, intent(inout), dimension(mvsiz) :: KXY
      !
      my_real, intent(inout), dimension(mvsiz) :: OFF
      my_real, intent(inout), dimension(mvsiz) :: TEMPEL
      my_real, intent(inout), dimension(mvsiz) :: VISCMX
      my_real, intent(inout), dimension(mvsiz) :: AREA
      my_real, intent(inout), dimension(mvsiz) :: EXX
      my_real, intent(inout), dimension(mvsiz) :: EYY
      my_real, intent(inout), dimension(mvsiz) :: EXY
      my_real, intent(inout), dimension(mvsiz) :: EXZ
      my_real, intent(inout), dimension(mvsiz) :: EYZ
      my_real, intent(inout), dimension(mvsiz) :: THK0
      my_real, intent(inout), dimension(mvsiz) :: SSP
      my_real, intent(inout), dimension(mvsiz) :: RHO
      my_real, intent(inout), dimension(mvsiz) :: TSTAR
      my_real, intent(inout), dimension(mvsiz) :: ALPE
      my_real, intent(inout), dimension(mvsiz) :: SHF
      my_real, intent(inout), dimension(mvsiz) :: GS
      my_real, intent(inout), dimension(mvsiz) :: SIGY
      my_real, intent(inout), dimension(mvsiz,2) :: ZCFAC
      my_real, intent(inout), dimension(mvsiz,8) :: F_DEF
      my_real, intent(inout), dimension(NXLAYMAX,mvsiz) :: DIR1_CRK
      my_real, intent(inout), dimension(NXLAYMAX,mvsiz) :: DIR2_CRK
      my_real, intent(inout), dimension(mvsiz) :: DT1C
      my_real, intent(inout), dimension(mvsiz) :: DIE
      my_real, intent(inout), dimension(mvsiz) :: ETIMP
      my_real, intent(inout), dimension(mvsiz) :: ALDT
      my_real, intent(inout), dimension(MVSIZ*NLAY_MAX*LAYNPT_MAX) :: THKLY
      my_real, intent(inout), dimension(NEL,NLAY_MAX*LAYNPT_MAX) :: THK_LY
      my_real, intent(inout), dimension(MVSIZ,NLAY_MAX*LAYNPT_MAX) :: POSLY
      !
      my_real, intent(inout), dimension(mvsiz,NPT) :: PLY_EXX    ! Batoz shell delamination
      my_real, intent(inout), dimension(mvsiz,NPT) :: PLY_EYY    ! Batoz shell delamination
      my_real, intent(inout), dimension(mvsiz,NPT) :: PLY_EXY    ! Batoz shell delamination
      my_real, intent(inout), dimension(mvsiz,NPT) :: PLY_EXZ    ! Batoz shell delamination
      my_real, intent(inout), dimension(mvsiz,NPT) :: PLY_EYZ    ! Batoz shell delamination
      my_real, intent(inout), dimension(mvsiz,5,NPT) :: PLY_F    ! Batoz shell delamination
      !
      my_real, intent(inout), dimension(NEL,VARNL_NPTTOT) :: VARNL
      my_real, intent(inout), dimension(SDIR_A) :: DIR_A
      my_real, intent(inout), dimension(SDIR_B) :: DIR_B
      !
      TARGET :: ALDT, IPM, VARNL
      TYPE(ELBUF_STRUCT_),intent(inout), TARGET :: ELBUF_STR
      TYPE (STACK_PLY) :: STACK
      TYPE (FAILWAVE_STR_) ,TARGET              :: FAILWAVE
      TYPE (MAT_ELEM_) ,INTENT(INOUT) ,TARGET   :: MAT_ELEM
      TYPE (NLOCAL_STR_)                        :: NLOC_DMG
      TYPE (SENSORS_) ,INTENT(IN)               :: SENSORS
!-----------------------------------------------
!   L o c a l   V a r i a b l e s
!-----------------------------------------------
      INTEGER :: NUMTABL
      INTEGER :: IPT
      INTEGER ::I,J,K,II,JJ,KK,IC,JMLY,IPG,IT,IFL,ILAY,NPG,MPT,MX,IMAT,&
      &IRUPT,NFAIL,IADBUF,IADBUFR,MAXNULVAR,IGTYP,NUVAR,NVARF,JDIR,&
      &NFUNC, JPOS, NINDX,NUPAR,NIPARAM,NUPARAM,NUPARAM0,NFUNC_FAIL,NTABL_FAIL,&
      &IFAILWV,NLOCAL,NSENSOR,IUN,IBIDON1,IBIDON2,IBIDON3,&
      &IPTX,ILAYER,IROT,DMG_FLAG,LF_DAMMX,NIPAR,&
      &IGMAT,IPGMAT,NPTT,IPT_ALL,NPTTOT,NUVARV,ILAW,&
      &JOFF,SIZNUL,PLY_ID,ISEQ,PROGRESSIVE_CRACK,&
      &ORTH_DAMAGE,L_DMG,IPRONY,ISRATE,NVARTMP,INLOC,IDRAPE,VP
      INTEGER :: IJ1,IJ2,IJ3,IJ4,IJ5
      INTEGER :: IJ(5),IFLAG(1)
      INTEGER ,DIMENSION(MAXFUNC) :: IFUNC
      INTEGER ,DIMENSION(MVSIZ)   :: IOFF_DUCT,NFIS1,NFIS2,NFIS3
!
      my_real&
      &SIGDMG(MVSIZ,5),SIGKSI(MVSIZ,5),TENS(MVSIZ,5)
      my_real ,DIMENSION(MVSIZ) ::&
      &FPSXX,FPSYY,FPSZZ,FPSXY,FPSYX,EPCHK,EPSPDT,DT_INV,COPY_PLA,PLA0,&
      &DEGMB ,DEGFX ,SIGOFF,THKLYL,THKN  ,ETSE,OFF_OLD,&
      &DEPSXX,DEPSYY,DEPSXY,DEPSYZ,DEPSZX,EPSXX ,EPSYY ,EPSXY,&
      &EPSYZ ,EPSZX ,EPSPXX,EPSPYY,EPSPXY,EPSPYZ,EPSPZX,SIGOXX,&
      &SIGOYY,SIGOXY,SIGOYZ,SIGOZX,SIGNXX,SIGNYY,SIGNXY,SIGNYZ,&
      &SIGNZX,SIGVXX,SIGVYY,SIGVXY,SIGVYZ,SIGVZX,&
      &WMC, EPSPL, YLD,DPLA,VOL0, COEF,HARDM,LA0,G_IMP,VISC,WPLAR,&
      &EPSP_LOC,SIGNXX_FAIL,SIGNYY_FAIL,SIGNXY_FAIL,SIGNYZ_FAIL,&
      &SIGNZX_FAIL,AREAMIN,DAREAMIN,DMG_GLOB_SCALE,DMG_LOC_SCALE,ET_IMP, EPSTHTOT
      my_real, DIMENSION(NEL,5) :: DMG_ORTH_SCALE
!
      my_real :: ZT,DTINV, VOL2,FCUT,ASRATE,EPS_M2,EPS_K2,&
      &R1,R2,R3,S1,S2,S3,R12A,R22A,S12B,S22B,RS1,RS2,RS3,&
      &T1,T2,T3,PHI,SUM1,SUM2,FACT,R3R3,S3S3,&
      &BIDON1,BIDON2,BIDON3,BIDON4,BIDON5,RATIO,VV,AA,TRELAX
      my_real  SCALE1(NEL)
      my_real ,DIMENSION(NEL), TARGET :: LE_MAX
      my_real TT_LOCAL
      my_real, DIMENSION(:) ,POINTER  :: EL_TEMP,YLDFAC,CRKLEN,CRKDIR,DADV,TFAIL,EL_LEN,&
      &EL_PLA
      TARGET :: TEMPEL,BUFMAT,SCALE1
!----
      TYPE(TTABLE) TABLE(*)
      TYPE(ULAWCINTBUF) :: USERBUF
      TYPE(BUF_LAY_) ,POINTER :: BUFLY
      TYPE(L_BUFEL_) ,POINTER :: LBUF
      TYPE(G_BUFEL_) ,POINTER :: GBUF
      TYPE(BUF_MAT_) ,POINTER :: MBUF
      TYPE(BUF_FAIL_),POINTER :: FBUF
      TYPE(BUF_VISC_),POINTER :: VBUF
!----
      INTEGER, DIMENSION(:) ,POINTER  :: FLD_IDX,FOFF,OFFLY,ITABLE,IFUNC_FAIL,&
      &ITABL_FAIL,VARTMP,IPARAM,IPARAMF
      my_real, DIMENSION(:) ,POINTER  :: UVAR,UVARF,UELR,UELR1,DAM,&
      &DFMAX,TDEL ,OFFL,UVARV,UPARAM,UPARAM0,UPARAMF,&
      &DIRDMG,DIR_ORTH,DAMINI
      TYPE(MATPARAM_STRUCT_) , POINTER :: MATPARAM
!----
      LOGICAL :: LOGICAL_USERL_AVAIL
      LOGICAL :: FLAG_EPS,FLAG_EPSP,FLAG_ZCFAC,FLAG_ETIMP
      LOGICAL :: FLAG_LAW1,FLAG_LAW2,FLAG_LAW25,FLAG_LAW22
      LOGICAL, DIMENSION(NEL) :: PRINT_FAIL
!
      CHARACTER OPTION*256
      INTEGER SIZE
      INTEGER :: NRATE,NPRONY
      my_real :: FISOKIN,KV,ZSHIFT
      my_real, DIMENSION(NEL) :: DEPS1,DEPS2,EPS1,EPS2
      my_real, DIMENSION(NEL), TARGET :: VECNUL
      my_real, DIMENSION(:), POINTER  :: SIGBXX,SIGBYY,SIGBXY
      my_real&
      &, DIMENSION(:), ALLOCATABLE :: GV,BETA
      my_real WM(11,11)
!
!-----------------------------------------------
!   S o u r c e   L i n e s
!=======================================================================
      GBUF => ELBUF_STR%GBUF
      IPG  = (IS-1)*ELBUF_STR%NPTR + IR     ! current Gauss point
      NPG  = ELBUF_STR%NPTR * ELBUF_STR%NPTS
      IGTYP = IGEO(11,PID(1))
      IGMAT = IGEO(98,PID(1))
      INLOC = IPARG(78)                     ! Flag for non-local regularization
      NSENSOR = SENSORS%NSENSOR
!
      IDRAPE = ELBUF_STR%IDRAPE
      LOGICAL_USERL_AVAIL=.FALSE.
      IF (USERL_AVAIL > 0) LOGICAL_USERL_AVAIL=.TRUE.
      DO K=1,5
         IJ(K) = NEL*(K-1)
      ENDDO
      IJ1 = IJ(1) + 1
      IJ2 = IJ(2) + 1
      IJ3 = IJ(3) + 1
      IJ4 = IJ(4) + 1
      IJ5 = IJ(5) + 1
!
      IPT_ALL = 0
      NPTTOT  = 0
!       need to check the value of ILAW for the array initializations because MTN/=ILAW
      FLAG_LAW1  = .FALSE.
      FLAG_LAW2  = .FALSE.
      FLAG_LAW22 = .FALSE.
      FLAG_LAW25 = .FALSE.
!
!  Check visco elastic model
!
      IPRONY = 0
      DO ILAY=1,NLAY
         NPTTOT = NPTTOT + ELBUF_STR%BUFLY(ILAY)%NPTT
         ILAYER = ILAY
         IF (IXFEM == 1 .AND. IXLAY > 0) ILAYER = IXLAY  ! xfem  multilayer
         ILAW = ELBUF_STR%BUFLY(ILAYER)%ILAW
         IMAT = ELBUF_STR%BUFLY(ILAYER)%IMAT
         IF(ILAW==1) FLAG_LAW1 = .TRUE.
         IF(ILAW==2) FLAG_LAW2 = .TRUE.
         IF(ILAW==22) FLAG_LAW22 = .TRUE.
         IF(ILAW==25) FLAG_LAW25 = .TRUE.
         IF(IPM(222,IMAT) > 0) IPRONY=1
      ENDDO
!
!     ZCFAC computation is only useful for CZFORC3 and CZFORC3_CRK routines
      FLAG_ZCFAC=.FALSE.
      IF( (JHBE>=21.AND.JHBE<=29).OR.(IMPL_S>0)) FLAG_ZCFAC=.TRUE.
      FLAG_ETIMP=.FALSE.
      IF(IMPL_S>0 .AND. MTN==78) FLAG_ETIMP=.TRUE.
      SCALE1(1:NEL) = ONE
      IFLAG(1) = IPLA
      BIDON1 = ZERO
      BIDON2 = ZERO
      BIDON3 = ZERO
      BIDON4 = ZERO
      BIDON5 = ZERO
      IBIDON1 = 0
      IBIDON2 = 0
      IBIDON3 = 0
!      IMAT = IPM(1, MAT(1))
      IUN=1
!
      DMG_FLAG = 0
      TRELAX   = ZERO
!
      DEGMB(JFT:JLT) = FOR(JFT:JLT,1)*EXX(JFT:JLT)+FOR(JFT:JLT,2)*EYY(JFT:JLT)&
      &+ FOR(JFT:JLT,3)*EXY(JFT:JLT)+FOR(JFT:JLT,4)*EYZ(JFT:JLT)&
      &+ FOR(JFT:JLT,5)*EXZ(JFT:JLT)
      DEGFX(JFT:JLT) = MOM(JFT:JLT,1)*KXX(JFT:JLT)+MOM(JFT:JLT,2)*KYY(JFT:JLT)&
      &+ MOM(JFT:JLT,3)*KXY(JFT:JLT)
!
      IF (FLAG_LAW1 .OR. FLAG_LAW25) THEN
         IF (NPT == 1) THEN
            DEGMB(JFT:JLT) = FOR(JFT:JLT,1)*EXX(JFT:JLT)+FOR(JFT:JLT,2)*EYY(JFT:JLT)+&
            &FOR(JFT:JLT,3)*EXY(JFT:JLT)+FOR(JFT:JLT,4)*EYZ(JFT:JLT)+&
            &FOR(JFT:JLT,5)*EXZ(JFT:JLT)
            DEGFX(JFT:JLT) = ZERO
         ENDIF
      ENDIF
!
      IF (FLAG_LAW25 .and. IGTYP == 9 .and. NPT == 1) THEN
         DEGMB(JFT:JLT) = ZERO
         DEGFX(JFT:JLT) = ZERO
      ENDIF
!
      VOL0(JFT:JLT)   = AREA(JFT:JLT)*THK0(JFT:JLT)
      THKN(JFT:JLT)   = THK(JFT:JLT)
      FOR(JFT:JLT,1)  = ZERO
      FOR(JFT:JLT,2)  = ZERO
      FOR(JFT:JLT,3)  = ZERO
      FOR(JFT:JLT,4)  = ZERO
      FOR(JFT:JLT,5)  = ZERO
      MOM(JFT:JLT,1)  = ZERO
      MOM(JFT:JLT,2)  = ZERO
      MOM(JFT:JLT,3)  = ZERO
      YLD(JFT:JLT)    = ZERO
      IF(FLAG_ZCFAC .AND. MTN /= 22) ZCFAC(JFT:JLT,1)= ZERO
      ZCFAC(JFT:JLT,2)= ZERO
      IF(FLAG_ZCFAC) ZCFAC(JFT:JLT,2)= ONE
      ETSE(JFT:JLT)   = ONE
      IF(FLAG_ETIMP) ETIMP(JFT:JLT)= ZERO
      COEF(JFT:JLT)   = ONE
      IF(FLAG_LAW25)THEN
         WPLAR(JFT:JLT)=ZERO
         NFIS1(JFT:JLT)=0
         NFIS2(JFT:JLT)=0
         NFIS3(JFT:JLT)=0
      ENDIF
      OFF_OLD(JFT:JLT) = OFF(JFT:JLT)
      IOFF_DUCT(JFT:JLT) = 0
      DMG_GLOB_SCALE(JFT:JLT) = ONE
      SIGOFF(1:NEL) = ONE
      EPCHK(1:MVSIZ)  = ZERO
      VISCMX(1:MVSIZ) = ZERO
      ZSHIFT = GEO(199, PID(1))
!
      IF ( FLAG_LAW22 ) THEN
#include "vectorize.inc"
         DO I=JFT,JLT
            ALPE(I) = EM30
         ENDDO
      ENDIF ! IF ( FLAG_LAW22 )
!       compute the inverse of dt and save the result
      DO I=JFT,JLT
         DT_INV(I) = DT1C(I)/MAX(DT1C(I)**2,EM20)
      ENDDO
      IF (FLAG_LAW25 .OR. FLAG_LAW2) SIGY(JFT:JLT) = ZERO
!-----------------------------------------------------------
!     EQUIVALENT STRAIN RATE (au sens energetique)
!-----------------------------------------------------------
!     e = 1/t integ[1/2 E (eps_m + k z)^2 dz ]
!     e = 1/2 E eps_eq^2
!     eps_eq = sqrt[ eps_m^2 + 1/12 k^2t^2 ]
!
      IF (IXLAY > 0) THEN
         MX = ELBUF_STR%BUFLY(IXLAY)%IMAT
      ELSE
         MX = MAT(JFT)
      ENDIF
      ISRATE = IPM(3,MX)
!
      IF (ISRATE == 1) THEN
#include "vectorize.inc"
         DO I=JFT,JLT
            EPS_K2 = (KXX(I)*KXX(I)+KYY(I)*KYY(I)+KXX(I)*KYY(I)&
            &+ FOURTH*KXY(I)*KXY(I)) *THK(I)*THK(I)*ONE_OVER_9
            EPS_M2 = FOUR_OVER_3*(EXX(I)*EXX(I)+EYY(I)*EYY(I)+EXX(I)*EYY(I)&
            &+ FOURTH*EXY(I)*EXY(I))
            EPSP_LOC(I) = SQRT(EPS_K2 + EPS_M2)*DT_INV(I)
         END DO
      ELSE IF (ISRATE > 1) THEN
#include "vectorize.inc"
         DO I=JFT,JLT
            EPS_M2  = FOUR_OVER_3*(EXX(I)*EXX(I)+EYY(I)*EYY(I)+EXX(I)*EYY(I)&
            &+ FOURTH*EXY(I)*EXY(I))
            EPSP_LOC(I) = SQRT(EPS_M2)*DT_INV(I)
         END DO
      ENDIF
!
      IF (ISRATE > 0) THEN    ! strain rate filtering with exponential average
         ASRATE = MIN(ONE, PM(9,MX)*DT1)
         DO I=JFT,JLT
            EPSP(I)   = ASRATE*EPSP_LOC(I) + (ONE-ASRATE)*EPSP(I)
            EPSPL(I)  = EPSP(I)
            EPSPDT(I) = EPSP(I)*DT1
         END DO
      ENDIF
!-----------------------------------------------------------
!     LOOP OVER THICKNESS INTEGRATION POINTS (LAYERS)
!-----------------------------------------------------------
      DO ILAY =1,NLAY
         IF (IXFEM == 1 .AND. IXLAY > 0) THEN  !  multilayer xfem
            ILAYER = IXLAY
         ELSE
            ILAYER = ILAY
         ENDIF
         PROGRESSIVE_CRACK = 0
         ORTH_DAMAGE = 0
         PLY_ID = 0
         IF (IGTYP == 52) THEN
            PLY_ID = PLY_INFO(1,STACK%IGEO(2+ILAY,ISUBSTACK)-NUMSTACK)
         ELSEIF(IGTYP == 17 .OR. IGTYP == 51)THEN
            PLY_ID = IGEO(1,STACK%IGEO(2+ILAY,ISUBSTACK))
         ENDIF
         BUFLY => ELBUF_STR%BUFLY(ILAYER)
         NPTT   = BUFLY%NPTT
         JMLY = 1 + (ILAYER-1)*JLT
         JDIR = 1 + (ILAYER-1)*JLT*2
!
         NFAIL  = BUFLY%NFAIL
         IMAT   = BUFLY%IMAT
         ILAW   = BUFLY%ILAW
         NUVAR  = BUFLY%NVAR_MAT
         NVARTMP= BUFLY%NVARTMP
         NUVARV = BUFLY%NVAR_VISC
         ISEQ   = BUFLY%L_SEQ
         IADBUF = MAX(1,IPM(7,IMAT))
         NUPARAM0=  IPM(9,IMAT)                    ! old uparam stored in BUFMAT
         UPARAM0 => BUFMAT(IADBUF:IADBUF+NUPARAM0) ! old uparam stored in BUFMAT
         NFUNC  = IPM(10,IMAT)
         NUMTABL= IPM(226,IMAT)
         ITABLE => IPM(226+1:226+NUMTABL,IMAT)
         MATPARAM => MAT_ELEM%MAT_PARAM(IMAT)
         NUPARAM  =  MAT_ELEM%MAT_PARAM(IMAT)%NUPARAM
         NIPARAM  =  MAT_ELEM%MAT_PARAM(IMAT)%NIPARAM
         UPARAM   => MAT_ELEM%MAT_PARAM(IMAT)%UPARAM
         IPARAM   => MAT_ELEM%MAT_PARAM(IMAT)%IPARAM

         IF (IGTYP == 11 .OR. IGTYP == 16 .OR. IGTYP == 17 .OR.&
         &IGTYP == 51 .OR. IGTYP == 52) THEN
            IF (ILAW == 58 .or. ILAW == 158 .OR. ILAW == 88) NFUNC = IPM(10,IMAT)+IPM(6,IMAT)
         ENDIF
         DO I=1,NFUNC
            IFUNC(I)=IPM(10+I,IMAT)
         ENDDO
!
!       check if EPSP arraies are used or not
!       EPSP is not used for law : 2/25/32/42/58/63/63/64/69/71/72/76/78/80/82/85/96 --> FLAG_EPSP=.FALSE.
!       EPSP is used for the other laws
!       EPSP is also used for the rupture : 4/5/6/14/24
         FLAG_EPSP=.TRUE.
         IF(ILAW==1.OR.ILAW==2.OR.ILAW==25.OR.ILAW==32.OR.ILAW==42.OR.ILAW==58.OR.ILAW==62.OR.&
         &ILAW==63.OR.ILAW==64.OR.ILAW==69.OR.ILAW==71.OR.ILAW==72.OR.&
         &ILAW==76.OR.ILAW==78.OR.ILAW==80.OR.ILAW==82.OR.ILAW==85.OR.ILAW == 88 .OR. ILAW==96) FLAG_EPSP=.FALSE.
!       check if EPS arraies are used or not
!       EPS is not used for law : 2/25/63/64/65/66/72/76/78/93 --> FLAG_EPS=.FALSE.
!       EPS is used for the other laws
!       EPS is also used for the rupture : 4/5/6/7/10/24
         FLAG_EPS=.TRUE.
         IF(ILAW==1.OR.ILAW== 2.OR.ILAW==25.OR.ILAW==32.OR.ILAW==63.OR.ILAW==64.OR.ILAW==65.OR.&
         &ILAW==66.OR.ILAW==72.OR.ILAW==76.OR.ILAW==78.OR.ILAW==85.OR.ILAW==93) FLAG_EPS=.FALSE.

         IF(MATPARAM%IVISC == 1 ) FLAG_EPSP=.TRUE.
         IF (IFAILURE == 1) THEN
            DO IT=1,NPTT
               FBUF => BUFLY%FAIL(IR,IS,IT)
               DO IFL = 1, NFAIL      ! loop over fail models in current layer
                  IRUPT  =  FBUF%FLOC(IFL)%ILAWF
                  IF(IRUPT== 4.OR.IRUPT== 5.OR.IRUPT== 6.OR.IRUPT==7.OR.&
                  &IRUPT==10.OR.IRUPT==24.OR.IRUPT==34.OR.IRUPT==39.OR.&
                  &IRUPT==43.OR.IRUPT==47) FLAG_EPS=.TRUE.

                  IF(IRUPT== 4.OR.IRUPT== 5.OR.IRUPT== 6.OR.&
                  &IRUPT==14.OR.IRUPT==24) FLAG_EPSP=.TRUE.
               ENDDO
            ENDDO
         ENDIF

!       DEPSYZ/ZX and EPSYZ/ZX are IT independant
!       EPSXY is IT independant for IGTYP/=1
         DEPSYZ(JFT:JLT)=EYZ(JFT:JLT)
         DEPSZX(JFT:JLT)=EXZ(JFT:JLT)
         IF (FLAG_EPS) THEN
            IF (IGTYP == 1) THEN
               EPSYZ(JFT:JLT)= GSTR(JFT:JLT,4)
               EPSZX(JFT:JLT)= GSTR(JFT:JLT,5)
            ELSE
               EPSXY(JFT:JLT)  = ZERO
               EPSYZ(JFT:JLT)  = ZERO
               EPSZX(JFT:JLT)  = ZERO
            ENDIF
         ENDIF
!----------------------------------------------------------------------
!---
         L_DMG = BUFLY%L_DMG
!---
         DO IT=1,NPTT
            IPT = IPT_ALL + IT        ! count all NPTT through all layers
            JPOS = 1 + (IPT-1)*JLT
!
            LBUF  => BUFLY%LBUF(IR,IS,IT)
            UVAR  => BUFLY%MAT(IR,IS,IT)%VAR
            UVARV => BUFLY%VISC(IR,IS,IT)%VAR
            VARTMP=> BUFLY%MAT(IR,IS,IT)%VARTMP
            DIRDMG => LBUF%DMG(1:L_DMG*NEL)
            IF(IDRAPE > 0) JDIR = 1 + (IPT - 1)*JLT*2
!
            ! -> Make sure the non-local increment is positive
            IF (INLOC > 0) THEN
               DO I = JFT,JLT
                  VARNL(I,IT)    = MAX(VARNL(I,IT),ZERO)
                  LBUF%PLANL(I)  = LBUF%PLANL(I) + VARNL(I,IT)
                  LBUF%EPSDNL(I) = VARNL(I,IT)/MAX(DT1,EM20)
               ENDDO
            ENDIF
!
            IF (JTHE == 0 .and. BUFLY%L_TEMP > 0) THEN
               EL_TEMP => LBUF%TEMP(1:NEL)
            ELSE
               EL_TEMP => TEMPEL(1:NEL)
            ENDIF
!         initial scale factor for yield stress defined per IPG,NPI
            IF (ILAW==36 .OR. ILAW==87) THEN
               YLDFAC => SCALE1(1:NEL)
               IF (BUFLY%L_FAC_YLD > 0) THEN
                  YLDFAC => LBUF%FAC_YLD(1:NEL)
               ENDIF
            ENDIF
!-----------------------------------------
!         COORDONNEES DU POINT D'INTEGRATION IPT
!-----------------------------------------
            !ZZ   => POSLY(1:NEL,IPT)
            !THLY => THKLY(JPOS:JPOS+NEL-1)
            THKLYL(1:NEL) = THKLY(JPOS:JPOS+NEL-1)*THK0(1:NEL)
!
            IF ((IGTYP == 1 .OR. IGTYP == 9).AND.ZSHIFT==ZERO) THEN
               ! Initialize WM Matrix
               CALL COQINI_WM(WM)
               WMC(1:NEL) = WM(IPT,NPT)
            ELSE
               WMC(1:NEL) = POSLY(1:NEL,IPT)*THKLY(JPOS:JPOS+NEL-1)
            ENDIF
!-------------------------------
!         INCREMENT DE DEFORMATIONS
!-------------------------------
            IF (ILAW == 58 .or. ILAW == 158) THEN
               SIGNXX(1:MVSIZ) = ZERO
               SIGNYY(1:MVSIZ) = ZERO
               SIGNXY(1:MVSIZ) = ZERO
               SIGNYZ(1:MVSIZ) = ZERO
               SIGNZX(1:MVSIZ) = ZERO
               SIGVXX(1:MVSIZ) = ZERO
               SIGVYY(1:MVSIZ) = ZERO
               SIGVXY(1:MVSIZ) = ZERO
               SIGVYZ(1:MVSIZ) = ZERO
               SIGVZX(1:MVSIZ) = ZERO
            ENDIF
!       -------------------------------
!       IGTYP = 1
!       -------------------------------
            IF (IGTYP == 1) THEN
               !       -----------
               !       ismstr=10 + foam laws
               !       -----------
               IF (ISMSTR==10 .AND. (MTN == 1 .OR. MTN == 42 .OR.&
               &MTN == 69.OR. MTN == 71 .OR. MTN == 88)) THEN
                  DO I=JFT,JLT
                     ZT=POSLY(I,IPT) *THK0(I)
                     DEPSXX(I)=EXX(I)+ZT*KXX(I)
                     DEPSYY(I)=EYY(I)+ZT*KYY(I)
                     DEPSXY(I)=EXY(I)+ZT*KXY(I)
!       not IT dependant
!              DEPSYZ(I)=EYZ(I)
!              DEPSZX(I)=EXZ(I)
!
                     TENS(I,1)= F_DEF(I,1)+ZT*F_DEF(I,6)
                     TENS(I,2)= F_DEF(I,2)+ZT*F_DEF(I,7)
                     TENS(I,3)= F_DEF(I,3)+ZT*F_DEF(I,8)
                     TENS(I,4)= F_DEF(I,4)+ZT*F_DEF(I,5)
!       not IT dependant
!              EPSYZ(I)= GSTR(I,4)
!              EPSZX(I)= GSTR(I,5)
                  ENDDO
!---------  [F]=[F_DEF]+[1]; [B]=[F][F]^t strain-----
                  DO I=JFT,JLT
                     EPSXX(I)=TENS(I,1)*(TWO+TENS(I,1))+&
                     &TENS(I,3)*TENS(I,3)
                     EPSYY(I)=TENS(I,2)*(TWO+TENS(I,2))+&
                     &TENS(I,4)*TENS(I,4)
                     EPSXY(I)=TWO*(TENS(I,3)+TENS(I,4)+TENS(I,1)*TENS(I,4)+&
                     &TENS(I,3)*TENS(I,2))
                  ENDDO
               ELSE IF (ILAW == 27) THEN
                  DO I=JFT,JLT
                     ZT       = POSLY(I,IPT) *THK0(I)
                     TENS(I,1)=EXX(I)+ZT*KXX(I)
                     TENS(I,2)=EYY(I)+ZT*KYY(I)
                     TENS(I,3)=HALF*(EXY(I)+ZT*KXY(I))
                     TENS(I,4)=HALF*EYZ(I)
                     TENS(I,5)=HALF*EXZ(I)
                  ENDDO
!
                  CALL ROTOV(JFT,JLT,TENS,DIRDMG,NEL)
!
                  DO I=JFT,JLT
                     DEPSXX(I)=TENS(I,1)
                     DEPSYY(I)=TENS(I,2)
                     DEPSXY(I)=TWO*TENS(I,3)
                     DEPSYZ(I)=TWO*TENS(I,4)
                     DEPSZX(I)=TWO*TENS(I,5)
                  ENDDO
               ELSE
                  !       -----------
                  !       /= ismstr=10 + foam laws
                  !       -----------
                  DO I=JFT,JLT
                     ZT=POSLY(I,IPT) *THK0(I)
                     DEPSXX(I)=EXX(I)+ZT*KXX(I)
                     DEPSYY(I)=EYY(I)+ZT*KYY(I)
                     DEPSXY(I)=EXY(I)+ZT*KXY(I)
                  ENDDO
                  IF (FLAG_EPS) THEN
                     DO I=JFT,JLT
                        ZT=POSLY(I,IPT) *THK0(I)
                        EPSXX(I)= GSTR(I,1)+ZT*GSTR(I,6)
                        EPSYY(I)= GSTR(I,2)+ZT*GSTR(I,7)
                        EPSXY(I)= GSTR(I,3)+ZT*GSTR(I,8)
                     ENDDO
                  ENDIF
               END IF!(ISMSTR==10)
!       -------------------------------
!       IGTYP = 16
!       -------------------------------
            ELSEIF (IGTYP == 16) THEN
               !       ------------
               !       ISMSTR=11
               !       ------------
               IF (ISMSTR == 11) THEN
!             total strain in fiber coord sys
                  DO I=JFT,JLT
                     II = JDIR + I-1
                     R1 = DIR_A(II)
                     S1 = DIR_A(II+NEL)
                     R2 = DIR_B(II)
                     S2 = DIR_B(II+NEL)
!               total strain in element coord sys
                     ZT = POSLY(I,IPT) *THK0(I)
                     T1 = GSTR(I,1) + ZT*GSTR(I,6)
                     T2 = GSTR(I,2) + ZT*GSTR(I,7)
                     T3 = HALF*(GSTR(I,3) + ZT*GSTR(I,8))
                     DEPSXY(I) = (R1*R2 + S1*S2) / (R1*S2 - R2*S1)    ! Tan(alpha_totale)
                     DEPSXX(I) = R1*R1*T1 + S1*S1*T2 + TWO*R1*S1*T3  ! eps_x dir1
                     DEPSYY(I) = R2*R2*T1 + S2*S2*T2 + TWO*R2*S2*T3  ! eps_y dir2
!
                     EPSXX(I) = T1
                     EPSYY(I) = T2
                     EPSXY(I) = T3 * TWO  ! gamma_xy
                  ENDDO
               ELSE
                  !       ------------
                  !       ISMSTR/=11
                  !       ------------
!             strain rate in fiber coord sys
                  DO I=JFT,JLT
                     II = JDIR + I-1
                     R1 = DIR_A(II)
                     S1 = DIR_A(II+NEL)
                     R2 = DIR_B(II)
                     S2 = DIR_B(II+NEL)
!---
                     ZT = POSLY(I,IPT) *THK0(I)
                     T1 = EXX(I) + ZT*KXX(I)
                     T2 = EYY(I) + ZT*KYY(I)
                     T3 = HALF*(EXY(I) + ZT*KXY(I))
                     DEPSXY(I) = (R1*R2 + S1*S2) / (R1*S2 - R2*S1)   ! Tan(alpha_totale)
                     DEPSXX(I) = R1*R1*T1 + S1*S1*T2 + TWO*R1*S1*T3 ! delta_eps_x dir1
                     DEPSYY(I) = R2*R2*T1 + S2*S2*T2 + TWO*R2*S2*T3 ! delta_eps_y dir2
                  ENDDO
               ENDIF
               IF (FLAG_EPS) THEN
                  DO I=JFT,JLT
!             total true strain in global coord sys
                     ZT = POSLY(I,IPT) *THK0(I)
                     EPSXX(I) = GSTR(I,1) + ZT*GSTR(I,6)
                     EPSYY(I) = GSTR(I,2) + ZT*GSTR(I,7)
                     EPSXY(I) = GSTR(I,3) + ZT*GSTR(I,8)
                  ENDDO
               ENDIF
!------
!       -------------------------------
!       IGTYP = 9 / 10 / 11 / 17 / 51 and 52
!       -------------------------------
            ELSE
!--         Igtyp 9/10/11/17/51/52
!               -------------------------------
!               IGTYP = 51 or 52 + ilaw=58
!               -------------------------------
               IF ((IGTYP == 51 .OR. IGTYP == 52) .AND. (ILAW == 58 .or. ILAW == 158)) THEN
                  !       ------------
                  !       ISMSTR=11
                  !       ------------
                  IF (ISMSTR == 11) THEN
!             total strain in fiber coord sys
                     DO I=JFT,JLT
                        II = JDIR + I-1
                        R1 = DIR_A(II)
                        S1 = DIR_A(II+NEL)
                        R2 = DIR_B(II)
                        S2 = DIR_B(II+NEL)
!               total strain in element coord sys
                        ZT = POSLY(I,IPT) *THK0(I)
                        T1 = GSTR(I,1) + ZT*GSTR(I,6)
                        T2 = GSTR(I,2) + ZT*GSTR(I,7)
                        T3 = HALF*(GSTR(I,3) + ZT*GSTR(I,8))
                        DEPSXY(I) = (R1*R2 + S1*S2) / (R1*S2 - R2*S1)    ! Tan(alpha_totale)
                        DEPSXX(I) = R1*R1*T1 + S1*S1*T2 + TWO*R1*S1*T3  ! eps_x dir1
                        DEPSYY(I) = R2*R2*T1 + S2*S2*T2 + TWO*R2*S2*T3  ! eps_y dir2
                        EPSXY(I)  = T3 * TWO  ! gamma_xy
                     ENDDO
                  ELSE
                     !       ------------
                     !       ISMSTR/=11
                     !       ------------
!             strain rate in fiber coord sys
                     DO I=JFT,JLT
                        II = JDIR + I-1
                        R1 = DIR_A(II)
                        S1 = DIR_A(II+NEL)
                        R2 = DIR_B(II)
                        S2 = DIR_B(II+NEL)
!---
                        ZT = POSLY(I,IPT) *THK0(I)
                        T1 = EXX(I) + ZT*KXX(I)
                        T2 = EYY(I) + ZT*KYY(I)
                        T3 = HALF*(EXY(I) + ZT*KXY(I))
                        DEPSXY(I) = (R1*R2 + S1*S2) / (R1*S2 - R2*S1)   ! Tan(alpha_totale)
                        DEPSXX(I) = R1*R1*T1 + S1*S1*T2 + TWO*R1*S1*T3 ! delta_eps_x dir1
                        DEPSYY(I) = R2*R2*T1 + S2*S2*T2 + TWO*R2*S2*T3 ! delta_eps_y dir2
                     ENDDO
                  ENDIF ! IF (ISMSTR == 11) THEN
                  IF (FLAG_EPS) THEN
                     DO I=JFT,JLT
                        ZT = POSLY(I,IPT) *THK0(I)
                        T1 = GSTR(I,1) + ZT*GSTR(I,6)
                        T2 = GSTR(I,2) + ZT*GSTR(I,7)
                        T3 = GSTR(I,3) + ZT*GSTR(I,8)
                        EPSXX(I) = T1
                        EPSYY(I) = T2
                        EPSXY(I) = T3
                     ENDDO
                  ENDIF
               ELSE !        Igtyp 9/10/11/17/51   - NO law58
!               -------------------------------
!               IGTYP /= 51 and 52 or ilaw/=58
!               -------------------------------
                  IF (ILAW /= 1 .AND. ILAW /= 2 .AND. ILAW /= 32 ) THEN
                     DO I=JFT,JLT
                        ZT       = POSLY(I,IPT) *THK0(I)
                        TENS(I,1)=EXX(I)+ZT*KXX(I)
                        TENS(I,2)=EYY(I)+ZT*KYY(I)
                        TENS(I,3)=HALF*(EXY(I)+ZT*KXY(I))
                        TENS(I,4)=HALF*EYZ(I)
                        TENS(I,5)=HALF*EXZ(I)
                     ENDDO
!
                     IF (ILAW /= 27) THEN
                        CALL ROTOV(JFT,JLT,TENS,DIR_A(JDIR),NEL)
                     ELSE
                        CALL ROTOV(JFT,JLT,TENS,DIRDMG,NEL)
                     ENDIF
!
                     DO I=JFT,JLT
                        DEPSXX(I)=TENS(I,1)
                        DEPSYY(I)=TENS(I,2)
                        DEPSXY(I)=TWO*TENS(I,3)
                        DEPSYZ(I)=TWO*TENS(I,4)
                        DEPSZX(I)=TWO*TENS(I,5)
                     ENDDO
                  ELSEIF (ILAW == 1 .OR. ILAW == 2 .OR. ILAW == 32) THEN
                     DO I=JFT,JLT
                        ZT       = POSLY(I,IPT) *THK0(I)
                        DEPSXX(I)=EXX(I)+ZT*KXX(I)
                        DEPSYY(I)=EYY(I)+ZT*KYY(I)
                        DEPSXY(I)=EXY(I)+ZT*KXY(I)
                     ENDDO
                  ENDIF
!
                  IF (ISMSTR==10 .AND. (MTN == 1 .OR. MTN == 42 .OR.&
                  &MTN == 69.OR. MTN == 71 .OR. MTN == 88)) THEN
                     DO I=JFT,JLT
                        ZT=POSLY(I,IPT) *GBUF%THK_I(I)
!
                        TENS(I,1)= F_DEF(I,1)+ZT*F_DEF(I,6)
                        TENS(I,2)= F_DEF(I,2)+ZT*F_DEF(I,7)
                        TENS(I,3)= F_DEF(I,3)+ZT*F_DEF(I,8)
                        TENS(I,4)= F_DEF(I,4)+ZT*F_DEF(I,5)
                     ENDDO
!--------   - [F]=[F_DEF]+[1]; [B]=[F][F]^t strain-----
                     EPSXX(JFT:JLT)=TENS(JFT:JLT,1)*(TWO+TENS(JFT:JLT,1))+TENS(JFT:JLT,3)*TENS(JFT:JLT,3)
                     EPSYY(JFT:JLT)=TENS(JFT:JLT,2)*(TWO+TENS(JFT:JLT,2))+TENS(JFT:JLT,4)*TENS(JFT:JLT,4)
                     EPSXY(JFT:JLT)=TENS(JFT:JLT,3)+TENS(JFT:JLT,4)+TENS(JFT:JLT,1)*TENS(JFT:JLT,4)+TENS(JFT:JLT,3)*TENS(JFT:JLT,2)
                     DO I=JFT,JLT
                        TENS(I,1)= EPSXX(I)
                        TENS(I,2)= EPSYY(I)
                        TENS(I,3)= EPSXY(I)
                        TENS(I,4)= HALF*GSTR(I,4)
                        TENS(I,5)= HALF*GSTR(I,5)
                     ENDDO
                  ELSEIF (ILAW == 32) THEN
                     DO I=JFT,JLT
                        ZT=POSLY(I,IPT) *THK0(I)
                        EPSXX(I)= GSTR(I,1)+ZT*GSTR(I,6)
                        EPSYY(I)= GSTR(I,2)+ZT*GSTR(I,7)
                        EPSXY(I)= GSTR(I,3)+ZT*GSTR(I,8)
                     ENDDO
                  ELSE
                     DO I=JFT,JLT
                        ZT=POSLY(I,IPT) *THK0(I)
                        TENS(I,1)= GSTR(I,1)+ZT*GSTR(I,6)
                        TENS(I,2)= GSTR(I,2)+ZT*GSTR(I,7)
                        TENS(I,3)= HALF*(GSTR(I,3)+ZT*GSTR(I,8))
                        TENS(I,4)= HALF*GSTR(I,4)
                        TENS(I,5)= HALF*GSTR(I,5)
                     ENDDO
                  END IF!(ISMSTR==10)
!
                  IF (ILAW /= 27 .and. ILAW /= 32) THEN
                     CALL ROTOV(JFT,JLT,TENS,DIR_A(JDIR),NEL)
                  ELSE IF (ILAW == 27) THEN
                     CALL ROTOV(JFT,JLT,TENS,DIRDMG,NEL)
                  ENDIF
!
                  IF (FLAG_EPS) THEN !
                     DO I=JFT,JLT
                        EPSXX(I) = TENS(I,1)
                        EPSYY(I) = TENS(I,2)
                        EPSXY(I) = TWO*TENS(I,3)
                        EPSYZ(I) = TWO*TENS(I,4)
                        EPSZX(I) = TWO*TENS(I,5)
                     ENDDO
                  ENDIF
               ENDIF  ! IF (IGTYP ==51 .AND. ILAW == 58)
            ENDIF  ! IF (IGTYP == 1)
!       -------------------------------
!       end of IGTYP condition
!       -------------------------------
!---
            IF (FLAG_EPSP) THEN
               DO I=JFT,JLT
                  DTINV   =DT_INV(I)!DT1C(I)/MAX(DT1C(I)**2,EM20)
                  EPSPXX(I)=DEPSXX(I)*DTINV
                  EPSPYY(I)=DEPSYY(I)*DTINV
                  EPSPXY(I)=DEPSXY(I)*DTINV
                  EPSPYZ(I)=DEPSYZ(I)*DTINV
                  EPSPZX(I)=DEPSZX(I)*DTINV
               ENDDO
            ENDIF
            DPLA(1:MVSIZ) = ZERO
            IF (IFAILURE == 1) THEN
               IF (ELBUF_STR%BUFLY(ILAYER)%L_PLA > 0) THEN
                  PLA0(1:JLT) = LBUF%PLA(1:JLT)
               ELSE
                  PLA0(1:JLT) = ZERO
               ENDIF
            ENDIF
!------------------------------------------
!         ELASTIC STRESS +
!         PLASTICLY ADMISSIBLE STRESS
!------------------------------------------
            IF (ILAW == 1) THEN
               CALL SIGEPS01C(JFT       ,JLT      ,NEL      ,IMAT     ,GS       ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX    ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &DEPSXX    ,DEPSYY   ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &THKN      ,THKLYL   ,OFF      ,PM       ,ISMSTR   ,&
               &EPSXX     ,EPSYY    ,EPSXY    )
            ELSEIF (ILAW == 2) THEN
               VP =  IPM(255,IMAT)
               CALL SIGEPS02C(&
               &JFT        ,JLT       ,PM       ,EINT     ,THKN     ,&
               &OFF        ,SIGY      ,DT1C     ,IPLA     ,NEL      ,&
               &VOL0       ,GS        ,ISRATE   ,THKLYL   ,ETSE     ,&
               &NGL        ,EPSPDT    ,G_IMP    ,SIGKSI   ,IOFF_DUCT,&
               &DPLA       ,TSTAR     ,JTHE     ,HARDM    ,EPCHK    ,&
               &IMAT       ,IPT       ,NPTTOT   ,LBUF%PLA ,OFF_OLD  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX     ,SIGNYY    ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &DEPSXX     ,DEPSYY    ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &EPSPXX     ,EPSPYY    ,EPSPXY   ,EPSPYZ   ,EPSPZX ,&
               &LBUF%SIGB(IJ1),LBUF%SIGB(IJ2),LBUF%SIGB(IJ3),INLOC  ,VARNL(1,IT),&
               &VP        ,NUVAR     ,UVAR      ,ASRATE   ,LBUF%OFF)
!
            ELSEIF (ILAW == 15) THEN
               CALL SIGEPS15C(&
               &JFT      ,JLT     ,PM       ,LBUF%DAM   ,&
               &IMAT     ,SHF     ,NGL      ,EPSPL      ,DMG_FLAG   ,&
               &ILAYER   ,NEL     ,ISRATE   ,LBUF%PLA   ,SIGDMG     ,&
               &DEPSXX   ,DEPSYY  ,DEPSXY   ,DEPSYZ     ,DEPSZX     ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY  ,SIGNXY   ,SIGNYZ     ,SIGNZX     ,&
               &LBUF%DSUM,LBUF%TSAIWU)
            ELSEIF (ILAW == 19) THEN

               CALL SIGEPS19C(&
               &NEL       ,NUPARAM   ,NIPARAM  ,FLAG_ZCFAC,ZCFAC     ,SHF       ,&
               &UPARAM    ,IPARAM    ,NPTTOT   ,SSP       ,NSENSOR   ,&
               &EPSXX     ,EPSYY     ,EPSXY    ,EPSYZ     ,EPSZX     ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX    ,SIGNYY    ,SIGNXY   ,SIGNYZ    ,SIGNZX    ,&
               &GBUF%SIGI ,SENSORS%SENSOR_TAB)

            ELSEIF (ILAW == 22) THEN
               CALL SIGEPS22C(&
               &JFT      ,JLT    ,PM       ,THKN   ,OFF     ,&
               &SIGY     ,DT1C   ,IPLA     ,NEL    ,OFF_OLD ,&
               &GS       ,DPLA   ,IOFF_DUCT,NPTT   ,IPT     ,&
               &EPCHK    ,ALPE   ,THKLYL   ,IMAT   ,LBUF%PLA,&
               &DEPSXX   ,DEPSYY ,DEPSXY   ,DEPSYZ ,DEPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY ,SIGNXY   ,SIGNYZ ,SIGNZX  ,&
               &INLOC    ,VARNL(1,IT),LBUF%OFF)
            ELSEIF (ILAW == 27) THEN
               CALL SIGEPS27C(&
               &JFT      ,JLT     ,PM       ,THKN    ,OFF   ,&
               &GSTR     ,IMAT    ,DT1C     ,IPLA    ,SHF   ,&
               &NGL      ,THK0    ,THKLYL   ,LBUF%CRAK,LBUF%DAM,&
               &SIGY     ,ZCFAC   ,DPLA     ,ILAYER  ,IPT   ,&
               &ISRATE   ,NEL     ,POSLY(1,IPT),NPTTOT  ,EPSPDT,&
               &DEPSXX   ,DEPSYY  ,DEPSXY   ,DEPSYZ  ,DEPSZX,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2) ,LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY  ,SIGNXY   ,SIGNYZ  ,SIGNZX,&
               &DIRDMG   ,LBUF%PLA,INLOC    ,VARNL(1,IT),LBUF%OFF)
!
               EPSPL(JFT:JLT) = EPSPDT(JFT:JLT)
            ELSEIF (ILAW == 32) THEN
               CALL SIGEPS32C(&
               &JFT        ,JLT    ,PM      ,THKN   ,OFF    ,&
               &DIR_A(JDIR),IPT    ,IMAT    ,NEL    ,DT1C   ,&
               &GS         ,EPSP   ,THKLYL  ,IPLA   ,DPLA   ,&
               &DEPSXX     ,DEPSYY ,DEPSXY  ,DEPSYZ ,DEPSZX ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX     ,SIGNYY ,SIGNXY  ,SIGNYZ ,SIGNZX ,&
               &LBUF%PLA   ,NGL    ,HARDM   ,INLOC  ,VARNL(1,IT),&
               &LBUF%SEQ   ,LBUF%OFF,ETSE   )
               EPSPL(JFT:JLT) = EPSP(JFT:JLT)
            ELSEIF (ILAW == 25) THEN
               IF (IGTYP /= 1 .and. IGTYP /= 9) THEN
                  IF (IXFEM == 1 .AND. IXLAY > 0) NPTTOT = ELBUF_STR%BUFLY(IXLAY)%NPTT
!         INTEGRATION BY LAYERS
                  CALL SIGEPS25C(MATPARAM ,&
                  &NEL         ,PM(1,IMAT)  ,OFF      ,GSTR      ,&
                  &DIR_A(JDIR) ,THKLY(JPOS),TT        ,DT1      ,SHF       ,&
                  &NGL         ,THK0        ,EXX      ,OFF_OLD   ,&
                  &EYY         ,EXY      ,EXZ         ,EYZ      ,KXX       ,&
                  &KYY         ,KXY      ,POSLY(1,IPT),EPSPL    ,RHO       ,&
                  &SSP         ,BUFMAT   ,LBUF%OFF    ,&
                  &SIGY        ,ZCFAC    ,NPTT        ,ILAYER   ,&
                  &NFIS1       ,NFIS2    ,NFIS3       ,WPLAR    ,&
                  &NPTTOT      ,IGTYP    ,LBUF%VISC,LBUF%SIGPLY,&
                  &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
                  &SIGNXX      ,SIGNYY   ,SIGNXY      ,SIGNYZ   ,SIGNZX    ,&
                  &SIGVXX      ,SIGVYY   ,SIGVXY      ,SIGVYZ   ,SIGVZX    ,&
                  &ISRATE      ,UVARV    ,ISHPLYXFEM  ,IPT      ,LBUF%SEQ  ,&
                  &PLY_EXX     ,PLY_EYY  ,PLY_EXY     ,PLY_EXZ  ,PLY_EYZ   ,&
                  &PLY_F       ,LBUF%PLA ,LBUF%CRAK   ,GBUF%IERR,&
                  &IOFF_DUCT   ,IFAILURE ,PLY_ID      ,IPG      ,LBUF%TSAIWU,&
                  &IMCONV      ,IOUT     ,LBUF%DMG    ,BUFLY%L_DMG)

               ELSEIF (IGTYP == 9) THEN
!           INTEGRATION BY POINTS (through thickness)
                  CALL SIGEPS25CP(MATPARAM ,&
                  &JFT     ,JLT    ,OFF      ,DIR_A(JDIR) ,&
                  &SHF     ,NPT    ,NGL      ,IPT     ,OFF_OLD     ,&
                  &THK0    ,EPSPL  ,SIGY     ,ZCFAC   ,NEL    ,&
                  &DEPSXX  ,DEPSYY ,DEPSXY   ,DEPSYZ  ,DEPSZX ,&
                  &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
                  &SIGNXX  ,SIGNYY ,SIGNXY   ,SIGNYZ  ,SIGNZX ,&
                  &WPLAR  ,IOFF_DUCT,LBUF%PLA,ISRATE ,LBUF%TSAIWU)
               ENDIF ! IF (IGTYP)
!
            ELSEIF (ILAW == 34) THEN
               CALL SIGEPS34C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC   ,&
               &NPF    ,TF     ,TT     ,DT1C    ,UPARAM0    ,&
               &RHO    ,THKLYL  ,GS     ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SSP    ,THKN    ,UVAR     ,OFF    )
            ELSEIF (ILAW == 35) THEN
               CALL SIGEPS35C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC   ,&
               &NPF    ,NPT    ,IPT     ,IFLAG    ,&
               &TF     ,TT     ,DT1C    ,UPARAM0   ,RHO    ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,UVAR     ,OFF    ,&
               &NGL    ,SHF    ,ETSE    ,ISRATE   ,ASRATE ,&
               &EPSP   )
            ELSEIF (ILAW == 36) THEN
               NRATE = NINT(UPARAM0(1))
               FISOKIN = UPARAM0(2*NRATE + 14)
               IF(FISOKIN>0) THEN
                  SIGBXX => LBUF%SIGB(1      :  NEL)
                  SIGBYY => LBUF%SIGB(NEL+1  :2*NEL)
                  SIGBXY => LBUF%SIGB(3*NEL+1:4*NEL)
               ELSE
                  VECNUL(1:NEL) = ZERO
                  SIGBXX => VECNUL(1:NEL)
                  SIGBYY => VECNUL(1:NEL)
                  SIGBXY => VECNUL(1:NEL)
               ENDIF

               CALL SIGEPS36C(&
               &JLT    ,NUVAR   ,NVARTMP  ,NFUNC   ,&
               &IFUNC  ,NPF    ,IFLAG   ,&
               &TF     ,DT1C    ,UPARAM0   ,RHO     ,&
               &THKLYL  ,ASRATE   ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &VARTMP ,OFF    ,IPM     ,IMAT     ,&
               &ETSE   ,GS     ,SIGY   ,EPSPL   ,ISRATE   ,&
               &DPLA   ,G_IMP  ,SIGKSI  ,SHF      ,HARDM  ,&
               &YLDFAC ,INLOC ,VARNL(1,IT),LBUF%DMG,LBUF%PLANL,&
               &SIGBXX,SIGBYY,SIGBXY,LBUF%OFF)
            ELSEIF (ILAW == 42) THEN
               CALL SIGEPS42C(&
               &NEL    , NUPARAM, NIPARAM , NUVAR   , ISMSTR  ,&
               &TT     , DT1    , UPARAM  , IPARAM  , RHO     ,&
               &DEPSXX , DEPSYY , DEPSXY  , DEPSYZ  , DEPSZX  ,&
               &EPSXX  , EPSYY  , EPSXY   , THKN    , THKLYL  ,&
               &SIGNXX , SIGNYY , SIGNXY  , SIGNYZ  , SIGNZX  ,&
               &LBUF%SIG(IJ4),LBUF%SIG(IJ5),SSP     ,GS,  UVAR,&
               &OFF    )

            ELSEIF (ILAW == 43) THEN
               CALL SIGEPS43C(&
               &JLT    ,NUPARAM0,NUVAR   ,NPF      ,TF      ,&
               &NFUNC  ,IFUNC  ,ISRATE  ,TT       ,DT1C    ,&
               &UPARAM0 ,RHO    ,AREA    ,EINT     ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX  ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX  ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SSP    ,THKN   ,LBUF%PLA ,UVAR    ,OFF    ,&
               &NGL    ,ETSE   ,HARDM    ,SIGY    ,GS     ,&
               &DPLA   ,EPSP   ,SHF      ,INLOC   ,VARNL(1,IT),&
               &LBUF%SEQ,LBUF%OFF)
               EPSPL(JFT:JLT) = EPSP(JFT:JLT)

            ELSEIF (ILAW == 44) THEN
               CALL SIGEPS44C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC   ,&
               &NPF    ,TF     ,TT      ,DT1      ,UPARAM0  ,&
               &RHO    ,THKLYL ,OFF     ,ETSE     ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &GS     ,SIGY   ,EPSP    ,DPLA     ,ASRATE ,&
               &NVARTMP,VARTMP ,LBUF%SIGB,INLOC   ,VARNL(1,IT),&
               &LBUF%OFF)

            ELSEIF (ILAW == 45) THEN
               CALL SIGEPS45C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC  ,&
               &NPF    ,NPT    ,IPT     ,IFLAG    ,&
               &TF     ,TT     ,DT1C    ,UPARAM0   ,RHO    ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,SHF     )
            ELSEIF (ILAW == 48) THEN
               CALL SIGEPS48C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT  ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,DPLA     ,ISRATE ,&
               &INLOC  ,VARNL(1,IT),LBUF%OFF)
            ELSEIF (ILAW == 52) THEN
               CALL SIGEPS52C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT  ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     , SIGY , EPSPL   ,TABLE)
            ELSEIF (ILAW == 55) THEN
               CALL SIGEPS55C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT  ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO     ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,ISRATE    )
            ELSEIF (ILAW == 56) THEN
               CALL SIGEPS56C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT  ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,DPLA     ,ISRATE )
            ELSEIF (ILAW == 57) THEN
               CALL SIGEPS57C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC  ,&
               &NPF    ,NPT    ,IPT     ,IFLAG    ,&
               &TF     ,TT     ,DT1C    ,UPARAM0   ,RHO    ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,SHF     ,ETSE     ,SIGY   ,&
               &HARDM  ,LBUF%SEQ,ISRATE ,EPSP     ,INLOC  ,&
               &VARNL(1,IT),LBUF%OFF)
            ELSEIF (ILAW == 58) THEN

               CALL SIGEPS58C(&
               &JLT     ,NUPARAM ,NUVAR   ,NFUNC    ,IFUNC  ,&
               &NPF     ,NPT     ,IPT     ,NSENSOR  ,&
               &TF      ,TT      ,DT1C    ,UPARAM   ,RHO    ,&
               &AREA    ,EINT    ,THKLYL  ,NIPARAM  ,IPARAM  ,&
               &EPSPXX  ,EPSPYY  ,EPSPXY  ,EPSPYZ   ,EPSPZX  ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ   ,DEPSZX  ,&
               &EPSXX   ,EPSYY   ,EPSXY   ,EPSYZ    ,EPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ   ,SIGNZX  ,&
               &SIGVXX  ,SIGVYY  ,SIGVXY  ,SIGVYZ   ,SIGVZX  ,&
               &SSP     ,VISCMX  ,THKN    ,LBUF%PLA ,UVAR    ,&
               &OFF     ,NGL     ,PM      ,MATLY(JMLY),ETSE  ,&
               &SHF     ,SIGY    ,EPSPL   ,LBUF%ANG ,&
               &ALDT    ,SENSORS%SENSOR_TAB,ISMSTR,TABLE    ,GBUF%OFF)

!
            ELSEIF (ILAW == 60) THEN
               IF (IGTYP /= 10.AND.IGTYP /= 11 .AND.IGTYP /= 17) THEN
                  CALL SIGEPS60C(&
                  &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
                  &NPF    ,NPT    ,IPT     ,IFLAG   ,&
                  &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
                  &AREA   ,EINT   ,THKLYL   ,&
                  &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
                  &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
                  &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
                  &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
                  &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
                  &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
                  &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
                  &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
                  &GS     ,SIGY   ,EPSPL   ,ISRATE   ,DPLA,SHF,&
                  &INLOC  ,VARNL(1,IT),LBUF%OFF)
               ELSE
                  CALL SIGEPS60C(&
                  &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
                  &NPF    ,NPT    ,IPT  ,IFLAG   ,&
                  &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
                  &AREA   ,EINT   ,THKLYL   ,&
                  &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
                  &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
                  &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
                  &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
                  &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
                  &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
                  &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
                  &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
                  &GS     ,SIGY   ,EPSPL   ,ISRATE   ,DPLA,SHF,&
                  &INLOC  ,VARNL(1,IT),LBUF%OFF)
               END IF
            ELSEIF (ILAW == 62) THEN
               CALL SIGEPS62C(&
               &JLT    , NUPARAM0, NUVAR   , NFUNC , IFUNC , NPF   ,&
               &NPT    , IPT    , IFLAG   ,&
               &TF     , TT     , DT1C    , UPARAM0, RHO  ,&
               &AREA   , EINT   , THKLYL  ,&
               &EPSPXX , EPSPYY , EPSPXY  , EPSPYZ, EPSPZX,&
               &DEPSXX , DEPSYY , DEPSXY  , DEPSYZ, DEPSZX,&
               &EPSXX  , EPSYY  , EPSXY   , EPSYZ , EPSZX ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX , SIGNYY , SIGNXY  , SIGNYZ, SIGNZX,&
               &SIGVXX , SIGVYY , SIGVXY  , SIGVYZ, SIGVZX,&
               &SSP    , VISCMX , THKN    ,UVAR   , OFF   ,&
               &NGL    , ISMSTR , IPM     , GS      )
            ELSEIF (ILAW == 63) THEN
               CALL SIGEPS63C(&
               &JLT,          NUPARAM0,      NUVAR,        NFUNC,&
               &IFUNC,        NPF,          NPT,          IPT,&
               &IFLAG,        TF,           TT,           DT1C,&
               &UPARAM0,       RHO,          AREA,         EINT,&
               &THKLYL,       EPSPXX,       EPSPYY,       EPSPXY,&
               &EPSPYZ,       EPSPZX,       DEPSXX,       DEPSYY,&
               &DEPSXY,       DEPSYZ,       DEPSZX,       EPSXX,&
               &EPSYY,        EPSXY,        EPSYZ,        EPSZX,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),&
               &LBUF%SIG(IJ5),SIGNXX,       SIGNYY,       SIGNXY,&
               &SIGNYZ,       SIGNZX,       SIGVXX,       SIGVYY,&
               &SIGVXY,       SIGVYZ,       SIGVZX,       SSP,&
               &VISCMX,       THKN,         LBUF%PLA,     UVAR,&
               &OFF,          NGL,          ETSE,         GS,&
               &VOL0,         SIGY,         TEMPEL,       DIE,&
               &COEF,         INLOC,        VARNL(1,IT),  JTHE,&
               &LBUF%OFF)
            ELSEIF (ILAW == 64) THEN
               CALL SIGEPS64C(&
               &JLT,          NUPARAM0,      NUVAR,        NFUNC,&
               &IFUNC,        NPF,          NPT,          IPT,&
               &IFLAG,        TF,           TT,           DT1C,&
               &UPARAM0,       RHO,          AREA,         EINT,&
               &THKLYL,       EPSPXX,       EPSPYY,       EPSPXY,&
               &EPSPYZ,       EPSPZX,       DEPSXX,       DEPSYY,&
               &DEPSXY,       DEPSYZ,       DEPSZX,       EPSXX,&
               &EPSYY,        EPSXY,        EPSYZ,        EPSZX,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),&
               &LBUF%SIG(IJ5),SIGNXX,       SIGNYY,       SIGNXY,&
               &SIGNYZ,       SIGNZX,       SIGVXX,       SIGVYY,&
               &SIGVXY,       SIGVYZ,       SIGVZX,       SSP,&
               &VISCMX,       THKN,         LBUF%PLA,     UVAR,&
               &OFF,          NGL,          IPM,          MATLY(JMLY),&
               &ETSE,         GS,           VOL0,         SIGY,&
               &TEMPEL,       DIE,          COEF,         INLOC,&
               &VARNL(1,IT),  JTHE,         LBUF%OFF)
            ELSEIF (ILAW == 65) THEN
               CALL SIGEPS65C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO,&
               &AREA   ,EINT   ,THKLYL   ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,ISRATE   ,DPLA   )
            ELSEIF (ILAW == 66) THEN
               CALL SIGEPS66C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT     ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,BUFMAT  ,RHO     ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,ISRATE   ,INLOC  ,&
               &VARNL(1,IT),MATPARAM    ,NUVARV  ,UVARV   ,&
               &LBUF%OFF)
            ELSEIF (ILAW == 69) THEN
               CALL SIGEPS69C(&
               &JLT    , NUPARAM0, NUVAR   , NFUNC , IFUNC , NPF   ,&
               &NPT    , IPT ,&
               &TF     , TT     , DT1C    , BUFMAT, RHO   ,&
               &AREA   , EINT   , THKLYL  ,&
               &EPSPXX , EPSPYY , EPSPXY  , EPSPYZ, EPSPZX,&
               &DEPSXX , DEPSYY , DEPSXY  , DEPSYZ, DEPSZX,&
               &EPSXX  , EPSYY  , EPSXY   , EPSYZ , EPSZX ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX , SIGNYY , SIGNXY  , SIGNYZ, SIGNZX,&
               &SIGVXX , SIGVYY , SIGVXY  , SIGVYZ, SIGVZX,&
               &SSP    , VISCMX , THKN    , UVAR  ,&
               &NGL    , OFF    , ISMSTR  , IPM   , GS    ,&
               &MAT    , NUVARV , UVARV )
            ELSEIF (ILAW == 71) THEN !ISMSTR = 10 always (set in cgrtails)
               CALL SIGEPS71C(&
               &JLT,          NUPARAM0,      NUVAR,        NFUNC,&
               &IFUNC,        NPF,          NPT,          IPT,&
               &IFLAG,        TF,           TT,           DT1C,&
               &UPARAM0,       RHO,          AREA,         EINT,&
               &THKLYL,       EPSPXX,       EPSPYY,       EPSPXY,&
               &EPSPYZ,       EPSPZX,       DEPSXX,       DEPSYY,&
               &DEPSXY,       DEPSYZ,       DEPSZX,       EPSXX,&
               &EPSYY,        EPSXY,        EPSYZ,        EPSZX,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),&
               &LBUF%SIG(IJ5),SIGNXX,       SIGNYY,       SIGNXY,&
               &SIGNYZ,       SIGNZX,       SIGVXX,       SIGVYY,&
               &SIGVXY,       SIGVYZ,       SIGVZX,       SSP,&
               &VISCMX,       THKN,         LBUF%PLA,     UVAR,&
               &OFF,          NGL,          IPM,          MATLY(JMLY),&
               &ETSE,         GS,           SIGY,         VOL0,&
               &TEMPEL,       ISMSTR,       JTHE)
            ELSEIF (ILAW == 72) THEN
               CALL SIGEPS72C(&
               &JLT      ,NUPARAM0  ,NUVAR    ,&
               &TT       ,DT1C     ,UPARAM0   ,RHO      ,THKLYL   ,&
               &DEPSXX   ,DEPSYY   ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &SSP      ,THKN     ,LBUF%PLA ,UVAR     ,OFF      ,&
               &ETSE     ,GS       ,SIGY     ,HARDM    ,LBUF%SEQ ,&
               &DPLA     ,LBUF%DMG ,INLOC    ,VARNL(1,IT),LBUF%OFF)
            ELSEIF (ILAW == 73) THEN
               CALL SIGEPS73C(&
               &JLT,          NUPARAM0,      NUVAR,        TT,&
               &DT1C,         UPARAM0,       RHO,          AREA,&
               &EINT,         THKLYL,       EPSPXX,       EPSPYY,&
               &EPSPXY,       EPSPYZ,       EPSPZX,       DEPSXX,&
               &DEPSYY,       DEPSXY,       DEPSYZ,       DEPSZX,&
               &EPSXX,        EPSYY,        EPSXY,        EPSYZ,&
               &EPSZX,        LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),&
               &LBUF%SIG(IJ4),LBUF%SIG(IJ5),SIGNXX,       SIGNYY,&
               &SIGNXY,       SIGNYZ,       SIGNZX,       SIGVXX,&
               &SIGVYY,       SIGVXY,       SIGVYZ,       SIGVZX,&
               &SSP,          VISCMX,       THKN,         LBUF%PLA,&
               &UVAR,         OFF,          NGL,          ITABLE,&
               &ETSE,         GS,           SIGY,         DPLA,&
               &EPSPL,        TABLE,        VOL0,         TEMPEL,&
               &DIE,          COEF,         NPF,          NFUNC,&
               &IFUNC,        TF,           SHF,          HARDM,&
               &LBUF%SEQ,     INLOC,        VARNL(1,IT),  JTHE,&
               &LBUF%OFF)
!
            ELSEIF (ILAW == 76) THEN

               CALL SIGEPS76C(&
               &JLT      ,NUPARAM0  ,NUVAR    ,NFUNC    ,IFUNC    ,&
               &NPF      ,TF        ,MATPARAM ,TT       ,DT1      ,&
               &UPARAM0  ,UVAR      ,RHO      ,OFF      ,NGL      ,&
               &DEPSXX   ,DEPSYY    ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &SSP      ,THKN     ,THKLYL   ,LBUF%PLA ,EPSP     ,&
               &ETSE     ,GS       ,SIGY     ,INLOC    ,BUFLY%L_PLANL,&
               &LBUF%PLANL,VARNL(1,IT),LBUF%DMG,&
               &NVARTMP  ,VARTMP   ,LBUF%OFF)
!
               EPSPL(1:NEL) = EPSP(1:NEL)
!
            ELSEIF (ILAW == 78) THEN
               CALL SIGEPS78C(&
               &JLT      ,NUPARAM0  ,NUVAR    ,NVARTMP  ,TT       ,&
               &NFUNC    ,IFUNC    ,NPF      ,TF       ,UPARAM0   ,&
               &THKLYL   ,THKN     ,GS       ,ETSE     ,SIGY     ,&
               &DEPSXX   ,DEPSYY   ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &SSP      ,UVAR     ,LBUF%SIGA,LBUF%SIGB,LBUF%SIGC,&
               &RHO      ,OFF      ,LBUF%PLA ,DPLA     ,VARTMP   ,&
               &INLOC    ,VARNL(1,IT),ET_IMP ,LBUF%SEQ ,LBUF%OFF)
            ELSEIF (ILAW == 80) THEN
               IF (ISRATE == 0) THEN
                  DO I=JFT,JLT
                     EPS_K2 = (KXX(I)*KXX(I)+KYY(I)*KYY(I)+KXX(I)*KYY(I)&
                     &+ FOURTH*KXY(I)*KXY(I)) *THK(I)*THK(I)*ONE_OVER_9
                     EPS_M2 = FOUR_OVER_3*(EXX(I)*EXX(I)+EYY(I)*EYY(I)+EXX(I)*EYY(I)&
                     &+ FOURTH*EXY(I)*EXY(I))
                     DTINV  = DT_INV(I)!DT1C(I)/MAX(DT1C(I)**2,EM20)
                     EPSP(I) = SQRT(EPS_M2+EPS_K2)*DTINV
                     EPSPL(I) = EPSP(I)
                  ENDDO
               ENDIF
               CALL SIGEPS80C(&
               &JLT,          NUPARAM0,      NUVAR,        NFUNC,&
               &IFUNC,        NPF,          NPT,          IPT,&
               &IFLAG,        TF,           TT,           DT1C,&
               &UPARAM0,       RHO,          AREA,         EINT,&
               &THKLYL,       EPSPXX,       EPSPYY,       EPSPXY,&
               &EPSPYZ,       EPSPZX,       DEPSXX,       DEPSYY,&
               &DEPSXY,       DEPSYZ,       DEPSZX,       EPSXX,&
               &EPSYY,        EPSXY,        EPSYZ,        EPSZX,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),&
               &LBUF%SIG(IJ5),SIGNXX,       SIGNYY,       SIGNXY,&
               &SIGNYZ,       SIGNZX,       SIGVXX,       SIGVYY,&
               &SIGVXY,       SIGVYZ,       SIGVZX,       SSP,&
               &VISCMX,       THKN,         LBUF%PLA,     UVAR,&
               &OFF,          NGL,          PM,           IPM,&
               &MATLY(JMLY),  ETSE,         GS,           VOL0,&
               &SIGY,         TEMPEL,       DIE,          COEF,&
               &SHF,          EPSPL,        TABLE,        ITHK,&
               &NVARTMP,      VARTMP,       EPSTHTOT,     JTHE)
            ELSEIF (ILAW == 82) THEN
               CALL SIGEPS82C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC  ,IFUNC  ,&
               &NPF    ,NPT    ,IPT     ,IFLAG  ,&
               &TF     ,TT     ,DT1C    ,&
               &UPARAM0 ,RHO    ,AREA    ,EINT   ,THKLYL,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ  ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,UVAR   ,&
               &NGL    ,OFF    ,ISMSTR  ,IPM    , GS    )
            ELSEIF(ILAW == 85)THEN
               CALL SIGEPS85C_VOID(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC    ,IFUNC  ,&
               &NPF    ,NPT    ,IPT     ,IFLAG    ,&
               &TF     ,TT     ,DT1C    ,UPARAM0   ,RHO    ,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,SHF     )
            ELSEIF (ILAW == 86) THEN
               CALL SIGEPS86C(&
               &JLT    ,NUPARAM0,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF    ,NPT    ,IPT     ,IFLAG   ,&
               &TF     ,TT     ,DT1C    ,UPARAM0  ,RHO,&
               &AREA   ,EINT   ,THKLYL  ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ   ,EPSPZX ,&
               &DEPSXX ,DEPSYY ,DEPSXY  ,DEPSYZ   ,DEPSZX ,&
               &EPSXX  ,EPSYY  ,EPSXY   ,EPSYZ    ,EPSZX  ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX ,SIGNYY ,SIGNXY  ,SIGNYZ   ,SIGNZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ   ,SIGVZX ,&
               &SSP    ,VISCMX ,THKN    ,LBUF%PLA ,UVAR   ,&
               &OFF    ,NGL    ,IPM     ,MATLY(JMLY),ETSE ,&
               &GS     ,SIGY   ,EPSPL   ,ISRATE   ,DPLA)
            ELSEIF (ILAW == 87) THEN
               ASRATE = PM(9,MX)
               CALL SIGEPS87C(&
               &JLT,          NUPARAM0,      NUVAR,        NFUNC,&
               &IFUNC,        NPF,          TF,           TT,&
               &DT1C,         UPARAM0,       UVAR,         RHO,&
               &THKLYL,       THKN,         OFF,          EPSPXX,&
               &EPSPYY,       EPSPXY,       EPSPYZ,       EPSPZX,&
               &DEPSXX,       DEPSYY,       DEPSXY,       DEPSYZ,&
               &DEPSZX,       LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),&
               &LBUF%SIG(IJ4),LBUF%SIG(IJ5),SIGNXX,       SIGNYY,&
               &SIGNXY,       SIGNYZ,       SIGNZX,       SSP,&
               &LBUF%PLA,     DPLA,         EPSPL,        SIGY,&
               &ETSE,         GS,           ISRATE,       ASRATE,&
               &YLDFAC,       TEMPEL,       LBUF%SIGB,    INLOC,&
               &VARNL(1,IT),  LBUF%SEQ,     JTHE,         LBUF%OFF)
            ELSEIF (ILAW == 88) THEN
               CALL SIGEPS88C(&
               &JLT    , NUPARAM0, NUVAR   , NFUNC , IFUNC , NPF   ,&
               &NPT    , IPT     ,NGL     , OFF    , ISMSTR   , GS ,&
               &TF     , TT     , DT1C    , BUFMAT(IADBUF), RHO   ,&
               &AREA   , EINT   , THKLYL  ,&
               &EPSPXX , EPSPYY , EPSPXY  , EPSPYZ, EPSPZX,&
               &DEPSXX , DEPSYY , DEPSXY  , DEPSYZ, DEPSZX,&
               &EPSXX  , EPSYY  , EPSXY   , EPSYZ , EPSZX ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX , SIGNYY , SIGNXY  , SIGNYZ, SIGNZX,&
               &SSP    , VISCMX , THKN    , UVAR )
            ELSEIF (ILAW == 93) THEN
               CALL SIGEPS93C(&
               &JLT      ,NUPARAM0  ,NUVAR    ,NFUNC    ,IFUNC    ,&
               &NPF      ,TF       ,TT       ,DT1C     ,UPARAM0   ,&
               &EPSPXX   ,EPSPYY   ,EPSPXY   ,EPSPYZ   ,EPSPZX   ,&
               &DEPSXX   ,DEPSYY   ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &SSP      ,THKN     ,LBUF%PLA ,UVAR     ,RHO      ,&
               &OFF      ,ETSE     ,THKLYL   ,SHF      ,SIGY     ,&
               &HARDM    ,LBUF%SEQ ,EPSP     ,ASRATE   ,NVARTMP  ,&
               &VARTMP   ,DPLA     ,INLOC    ,VARNL(1,IT),LBUF%OFF)
!
            ELSEIF (ILAW == 96)THEN
               CALL SIGEPS96C(&
               &JLT     ,NGL     ,NUPARAM0 ,NUVAR   ,NFUNC   ,IFUNC   ,&
               &NPF     ,TF      ,UPARAM0  ,UVAR    ,JTHE    ,GS      ,&
               &RHO     ,TEMPEL  ,LBUF%PLA,SSP     ,OFF     ,EPSPL   ,&
               &EPSPXX  ,EPSPYY  ,EPSPXY  ,EPSPYZ  ,EPSPZX  ,THKLYL  ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX  ,THKN    ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX  )
!
            ELSEIF (ILAW == 104 )THEN
!
               CALL SIGEPS104C(&
               &JLT     ,NGL     ,IPG     ,ILAYER  ,IT      ,NUPARAM0 ,NUVAR    ,&
               &DT1C    ,TT      ,UPARAM0 ,UVAR    ,JTHE    ,RHO      ,TEMPEL   ,&
               &LBUF%PLA,DPLA    ,SSP     ,LBUF%OFF,LBUF%EPSD,EPSPL   ,GS       ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX  ,THKLYL   ,OFF      ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX  ,THKN     ,SIGY     ,&
               &ETSE    ,VARNL(1,IT),LBUF%DMG,BUFLY%L_DMG,LBUF%TEMP,LBUF%SEQ,INLOC,&
               &ELBUF_STR%NPTR,ELBUF_STR%NPTS,ELBUF_STR%NPTT,BUFLY    ,LBUF%PLANL,&
               &BUFLY%L_PLANL ,LBUF%EPSDNL,BUFLY%L_EPSDNL,IOFF_DUCT   )
!
            ELSEIF (ILAW == 107 )THEN
               CALL SIGEPS107C(&
               &JLT     ,NGL     ,NUPARAM0 ,NUVAR   ,NFUNC   ,IFUNC   ,NPF     ,&
               &TF      ,DT1C    ,TT      ,UPARAM0  ,UVAR    ,JTHE    ,RHO     ,&
               &LBUF%PLA,DPLA    ,SSP     ,LBUF%EPSD,OFF     ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX  ,SHF     ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGY    ,SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX  ,&
               &ETSE    ,NUMTABL  ,ITABLE  ,TABLE   ,NVARTMP ,VARTMP   )
!
            ELSEIF (ILAW == 109 )THEN
               CALL SIGEPS109C(&
               &JLT     ,NGL     ,NUPARAM0,NUVAR   ,NVARTMP  ,NUMTABL  ,&
               &UPARAM0 ,UVAR    ,VARTMP  ,ITABLE  ,TABLE    ,JTHE     ,&
               &TT      ,DT1C    ,OFF     ,RHO     ,LBUF%PLA ,DPLA     ,&
               &SSP     ,SIGY    ,ETSE    ,EL_TEMP ,EPSP     ,GS       ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX   ,&
               &THKN    ,THKLYL  ,INLOC   ,VARNL(1,IT),EPSPL ,LBUF%OFF)
!
            ELSEIF (ILAW == 110 )THEN
               CALL SIGEPS110C(&
               &JLT     ,NGL     ,NUPARAM0 ,NUVAR   ,NPF      ,&
               &TT      ,DT1C    ,UPARAM0  ,UVAR    ,JTHE     ,OFF     ,&
               &GS      ,RHO     ,LBUF%PLA,DPLA    ,EPSP     ,SSP     ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX   ,ASRATE  ,&
               &EPSPXX  ,EPSPYY  ,EPSPXY  ,EPSPYZ  ,EPSPZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX   ,THKLYL  ,&
               &THKN    ,SIGY    ,ETSE    ,TEMPEL  ,LBUF%TEMP,LBUF%SEQ,&
               &TF      ,NUMTABL ,ITABLE  ,TABLE   ,NVARTMP  ,VARTMP  ,&
               &LBUF%SIGA,INLOC  ,VARNL(1,IT),EPSPL,LBUF%OFF ,IOFF_DUCT)
!
            ELSEIF (ILAW == 112 )THEN
               CALL SIGEPS112C(&
               &JLT     ,NGL     ,NUPARAM0 ,NUVAR   ,NFUNC   ,IFUNC   ,NPF     ,&
               &TF      ,DT1C    ,TT      ,UPARAM0  ,UVAR    ,JTHE    ,RHO     ,&
               &LBUF%PLA,DPLA    ,SSP     ,LBUF%EPSD,OFF     ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX  ,SHF     ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGY    ,SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX  ,&
               &ETSE    ,NUMTABL  ,ITABLE  ,TABLE   ,NVARTMP ,VARTMP   )
!
            ELSEIF (ILAW == 119 )THEN

               CALL SIGEPS119C(&
               &NEL      ,IPT      ,NPT      ,NUPARAM0  ,NUVAR    ,&
               &NUMTABL  ,ITABLE   ,TABLE    ,UVAR     ,UPARAM0   ,&
               &THKN     ,THKLYL   ,SHF      ,SSP      ,OFF      ,&
               &FLAG_ZCFAC,ZCFAC   ,DEPSXX   ,DEPSYY   ,DEPSXY   ,&
               &EPSXX    ,EPSYY    ,EPSXY    ,EPSYZ    ,EPSZX    ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &WMC      ,THKLY(JPOS),THK0)
!
            ELSEIF (ILAW == 121 )THEN
               CALL SIGEPS121C(&
               &JLT     ,NGL     ,NUPARAM0 ,NUVAR   ,NFUNC   ,IFUNC   ,NPF     ,&
               &TF      ,DT1C    ,TT      ,UPARAM0  ,UVAR    ,RHO     ,LBUF%PLA,&
               &DPLA    ,SSP     ,LBUF%EPSD,GS     ,THKN    ,THKLYL  ,OFF     ,&
               &DEPSXX  ,DEPSYY  ,DEPSXY  ,DEPSYZ  ,DEPSZX  ,&
               &EPSPXX  ,EPSPYY  ,EPSPXY  ,EPSPYZ  ,EPSPZX  ,EPSP    ,EPSPL   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX  ,SIGNYY  ,SIGNXY  ,SIGNYZ  ,SIGNZX  ,&
               &SIGY    ,ETSE    ,VARNL(1,IT),INLOC,GBUF%DT ,&
               &IPG     ,IT      ,ELBUF_STR%NPTR,ELBUF_STR%NPTS,ELBUF_STR%NPTT,&
               &BUFLY   ,LBUF%OFF,IOFF_DUCT)
!
            ELSEIF (ILAW == 122) THEN
               CALL SIGEPS122C(&
               &JLT      ,NUPARAM0 ,NUVAR    ,UPARAM0  ,UVAR     ,&
               &EPSXX    ,EPSYY    ,RHO      ,LBUF%PLA ,DPLA     ,&
               &DEPSXX   ,DEPSYY   ,DEPSXY   ,DEPSYZ   ,DEPSZX   ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &THKN     ,THKLYL   ,OFF      ,SIGY     ,ETSE     ,&
               &LBUF%DMG ,LBUF%SEQ ,SHF      ,SSP      ,&
               &EPSP     ,NFUNC    ,IFUNC    ,NPF      ,TF       ,&
               &NVARTMP  ,VARTMP   ,IOFF_DUCT)
!
            ELSEIF (ILAW == 125) THEN
               !---
               DO I=JFT,JLT
                  ! IJ(K) = NEL*(K-1)
                  SIGOXX(I) =  LBUF%SIG(NEL*(1-1)+I)
                  SIGOYY(I) =  LBUF%SIG(NEL*(2-1)+I)
                  ! SIGOXY(I) =  LBUF%SIG(NEL*(3-1)+I)
                  ! SIGOYZ(I) =  LBUF%SIG(NEL*(4-1)+I)
                  ! SIGOZX(I) =  LBUF%SIG(NEL*(5-1)+I)
               ENDDO
               !---
               CALL SIGEPS125C(&
               &JLT      ,MATPARAM   ,NUVAR    ,UVAR     ,&
               &RHO      ,THKN       ,THKLYL   , SHF     ,&
               &EPSXX    ,EPSYY      ,EPSXY    ,EPSYZ    ,EPSZX   ,&
               &SIGOXX   ,SIGOYY     ,&
               &SIGNXX   ,SIGNYY     ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
               &OFF      ,SIGY       ,ETSE     ,SSP  )
!
            ELSEIF (ILAW == 158) THEN

               CALL SIGEPS158C(&
               &JLT       ,NUPARAM   ,NUVAR     ,NFUNC     ,IFUNC     ,&
               &NPF       ,TF        ,TT        ,DT1       ,UPARAM    ,&
               &AREA      ,THKLYL    ,SSP       ,VISCMX    ,UVAR      ,&
               &DEPSXX    ,DEPSYY    ,DEPSXY    ,DEPSYZ    ,DEPSZX    ,&
               &EPSXX     ,EPSYY     ,EPSXY     ,EPSYZ     ,EPSZX     ,&
               &LBUF%SIG(IJ1),LBUF%SIG(IJ2),LBUF%SIG(IJ3),LBUF%SIG(IJ4),LBUF%SIG(IJ5),&
               &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
               &SIGVXX    ,SIGVYY    ,SIGVXY    ,LBUF%ANG  ,GBUF%OFF  ,&
               &RHO       ,ETSE      ,SHF       ,ALDT      ,NSENSOR   ,&
               &SENSORS%SENSOR_TAB   ,NIPARAM   ,IPARAM    )
!
            ENDIF !ILAW
!
!  visco elastic model (prony)
!
            IF(MATPARAM%IVISC == 1 .AND. ILAW /= 25) THEN
               NPRONY = MATPARAM%VISC%IPARAM(1)
               KV     = MATPARAM%VISC%UPARAM(1)
!
               ALLOCATE(GV(NPRONY),BETA(NPRONY))
               DO I=1,NPRONY
                  GV(I)   = MATPARAM%VISC%UPARAM(1 + I)
                  BETA(I) = MATPARAM%VISC%UPARAM(1 + NPRONY + I)
               ENDDO
!
               CALL PRONY_MODELC(&
               &NEL    ,NUVARV  ,TT    ,DT1C ,&
               &NPRONY , KV   , GV   ,BETA    ,RHO   ,&
               &EPSPXX ,EPSPYY ,EPSPXY  ,EPSPYZ  ,EPSPZX ,&
               &SIGVXX ,SIGVYY ,SIGVXY  ,SIGVYZ  ,SIGVZX ,&
               &SSP,UVARV   ,OFF)
               DEALLOCATE(GV,BETA)
            ENDIF
!-------------------------------------------
            DO I=JFT,JLT
               VISCMX(I) = MAX(DM,VISCMX(I))
            ENDDO
!-------------------------------------------
!         End of material laws
!-----------------------------------------------
!         Failure models
!-----------------------------------------------
            IF (IFAILURE == 1) THEN
               IF ((ITASK==0).AND.(IMON_MAT==1))CALL STARTIME(121,1)
!
               IF (IXFEM > 0) THEN
                  DO I=JFT,JLT
                     TENSX(I,1) = ZERO
                     TENSX(I,2) = ZERO
                     TENSX(I,3) = ZERO
                     TENSX(I,4) = ZERO
                     TENSX(I,5) = ZERO
                  ENDDO
               ENDIF
!
               SIGOFF(1:NEL) = ONE
               DMG_LOC_SCALE(1:NEL) = ONE  ! local dmg scale by integration point and failure model
               DMG_ORTH_SCALE(1:NEL,1:5) = ONE
!
               MPT  = NPTTOT * MAX(1,NPG)
               FBUF => BUFLY%FAIL(IR,IS,IT)
!
               ! Length used for regularization (failure criterion parameters scaling)
               !  -> If non-local, criterion parameters are scaled with LE_MAX parameter
               IF (INLOC > 0) THEN
                  LE_MAX(1:NEL) = NLOC_DMG%LE_MAX(MAT(1))
                  EL_LEN => LE_MAX(1:NEL)
                  !  -> If not, criterion parameters are scaled with the element characteristic length
               ELSE
                  EL_LEN => ALDT(1:NEL)
               ENDIF
!
!           plastic strain increment for all plastic laws
               IF (BUFLY%L_PLA > 0) THEN
                  ! Non-local material
                  IF (INLOC > 0) THEN
                     DO I=JFT,JLT
                        DPLA(I)  = MAX(VARNL(I,IT),ZERO)
                        EPSPL(I) = LBUF%EPSDNL(I)
                     ENDDO
                     EL_PLA => LBUF%PLANL(1:NEL)
                     ! Classical local material
                  ELSE
                     DO I=JFT,JLT
                        DPLA(I) = LBUF%PLA(I) - PLA0(I)
                     ENDDO
                     EL_PLA => LBUF%PLA(1:NEL)
                  ENDIF
               ENDIF
!
               IF (IXFEM == 1) THEN
                  UELR1 => ELBUF_STR%BUFLY(ILAYER)%UELR1
               ELSE
                  UELR1 => GBUF%UELR1
               ENDIF
               IF (IXLAY == 0) THEN  ! standard element
                  UELR  => GBUF%UELR
               ELSEIF (IXLAY > 0) THEN ! xfem phantom element
                  UELR  => ELBUF_STR%BUFLY(IXLAY)%UELR
               ENDIF
               DADV => GBUF%DMG(1:NEL)  ! used outside this routine for frontwave propagation
!---
               OFFL => LBUF%OFF
               OFFLY=> BUFLY%OFF
               ZT   = POSLY(1,IPT)
!---
               DO IFL = 1, NFAIL      ! loop over fail models in current layer
                  UVARF  => FBUF%FLOC(IFL)%VAR
                  NVARF  =  FBUF%FLOC(IFL)%NVAR
                  IRUPT  =  FBUF%FLOC(IFL)%ILAWF
                  DAM    => FBUF%FLOC(IFL)%DAM
                  DFMAX  => FBUF%FLOC(IFL)%DAMMX
                  DAMINI => FBUF%FLOC(IFL)%DAMINI
                  TDEL   => FBUF%FLOC(IFL)%TDEL
                  FLD_IDX=> FBUF%FLOC(IFL)%INDX
                  FOFF   => FBUF%FLOC(IFL)%OFF
                  LF_DAMMX   = FBUF%FLOC(IFL)%LF_DAMMX
                  NUPAR      =  MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%NUPARAM
                  NIPAR      =  MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%NIPARAM
                  NFUNC_FAIL =  MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%NFUNC
                  NTABL_FAIL =  MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%NTABLE
                  UPARAMF    => MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%UPARAM(1:NUPAR)
                  IPARAMF    => MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%IPARAM(1:NIPAR)
                  IFUNC_FAIL => MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%IFUNC(1:NFUNC_FAIL)
                  ITABL_FAIL => MAT_ELEM%MAT_PARAM(IMAT)%FAIL(IFL)%TABLE(1:NTABL_FAIL)
!              IF (IXFEM == 0) PTHKF(ILAYER,IFL) = ZERO
!------------------------------------
                  SELECT CASE (IRUPT)
!------------------------------------
                   CASE (1)     !    Johnson-Cook
                     IF (IXFEM == 0) THEN
                        CALL FAIL_JOHNSON_C(&
                        &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                        &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                        &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                        &DPLA      ,EPSPL     ,TSTAR     ,OFF       ,FOFF      ,&
                        &DFMAX     ,TDEL      )
                     ELSE IF (MATPARAM%IXFEM > 0) THEN
                        CALL FAIL_JOHNSON_XFEM(&
                        &NEL      ,NUPAR    ,UPARAMF  ,NVARF    ,UVARF    ,&
                        &TT       ,TENSX    ,DPLA     ,EPSPL    ,TSTAR    ,&
                        &NGL      ,IPT      ,MPT      ,NPTT     ,UELR1    ,&
                        &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                        &OFF      ,OFFL     ,GBUF%NOFF,DFMAX    ,TDEL     ,&
                        &ELCRKINI ,IXFEM    ,IXEL     ,ILAYER   ,IT       )
                     ENDIF
!
                   CASE (2)     !    Tuler Butcher
                     IF (IXFEM == 0) THEN
                        CALL FAIL_TBUTCHER_C(&
                        &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                        &TT        ,DT1C      ,IPG       ,ILAYER    ,IT        ,&
                        &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                        &NGL       ,OFF       ,FOFF      ,DFMAX     ,TDEL      )
                     ELSE IF (MATPARAM%IXFEM > 0) THEN
                        CALL FAIL_TBUTCHER_XFEM(&
                        &NEL      ,NUPAR    ,UPARAMF  ,NVARF    ,UVARF    ,&
                        &TT       ,DT1C     ,TENSX    ,DFMAX    ,TDEL     ,&
                        &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                        &NGL      ,IPT      ,MPT      ,&
                        &GBUF%NOFF,OFF      ,OFFL     ,ELCRKINI ,IXFEM    ,&
                        &IXEL     ,ILAYER   ,IT       ,NPTT     ,UELR1    )
                     ENDIF
!
                   CASE (3)     !    Wilkins
                     CALL FAIL_WILKINS_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &DPLA      ,FOFF      ,DFMAX     ,TDEL      )
!
                   CASE (4)     !    User1
                     DO I=JFT,JLT
                        COPY_PLA(I) = LBUF%PLA(I)
                     ENDDO
                     IF (LOGICAL_USERL_AVAIL)THEN
                        TT_LOCAL = TT
                        CALL ENG_USERLIB_FLAWC(IRUPT,NEL ,NUPAR,NVARF,NFUNC_FAIL,IFUNC_FAIL,NPF,&
                        &TF  ,TT_LOCAL    ,DT1C  ,UPARAMF,NGL ,IPT,&
                        &MPT ,IPG ,IBIDON2,IBIDON3  ,&
                        &SIGNXX   ,SIGNYY ,SIGNXY ,SIGNYZ ,SIGNZX  ,&
                        &EPSPXX   ,EPSPYY ,EPSPXY ,EPSPYZ ,EPSPZX  ,&
                        &EPSXX    ,EPSYY  ,EPSXY  ,EPSYZ  ,EPSZX   ,&
                        &COPY_PLA ,DPLA   ,EPSPL  ,UVARF  ,UELR    ,&
                        &OFF      ,ALDT   ,AREA   ,BIDON3,BIDON4,BIDON5 )
                     ELSE
                        ! ----------------
                        ! ERROR to be printed & exit
                        OPTION='/FAIL/USER1 - SHELL '
                        SIZE=LEN_TRIM(OPTION)
                        CALL ANCMSG(MSGID=257,C1=OPTION(1:SIZE),ANMODE=ANINFO)
                        CALL ARRET(2)
                        ! ----------------
!!!
                     ENDIF
                     DO I=JFT,JLT
                        LBUF%PLA(I) = COPY_PLA(I)
                     ENDDO

!
                   CASE (5)     !    User2
                     DO I=JFT,JLT
                        COPY_PLA(I) = LBUF%PLA(I)
                     ENDDO
                     IF (LOGICAL_USERL_AVAIL)THEN
                        TT_LOCAL = TT
                        CALL ENG_USERLIB_FLAWC(IRUPT,NEL ,NUPAR,NVARF,NFUNC_FAIL,IFUNC_FAIL,NPF,&
                        &TF  ,TT_LOCAL,DT1C  ,UPARAMF,NGL ,IPT,&
                        &MPT ,IPG ,IBIDON2,IBIDON3  ,&
                        &SIGNXX   ,SIGNYY ,SIGNXY ,SIGNYZ ,SIGNZX  ,&
                        &EPSPXX   ,EPSPYY ,EPSPXY ,EPSPYZ ,EPSPZX  ,&
                        &EPSXX    ,EPSYY  ,EPSXY  ,EPSYZ  ,EPSZX   ,&
                        &COPY_PLA ,DPLA   ,EPSPL  ,UVARF  ,UELR    ,&
                        &OFF      ,ALDT   ,AREA   ,BIDON3,BIDON4,BIDON5 )
                     ELSE
                        ! ----------------
                        ! ERROR to be printed & exit
                        OPTION='/FAIL/USER2 - SHELL '
                        SIZE=LEN_TRIM(OPTION)
                        CALL ANCMSG(MSGID=257,C1=OPTION(1:SIZE),ANMODE=ANINFO)
                        CALL ARRET(2)
                        ! ----------------
!!!
                     ENDIF
                     DO I=JFT,JLT
                        LBUF%PLA(I) = COPY_PLA(I)
                     ENDDO

!
                   CASE (6)     !    User3
                     DO I=JFT,JLT
                        COPY_PLA(I) = LBUF%PLA(I)
                     ENDDO
                     IF (LOGICAL_USERL_AVAIL)THEN
                        TT_LOCAL = TT
                        CALL ENG_USERLIB_FLAWC(IRUPT,NEL ,NUPAR,NVARF,NFUNC_FAIL,IFUNC_FAIL,NPF,&
                        &TF  ,TT_LOCAL      ,DT1C  ,UPARAMF,NGL ,IPT,&
                        &MPT ,IPG ,IBIDON2,IBIDON3  ,&
                        &SIGNXX   ,SIGNYY ,SIGNXY ,SIGNYZ ,SIGNZX  ,&
                        &EPSPXX   ,EPSPYY ,EPSPXY ,EPSPYZ ,EPSPZX  ,&
                        &EPSXX    ,EPSYY  ,EPSXY  ,EPSYZ  ,EPSZX   ,&
                        &COPY_PLA ,DPLA   ,EPSPL  ,UVARF  ,UELR    ,&
                        &OFF      ,ALDT   ,AREA   ,BIDON3,BIDON4,BIDON5 )
                     ELSE
                        ! ----------------
                        ! ERROR to be printed & exit
                        OPTION='/FAIL/USER3 - SHELL '
                        SIZE=LEN_TRIM(OPTION)
                        CALL ANCMSG(MSGID=257,C1=OPTION(1:SIZE),ANMODE=ANINFO)
                        CALL ARRET(2)
                        ! ----------------
!!!
                     ENDIF
                     DO I=JFT,JLT
                        LBUF%PLA(I) = COPY_PLA(I)
                     ENDDO
!
                   CASE (7)     !    FLD
                     DO I=JFT,JLT
                        ZT=POSLY(I,IPT) *THK0(I)
                        EPSXX(I)= GSTR(I,1)+ZT*GSTR(I,6)
                        EPSYY(I)= GSTR(I,2)+ZT*GSTR(I,7)
                        EPSXY(I)= GSTR(I,3)+ZT*GSTR(I,8)
                        EPSYZ(I)= GSTR(I,4)
                        EPSZX(I)= GSTR(I,5)
                     ENDDO
                     IF (IXFEM == 0) THEN
                        CALL FAIL_FLD_C(&
                        &NEL       ,NUPAR     ,NFUNC_FAIL,IFUNC_FAIL ,&
                        &NPF       ,TF        ,TT        ,UPARAMF    ,&
                        &NGL       ,IPG       ,ILAYER    ,IT         ,&
                        &EPSXX     ,EPSYY     ,EPSXY     ,&
                        &DEPSXX    ,DEPSYY    ,DEPSXY    ,EL_PLA     ,&
                        &ZT        ,OFF       ,FOFF      ,TDEL       ,&
                        &FLD_IDX   ,DAM       ,DFMAX     ,DT1        ,&
                        &NIPAR     ,IPARAMF   ,NVARF     ,UVARF      )
                     ELSE IF (MATPARAM%IXFEM > 0) THEN
                        CALL FAIL_FLD_XFEM(&
                        &NEL       ,NUPAR     ,NVARF     ,NFUNC_FAIL,IFUNC_FAIL,&
                        &NPF       ,TF        ,TT        ,UPARAMF   ,&
                        &NGL       ,IPT       ,MPT       ,SSP       ,TENSX     ,&
                        &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                        &EPSXX     ,EPSYY     ,EPSXY     ,EPSYZ     ,EPSZX     ,&
                        &UVARF     ,GBUF%NOFF ,OFF       ,&
                        &ELCRKINI  ,IXFEM     ,IXEL      ,ILAYER    ,IT        ,&
                        &OFFL      ,NPTT      ,UELR1     ,DFMAX     ,TDEL      ,&
                        &DAM       ,FLD_IDX   ,NIPAR     ,IPARAMF   ,EL_PLA    ,&
                        &DEPSXX    ,DEPSYY    ,DEPSXY    ,DT1       )
                     ENDIF
!
                   CASE (9)     !    Xue_wierzbicki
                     CALL FAIL_WIERZBICKI_C(&
                     &NEL       ,NUPAR     ,UPARAMF   ,NVARF     ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &DPLA      ,OFF       ,FOFF      ,DFMAX     ,&
                     &TDEL      )
!
                   CASE (10)     !    Tension Strain failure model
                     CALL FAIL_TENSSTRAIN_C(&
                     &NEL       ,NFUNC_FAIL    ,NUPAR     ,NVARF     ,IFUNC_FAIL    ,&
                     &UPARAMF   ,UVARF     ,NPF       ,TF        ,TT        ,&
                     &NGL       ,IPG       ,ILAYER    ,IT        ,EPSPL     ,&
                     &EPSXX     ,EPSYY     ,EPSXY     ,EPSYZ     ,EPSZX     ,&
                     &OFF       ,FOFF      ,DFMAX     ,TDEL      ,&
                     &DMG_FLAG  ,DMG_LOC_SCALE ,ALDT  ,TSTAR     ,ISMSTR    )
!
                   CASE (11)     !    Energy failure model
                     CALL FAIL_ENERGY_C(&
                     &NEL       ,NUPAR     ,NVARF     ,NFUNC_FAIL   ,IFUNC_FAIL     ,&
                     &UPARAMF   ,UVARF     ,NPF       ,TF       ,TT         ,&
                     &NGL       ,IPG       ,ILAYER    ,IT       ,EPSPL      ,&
                     &AREA      ,THKN      ,DMG_FLAG  ,&
                     &DMG_LOC_SCALE ,OFF   ,FOFF      ,DFMAX    ,TDEL       ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ   ,SIGNZX     ,&
                     &DEPSXX    ,DEPSYY    ,DEPSXY    ,DEPSYZ   ,DEPSZX     )
!
                   CASE (13)     !    Chang-Chang failure model
                     CALL FAIL_CHANGCHANG_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,DT1C      ,IPG       ,ILAYER    ,IT        ,&
                     &NGL       ,DMG_FLAG  ,DMG_LOC_SCALE ,DFMAX ,TDEL      ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,LF_DAMMX  )
!
                   CASE (14)     !    Hashin failure model
                     DO I=JFT,JLT
                        EPSP(I) = MAX(ABS(EPSPXX(I)),ABS(EPSPYY(I)),&
                        &ABS(EPSPXY(I)),EM20)
                     ENDDO
                     CALL FAIL_HASHIN_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF      ,&
                     &TT        ,DT1C      ,IPG       ,ILAYER    ,IT         ,&
                     &NGL       ,DMG_FLAG  ,DMG_LOC_SCALE,DFMAX  ,TDEL       ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX     ,&
                     &OFF       ,FOFF      ,PLY_ID    ,&
                     &EPSP      ,FWAVE_EL  ,GBUF%DMG  ,LF_DAMMX  )
!
                   CASE (16)     !    Modified Puck failure model
                     CALL FAIL_PUCK_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &DFMAX     ,LF_DAMMX  ,TDEL      ,DT1C      )
!
                   CASE (23)     !    Tabulated failure model
                     IF (IXFEM == 0) THEN
                        CALL FAIL_TAB_C(&
                        &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                        &NFUNC_FAIL,IFUNC_FAIL,TABLE     ,NPF       ,TF        ,&
                        &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                        &SIGNXX    ,SIGNYY    ,SIGNXY    ,NTABL_FAIL,ITABL_FAIL,&
                        &DPLA      ,EPSPL     ,THKN      ,EL_LEN    ,TSTAR     ,&
                        &DMG_FLAG  ,DMG_LOC_SCALE ,OFF   ,FOFF      ,&
                        &DFMAX     ,TDEL      ,INLOC     )
                     ELSE IF (MATPARAM%IXFEM > 0) THEN
                        CALL FAIL_TAB_XFEM(&
                        &NEL      ,NUPAR    ,NVARF    ,NPF      ,TF       ,&
                        &TT       ,DT1C     ,UPARAMF  ,NGL      ,IPT      ,&
                        &MPT      ,NFUNC_FAIL,IFUNC_FAIL   ,TABLE    ,&
                        &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                        &DPLA     ,EPSPL    ,TSTAR    ,TENSX    ,UVARF    ,&
                        &GBUF%NOFF,ALDT     ,OFF      ,OFFL     ,ELCRKINI ,&
                        &IXFEM    ,IXEL     ,ILAYER   ,DFMAX    ,TDEL     ,&
                        &DMG_FLAG ,NTABL_FAIL,ITABL_FAIL)
                     ENDIF
!
                   CASE (24)     !    Orthotropic strain failure model
                     CALL FAIL_ORTHSTRAIN_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &NFUNC_FAIL    ,IFUNC_FAIL    ,NPF       ,TF        ,NGL       ,&
                     &TT        ,DT1       ,IPG       ,ILAYER    ,IT        ,&
                     &EPSXX     ,EPSYY     ,EPSXY     ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &EPSPXX    ,EPSPYY    ,EPSPXY    ,ALDT      ,ISMSTR    ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,&
                     &OFF       ,OFFLY     ,FOFF      ,DFMAX     ,TDEL      )
!
                   CASE (25)     !    NXT Failure
                     CALL FAIL_NXT_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NPF       ,TF        ,NFUNC_FAIL    ,IFUNC_FAIL    ,&
                     &NGL       ,IPG       ,ILAYER    ,IT        ,HARDM     ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,DFMAX     ,TDEL      ,LF_DAMMX  )
!
                   CASE (28)     !    windshield failure (Christian Alter model)
                     IROT   =  ELBUF_STR%BUFLY(ILAYER)%LY_DIRA
                     CRKDIR => ELBUF_STR%BUFLY(ILAYER)%CRKDIR
                     IFAILWV = FAILWAVE%WAVE_MOD
                     PROGRESSIVE_CRACK = 1
                     ORTH_DAMAGE = 1
!
                     IF (IXFEM > 0) THEN
                        IF (IXEL == 0) THEN
                           CRKLEN => ELBUF_STR%BUFLY(ILAYER)%DMG(1:NEL)
                        ELSE
                           CRKLEN => ALDT(1:NEL)
                        ENDIF
                        CALL FAIL_WIND_XFEM(&
                        &NEL        ,NUPAR      ,NVARF      ,UPARAMF    ,UVARF      ,&
                        &TT         ,DT1        ,SSP        ,ALDT       ,CRKLEN     ,&
                        &ELCRKINI   ,UELR1      ,OFF        ,OFFLY      ,&
                        &SIGNXX     ,SIGNYY     ,SIGNXY     ,SIGNYZ     ,SIGNZX     ,&
                        &NGL        ,IXEL       ,ILAYER     ,IPT        ,NPTT       ,&
                        &IXFEM      ,IROT       ,DIR_A(JDIR),DIR1_CRK   ,DIR2_CRK   ,&
                        &CRKDIR     )
!
                     ELSEIF (IFAILWV > 0) THEN
                        CALL FAIL_WIND_FRWAVE(&
                        &NEL        ,NUPAR      ,NVARF      ,UPARAMF    ,UVARF      ,&
                        &TT         ,DT1        ,SSP        ,ALDT       ,FWAVE_EL   ,&
                        &UELR       ,UELR1      ,OFF        ,OFFLY      ,FOFF       ,&
                        &SIGNXX     ,SIGNYY     ,SIGNXY     ,DFMAX      ,NGL        ,&
                        &ILAYER     ,IPT        ,NPTT       ,CRKDIR     ,DADV       ,&
                        &DMG_FLAG   ,TRELAX     ,THK0       )
                     ENDIF
!
                   CASE (30)     !    Biquadratic failure model
                     CALL FAIL_BIQUAD_C(&
                     &JLT      ,NVARF   ,&
                     &TT       ,UPARAMF ,NGL      ,IPT      ,MPT      ,&
                     &SIGNXX   ,SIGNYY  ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &DPLA     ,EPSPL   ,UVARF    ,UELR1    ,&
                     &OFF      ,OFFL    ,DFMAX    ,TDEL     ,NFUNC_FAIL   ,&
                     &IFUNC_FAIL,NPF     ,TF       ,EL_LEN   ,FOFF     ,IPG      ,&
                     &DMG_FLAG,DMG_LOC_SCALE)
!
                   CASE (31)     !    Anisotropic fabric failure model
!
                     IF (ISMSTR == 11) THEN
                        EPS1(1:NEL) = DEPSXX(1:NEL)
                        EPS2(1:NEL) = DEPSYY(1:NEL)
                     ELSE
                        II = NEL*3
                        JJ = NEL + II
                        EPS1(1:NEL) = UVAR(II:II+NEL)
                        EPS2(1:NEL) = UVAR(JJ:JJ+NEL)
                     ENDIF
                     CALL FAIL_FABRIC_C(&
                     &NEL      ,NGL       ,NUPAR     ,NVARF     ,NFUNC_FAIL    ,&
                     &UPARAMF  ,UVARF     ,IFUNC_FAIL    ,TT        ,DT1       ,&
                     &NPF      ,TF        ,DEPSXX     ,DEPSYY     ,EPS1      ,&
                     &EPS2     ,SIGNXX    ,SIGNYY    ,DFMAX     ,TDEL      ,&
                     &IPG      ,ILAYER    ,IT        ,OFF       ,FOFF      )
!
                   CASE (32)     !    HC_DSSE failure model
                     CALL FAIL_HC_DSSE_C(&
                     &NEL      ,NUPAR    ,NVARF    ,UPARAMF   ,UVARF     ,&
                     &TT       ,NGL      ,IPT      ,ILAYER    ,IT        ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX     ,&
                     &DPLA     ,OFF      ,FOFF     ,&
                     &DFMAX    ,TDEL     ,UELR1    ,MPT      ,&
                     &FLD_IDX  ,DAM      ,EL_PLA   )
!
                   CASE (34)     !    Cockcroft-Latham failure model
                     CALL FAIL_COCKROFT_C(&
                     &JLT      ,NVARF    ,&
                     &TT       ,UPARAMF  ,NGL      ,IPT      ,ILAYER    ,&
                     &MPT      ,IT       ,IPG       ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,&
                     &EPSXX    ,EPSYY    ,EPSXY    ,EPSYZ    ,EPSZX     ,&
                     &DPLA     ,UVARF    ,UELR1    ,FOFF     ,&
                     &OFF      ,DFMAX    ,TDEL   )
!
                   CASE (36)     !    Visual failure model
                     IF (ILAW == 2) THEN
                        DO I=JFT,JLT
                           ZT=POSLY(I,IPT) *THK0(I)
                           EPSXX(I)= GSTR(I,1)+ZT*GSTR(I,6)
                           EPSYY(I)= GSTR(I,2)+ZT*GSTR(I,7)
                           EPSXY(I)= GSTR(I,3)+ZT*GSTR(I,8)
                        ENDDO
                     ENDIF
                     CALL FAIL_VISUAL_C(&
                     &JLT      ,NVARF   ,TT       ,DT1     ,UPARAMF  ,NGL      ,&
                     &SIGNXX   ,SIGNYY  ,SIGNXY   ,EPSXX   ,EPSYY    ,EPSXY    ,&
                     &UVARF    ,OFF     ,DFMAX    ,ISMSTR  )
!
                   CASE (37)     !    old (obsolete) tabulated failure model
                     IF (IXFEM == 0) THEN
                        CALL FAIL_TAB_OLD_C(&
                        &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                        &NFUNC_FAIL    ,IFUNC_FAIL    ,NPF       ,TF        ,&
                        &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                        &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                        &DPLA      ,EPSPL     ,THKN      ,EL_LEN    ,TSTAR     ,&
                        &OFF       ,FOFF      ,DFMAX     ,TDEL      )
                     ELSE IF (MATPARAM%IXFEM > 0) THEN
                        CALL FAIL_TAB_OLD_XFEM(&
                        &NEL      ,NUPAR    ,NVARF    ,NPF      ,TF       ,&
                        &TT       ,DT1C     ,UPARAMF  ,NGL      ,IPT      ,&
                        &MPT      ,NFUNC_FAIL   ,IFUNC_FAIL   ,DMG_FLAG ,&
                        &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                        &DPLA     ,EPSPL    ,TSTAR    ,TENSX    ,UVARF    ,&
                        &GBUF%NOFF,ALDT     ,OFF      ,OFFL     ,ELCRKINI ,&
                        &IXFEM    ,IXEL     ,ILAYER   ,DFMAX    ,TDEL     )
                     ENDIF
!
                   CASE (38)     !    Orthotropic biquad
!
                     CALL FAIL_ORTHBIQUAD_C(&
                     &JLT      ,NVARF   ,&
                     &TT       ,UPARAMF ,NGL      ,IPT      ,MPT      ,&
                     &SIGNXX   ,SIGNYY  ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &DPLA     ,EPSPL   ,UVARF    ,UELR1    ,&
                     &OFF      ,OFFL    ,DFMAX    ,TDEL     ,NFUNC_FAIL   ,&
                     &IFUNC_FAIL,NPF    ,TF       ,EL_LEN   ,FOFF     ,IPG    )
!
                   CASE (39)     !    GENE1
!
                     CALL FAIL_GENE1_C(&
                     &JLT      ,NUPAR    ,NVARF    ,NFUNC_FAIL,IFUNC_FAIL,&
                     &NPF      ,TF       ,TT       ,DT1C     ,UPARAMF  ,IPG      ,&
                     &NGL      ,GBUF%DT  ,EPSPL    ,UVARF    ,OFF      ,&
                     &EPSXX    ,EPSYY    ,EPSXY    ,AREA     ,THKN     ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &EL_TEMP  ,DFMAX    ,ALDT     ,TABLE    ,TDEL     ,&
                     &THK0     ,IPT      ,FOFF     ,THKLYL   ,NTABL_FAIL,ITABL_FAIL,&
                     &LF_DAMMX ,NIPAR    ,IPARAMF  )
!
                   CASE (40)     !    RTCL
!
                     CALL FAIL_RTCL_C(&
                     &JLT      ,NUPAR    ,NVARF    ,TT       ,DT1C     ,UPARAMF  ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,MPT      ,&
                     &NGL      ,DPLA     ,UVARF    ,OFF      ,DFMAX    ,TDEL     ,&
                     &AREA     ,FOFF     ,IGTYP    ,OFFL     ,IPT      ,THK0     )
!
                   CASE (41)     !    TAB2
!
                     CALL FAIL_TAB2_C(&
                     &JLT      ,NUPAR    ,NVARF    ,NFUNC_FAIL   ,IFUNC_FAIL   ,&
                     &NPF      ,TABLE    ,TF       ,TT       ,UPARAMF  ,&
                     &NGL      ,EL_LEN   ,DPLA     ,EPSPL    ,UVARF    ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &EL_TEMP  ,FOFF     ,DFMAX    ,TDEL     ,IPT      ,&
                     &IPG      ,DMG_FLAG ,DMG_LOC_SCALE,NTABL_FAIL,ITABL_FAIL)
!
                   CASE (42)     !    INIEVO
!
                     CALL FAIL_INIEVO_C(&
                     &JLT      ,NUPAR    ,NVARF    ,&
                     &TABLE    ,NTABL_FAIL,ITABL_FAIL   ,TT       ,UPARAMF  ,&
                     &NGL      ,EL_LEN   ,DPLA     ,EPSPL    ,UVARF    ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &EL_PLA   ,EL_TEMP  ,SIGY     ,FOFF     ,DFMAX    ,&
                     &TDEL     ,IPT      ,IPG      ,DMG_FLAG ,DMG_LOC_SCALE,&
                     &DAMINI   ,AREA     ,INLOC    ,NPG      )
!
                   CASE (43)     !    Syazwan failure model
!
                     CALL FAIL_SYAZWAN_C(&
                     &JLT      ,UPARAMF  ,NUPAR    ,UVARF    ,NVARF    ,&
                     &TT       ,NGL      ,IPT      ,DPLA     ,EL_PLA   ,&
                     &SIGNXX   ,SIGNYY   ,SIGNXY   ,SIGNYZ   ,SIGNZX   ,&
                     &EPSXX    ,EPSYY    ,EPSXY    ,EPSYZ    ,EPSZX    ,&
                     &DFMAX    ,NFUNC_FAIL   ,IFUNC_FAIL   ,EL_LEN   ,FOFF     ,&
                     &IPG      ,DMG_FLAG ,DMG_LOC_SCALE,NPF  ,TF       )
!
                   CASE (44)     !    Tsai-Wu criterion
!
                     CALL FAIL_TSAIWU_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &DFMAX     ,LF_DAMMX  ,TDEL      ,DT1C      )
!
                   CASE (45)     !    Tsai-Hill criterion
!
                     CALL FAIL_TSAIHILL_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &DFMAX     ,LF_DAMMX  ,TDEL      ,DT1C      )
!
                   CASE (46)     !    Hoffman criterion
!
                     CALL FAIL_HOFFMAN_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,SIGNYZ    ,SIGNZX    ,&
                     &OFF       ,FOFF      ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &DFMAX     ,LF_DAMMX  ,TDEL      ,DT1C      )
!
                   CASE (47)     !    Maximum strain failure model
!
                     CALL FAIL_MAXSTRAIN_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &TT        ,NGL       ,IPG       ,ILAYER    ,IT        ,&
                     &EPSXX     ,EPSYY     ,EPSXY     ,EPSYZ     ,EPSZX     ,&
                     &OFF       ,FOFF      ,DMG_FLAG  ,DMG_LOC_SCALE ,&
                     &DFMAX     ,LF_DAMMX  ,TDEL      ,DT1C      )
!
                   CASE (48)     !    Orthotropic energy failure model
!
                     CALL FAIL_ORTHENERG_C(&
                     &NEL       ,NUPAR     ,NVARF     ,UPARAMF   ,UVARF     ,&
                     &NGL       ,TT        ,IPG       ,ILAYER    ,IT        ,&
                     &DEPSXX    ,DEPSYY    ,DEPSXY    ,DMG_FLAG  ,DMG_ORTH_SCALE,&
                     &ALDT      ,FOFF      ,DFMAX     ,TDEL      ,&
                     &SIGNXX    ,SIGNYY    ,SIGNXY    ,IGTYP     ,PLY_ID    )
!-------------
                  END SELECT
!-------------
                  IF (ORTH_DAMAGE == 0) THEN
                     DO I=1,NEL
                        IF (FOFF(I) == 0)  THEN
                           OFFL(I) = ZERO
!                    SIGOFF(I) = OFFL(I)
                           SIGOFF(I) = ZERO
                        ENDIF
                     ENDDO
                  ELSE
                     DO I=1,NEL
                        IF (OFF(I) == ZERO)  THEN
                           SIGOFF(I) = ZERO
                        ENDIF
                     ENDDO
                  ENDIF
!-------------
               ENDDO     !  NFAIL
               IF ((ITASK==0).AND.(IMON_MAT==1)) CALL STOPTIME(121,1)
            ENDIF  ! IF (IFAILURE == 1)
!-----------------------------------
!         END of FAILURE MODELS
!-----------------------------------
#include "vectorize.inc"
            DO I=JFT,JLT
               ! IJ(K) = NEL*(K-1)
               LBUF%SIG(NEL*(1-1)+I) = SIGNXX(I) * SIGOFF(I)
               LBUF%SIG(NEL*(2-1)+I) = SIGNYY(I) * SIGOFF(I)
               LBUF%SIG(NEL*(3-1)+I) = SIGNXY(I) * SIGOFF(I)
               LBUF%SIG(NEL*(4-1)+I) = SIGNYZ(I) * SIGOFF(I)
               LBUF%SIG(NEL*(5-1)+I) = SIGNZX(I) * SIGOFF(I)
            ENDDO
!
!------------------------------------------------
            IF (IGTYP == 1) THEN
               SELECT CASE (DMG_FLAG)
                CASE (0)
                  IF (ILAW==58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXX(1:NEL)+SIGVXX(1:NEL))
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYY(1:NEL)+SIGVYY(1:NEL))
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXY(1:NEL)+SIGVXY(1:NEL))
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYZ(1:NEL)+SIGVYZ(1:NEL))
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*(SIGNZX(1:NEL)+SIGVZX(1:NEL))
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL)*(SIGNXX(1:NEL)+SIGVXX(1:NEL))
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL)*(SIGNYY(1:NEL)+SIGVYY(1:NEL))
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL)*(SIGNXY(1:NEL)+SIGVXY(1:NEL))
                  ELSE
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*SIGNXX(1:NEL)
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*SIGNYY(1:NEL)
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*SIGNXY(1:NEL)
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*SIGNYZ(1:NEL)
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*SIGNZX(1:NEL)
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *SIGNXX(1:NEL)
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *SIGNYY(1:NEL)
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *SIGNXY(1:NEL)
                  ENDIF
                CASE (1)  ! softening with DMG_LOC_SCALE from failure model
                  IF (ILAW==58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXX(1:NEL)+SIGVXX(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYY(1:NEL)+SIGVYY(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXY(1:NEL)+SIGVXY(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYZ(1:NEL)+SIGVYZ(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*(SIGNZX(1:NEL)+SIGVZX(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *(SIGNXX(1:NEL)+SIGVXX(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *(SIGNYY(1:NEL)+SIGVYY(1:NEL))*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *(SIGNXY(1:NEL)+SIGVXY(1:NEL))*DMG_LOC_SCALE(1:NEL)
                  ELSE
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*SIGNXX(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*SIGNYY(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*SIGNXY(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*SIGNYZ(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*SIGNZX(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *SIGNXX(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *SIGNYY(1:NEL)*DMG_LOC_SCALE(1:NEL)
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *SIGNXY(1:NEL)*DMG_LOC_SCALE(1:NEL)
                  ENDIF
                CASE (2)  ! internal damage model within law15
                  FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*SIGDMG(1:NEL,1)
                  FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*SIGDMG(1:NEL,2)
                  FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*SIGDMG(1:NEL,3)
                  FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*SIGDMG(1:NEL,4)
                  FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*SIGDMG(1:NEL,5)
                  MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *SIGDMG(1:NEL,1)
                  MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *SIGDMG(1:NEL,2)
                  MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *SIGDMG(1:NEL,3)
                CASE (3)  ! orthotropic softening with DMG_ORTH_SCALE from failure model
                  IF (ILAW==58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXX(1:NEL)+SIGVXX(1:NEL))*DMG_ORTH_SCALE(1:NEL,1)
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYY(1:NEL)+SIGVYY(1:NEL))*DMG_ORTH_SCALE(1:NEL,2)
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*(SIGNXY(1:NEL)+SIGVXY(1:NEL))*DMG_ORTH_SCALE(1:NEL,3)
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*(SIGNYZ(1:NEL)+SIGVYZ(1:NEL))*DMG_ORTH_SCALE(1:NEL,4)
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*(SIGNZX(1:NEL)+SIGVZX(1:NEL))*DMG_ORTH_SCALE(1:NEL,5)
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *(SIGNXX(1:NEL)+SIGVXX(1:NEL))*DMG_ORTH_SCALE(1:NEL,1)
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *(SIGNYY(1:NEL)+SIGVYY(1:NEL))*DMG_ORTH_SCALE(1:NEL,2)
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *(SIGNXY(1:NEL)+SIGVXY(1:NEL))*DMG_ORTH_SCALE(1:NEL,3)
                  ELSE
                     FOR(1:NEL,1) = FOR(1:NEL,1) + THKLY(JPOS:JPOS+NEL-1)*SIGNXX(1:NEL)*DMG_ORTH_SCALE(1:NEL,1)
                     FOR(1:NEL,2) = FOR(1:NEL,2) + THKLY(JPOS:JPOS+NEL-1)*SIGNYY(1:NEL)*DMG_ORTH_SCALE(1:NEL,2)
                     FOR(1:NEL,3) = FOR(1:NEL,3) + THKLY(JPOS:JPOS+NEL-1)*SIGNXY(1:NEL)*DMG_ORTH_SCALE(1:NEL,3)
                     FOR(1:NEL,4) = FOR(1:NEL,4) + THKLY(JPOS:JPOS+NEL-1)*SIGNYZ(1:NEL)*DMG_ORTH_SCALE(1:NEL,4)
                     FOR(1:NEL,5) = FOR(1:NEL,5) + THKLY(JPOS:JPOS+NEL-1)*SIGNZX(1:NEL)*DMG_ORTH_SCALE(1:NEL,5)
                     MOM(1:NEL,1) = MOM(1:NEL,1) + WMC(1:NEL) *SIGNXX(1:NEL)*DMG_ORTH_SCALE(1:NEL,1)
                     MOM(1:NEL,2) = MOM(1:NEL,2) + WMC(1:NEL) *SIGNYY(1:NEL)*DMG_ORTH_SCALE(1:NEL,2)
                     MOM(1:NEL,3) = MOM(1:NEL,3) + WMC(1:NEL) *SIGNXY(1:NEL)*DMG_ORTH_SCALE(1:NEL,3)
                  ENDIF
               END SELECT
!
            ELSE   ! IGTYP /= 1)
!
               SELECT CASE (DMG_FLAG)
                CASE (0)
                  IF (ILAW == 58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     TENS(JFT:JLT,1) = SIGNXX(JFT:JLT)+SIGVXX(JFT:JLT)
                     TENS(JFT:JLT,2) = SIGNYY(JFT:JLT)+SIGVYY(JFT:JLT)
                     TENS(JFT:JLT,3) = SIGNXY(JFT:JLT)+SIGVXY(JFT:JLT)
                     TENS(JFT:JLT,4) = SIGNYZ(JFT:JLT)+SIGVYZ(JFT:JLT)
                     TENS(JFT:JLT,5) = SIGNZX(JFT:JLT)+SIGVZX(JFT:JLT)
                  ELSE
                     TENS(JFT:JLT,1) = SIGNXX(JFT:JLT)
                     TENS(JFT:JLT,2) = SIGNYY(JFT:JLT)
                     TENS(JFT:JLT,3) = SIGNXY(JFT:JLT)
                     TENS(JFT:JLT,4) = SIGNYZ(JFT:JLT)
                     TENS(JFT:JLT,5) = SIGNZX(JFT:JLT)
                  ENDIF
                CASE (1)
                  IF (ILAW == 58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     TENS(JFT:JLT,1) = (SIGNXX(JFT:JLT)+SIGVXX(JFT:JLT))*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,2) = (SIGNYY(JFT:JLT)+SIGVYY(JFT:JLT))*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,3) = (SIGNXY(JFT:JLT)+SIGVXY(JFT:JLT))*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,4) = (SIGNYZ(JFT:JLT)+SIGVYZ(JFT:JLT))*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,5) = (SIGNZX(JFT:JLT)+SIGVZX(JFT:JLT))*DMG_LOC_SCALE(JFT:JLT)
                  ELSE
                     TENS(JFT:JLT,1) = SIGNXX(JFT:JLT)*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,2) = SIGNYY(JFT:JLT)*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,3) = SIGNXY(JFT:JLT)*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,4) = SIGNYZ(JFT:JLT)*DMG_LOC_SCALE(JFT:JLT)
                     TENS(JFT:JLT,5) = SIGNZX(JFT:JLT)*DMG_LOC_SCALE(JFT:JLT)
                  ENDIF
                CASE (2)  ! internal damage model within law15
                  TENS(JFT:JLT,1) = SIGDMG(JFT:JLT,1)
                  TENS(JFT:JLT,2) = SIGDMG(JFT:JLT,2)
                  TENS(JFT:JLT,3) = SIGDMG(JFT:JLT,3)
                  TENS(JFT:JLT,4) = SIGDMG(JFT:JLT,4)
                  TENS(JFT:JLT,5) = SIGDMG(JFT:JLT,5)
                CASE (3)  ! orthotropic softening with DMG_ORTH_SCALE from failure model
                  IF (ILAW == 58 .or. ILAW == 158 .OR. IPRONY == 1) THEN
                     TENS(JFT:JLT,1) = (SIGNXX(JFT:JLT)+SIGVXX(JFT:JLT))*DMG_ORTH_SCALE(JFT:JLT,1)
                     TENS(JFT:JLT,2) = (SIGNYY(JFT:JLT)+SIGVYY(JFT:JLT))*DMG_ORTH_SCALE(JFT:JLT,2)
                     TENS(JFT:JLT,3) = (SIGNXY(JFT:JLT)+SIGVXY(JFT:JLT))*DMG_ORTH_SCALE(JFT:JLT,3)
                     TENS(JFT:JLT,4) = (SIGNYZ(JFT:JLT)+SIGVYZ(JFT:JLT))*DMG_ORTH_SCALE(JFT:JLT,4)
                     TENS(JFT:JLT,5) = (SIGNZX(JFT:JLT)+SIGVZX(JFT:JLT))*DMG_ORTH_SCALE(JFT:JLT,5)
                  ELSE
                     TENS(JFT:JLT,1) = SIGNXX(JFT:JLT)*DMG_ORTH_SCALE(JFT:JLT,1)
                     TENS(JFT:JLT,2) = SIGNYY(JFT:JLT)*DMG_ORTH_SCALE(JFT:JLT,2)
                     TENS(JFT:JLT,3) = SIGNXY(JFT:JLT)*DMG_ORTH_SCALE(JFT:JLT,3)
                     TENS(JFT:JLT,4) = SIGNYZ(JFT:JLT)*DMG_ORTH_SCALE(JFT:JLT,4)
                     TENS(JFT:JLT,5) = SIGNZX(JFT:JLT)*DMG_ORTH_SCALE(JFT:JLT,5)
                  ENDIF
               END SELECT
!
               IF (ILAW == 58 .or. ILAW == 158) THEN
                  DO I=JFT,JLT
                     II = JDIR + I-1
                     R1 = DIR_A(II)
                     S1 = DIR_A(II+NEL)
                     R2 = DIR_B(II)
                     S2 = DIR_B(II+NEL)
                     RS1= R1*S1
                     RS2= R2*S2
                     R12A = R1*R1
                     R22A = R2*R2
                     S12B = S1*S1
                     S22B = S2*S2
                     RS3 = S1*S2-R1*R2
                     R3R3= ONE+S1*R2+R1*S2
                     R3R3= HALF*R3R3
                     S3S3= ONE-S1*R2-R1*S2
                     S3S3= HALF*S3S3
                     T1 = TENS(I,1)
                     T2 = TENS(I,2)
                     T3 = TENS(I,3)
                     TENS(I,1) = R12A*T1 + R22A*T2 - RS3*T3
                     TENS(I,2) = S12B*T1 + S22B*T2 + RS3*T3
                     TENS(I,3) = RS1*T1  + RS2*T2 + (R3R3 - S3S3)*T3
                     TENS(I,4) = SIGNYZ(I)
                     TENS(I,5) = SIGNZX(I)
                  ENDDO
!
               ELSE     ! IGTYP = 9,10,11,51,52
                  IF (ILAW /= 1 .and. ILAW /= 2 .and. ILAW /= 27 .and. ILAW /= 32)&
                  &CALL UROTOV(JFT,JLT,TENS,DIR_A(JDIR),NEL)
               ENDIF
!----------------------
!           FORCES AND MOMENTS WHEN IGTYP /= 1
!----------------------
#include "vectorize.inc"
               DO I=JFT,JLT
                  FOR(I,1) = FOR(I,1) + THKLY(JPOS-1+I)*TENS(I,1)
                  FOR(I,2) = FOR(I,2) + THKLY(JPOS-1+I)*TENS(I,2)
                  FOR(I,3) = FOR(I,3) + THKLY(JPOS-1+I)*TENS(I,3)
                  FOR(I,4) = FOR(I,4) + THKLY(JPOS-1+I)*TENS(I,4)
                  FOR(I,5) = FOR(I,5) + THKLY(JPOS-1+I)*TENS(I,5)
                  MOM(I,1) = MOM(I,1) + WMC(I) *TENS(I,1)
                  MOM(I,2) = MOM(I,2) + WMC(I) *TENS(I,2)
                  MOM(I,3) = MOM(I,3) + WMC(I) *TENS(I,3)
               ENDDO
!
            ENDIF   ! IGTYP
!-----------------------------------------------
!         FACTEURS POUR COQUES B.L. (Zeng&Combescure)
!-----------------------------------------------
            IF (ILAW /= 2  .AND. ILAW /= 15 .AND. ILAW /= 22 .AND.&
            &ILAW /= 25 .AND. ILAW /= 27 .AND. ILAW /= 32) THEN  ! for law25 it is done inside sigeps25c.F
               IF(FLAG_ZCFAC) THEN
                  ZCFAC(JFT:JLT,1) = ZCFAC(JFT:JLT,1) + ETSE(JFT:JLT) * THKLY(JPOS:JPOS+JLT-1)
                  ZCFAC(JFT:JLT,2) = MIN(ETSE(JFT:JLT),ZCFAC(JFT:JLT,2))
               ENDIF
               YLD(JFT:JLT) = YLD(JFT:JLT) + SIGY(JFT:JLT)*THKLY(JPOS:JPOS+JLT-1)
               IF(FLAG_ETIMP) ETIMP(JFT:JLT) = ETIMP(JFT:JLT) + ET_IMP(JFT:JLT)*THKLY(JPOS:JPOS+JLT-1)
            ELSEIF ( ILAW == 2 ) THEN
!------------------------------------
               SELECT CASE (IGTYP)
!------------------------------------
                CASE (1,9)
                  ZCFAC(JFT:JLT,1) = ZCFAC(JFT:JLT,1) + ETSE(JFT:JLT) / NPT
                  ZCFAC(JFT:JLT,2) = MIN(ETSE(JFT:JLT),ZCFAC(JFT:JLT,2))
                  YLD(JFT:JLT)     = YLD(JFT:JLT) + SIGY(JFT:JLT) / NPT
                CASE DEFAULT
                  ZCFAC(JFT:JLT,1) = ZCFAC(JFT:JLT,1) + ETSE(JFT:JLT) * THKLY(JPOS:JPOS+JLT-1)
                  ZCFAC(JFT:JLT,2) = MIN(ETSE(JFT:JLT),ZCFAC(JFT:JLT,2))
                  YLD(JFT:JLT)     = YLD(JFT:JLT) + SIGY(JFT:JLT) * THKLY(JPOS:JPOS+JLT-1)
               END SELECT
            ENDIF
!-----------------------------------------------
            IF (IMPL_S > 0) THEN
               CALL PUTSIGNORC3(JFT ,JLT ,IUN,NG,IPT,G_IMP ,SIGKSI)
            END IF
!-----------------------------------------------
            IF (IXEL == 0 .and. PROGRESSIVE_CRACK == 0) THEN   ! original element
               IF (ILAW == 27) THEN
                  DIR_ORTH => LBUF%DMG
                  IROT = ELBUF_STR%BUFLY(ILAYER)%L_DMG
               ELSE
                  DIR_ORTH => BUFLY%DIRA
                  IROT = ELBUF_STR%BUFLY(ILAYER)%LY_DIRA
               ENDIF
               IF (IXFEM == 1) THEN        ! multilayer
                  CALL XFEM_CRK_DIR(&
                  &JLT        ,ILAYER ,IXFEM    ,ELCRKINI,&
                  &DIR_ORTH,TENSX  ,DIR1_CRK ,DIR2_CRK ,IROT    )
               ELSEIF (IXFEM == 2) THEN    ! monolayer
                  IPTX = 1
                  CALL XFEM_CRK_DIR(&
                  &JLT    ,IPTX    ,IXFEM   ,ELCRKINI,&
                  &DIR_ORTH  ,TENSX  ,DIR1_CRK,DIR2_CRK,IROT    )
               ENDIF
            ENDIF
!------------------------------------------------------------
!     Variable to regularize with Non-local
!------------------------------------------------------------
            IF (BUFLY%L_PLA > 0) THEN
               ! Non-local material
               IF (INLOC > 0) THEN
                  DO I=JFT,JLT
                     IF (OFF(I) == ONE) THEN
                        VARNL(I,IT) = LBUF%PLA(I)
                     ELSE
                        VARNL(I,IT) = ZERO
                     ENDIF
                  ENDDO
               ENDIF
            ENDIF
!-------------------------------------
         ENDDO  !  IT=1,NPTT
         IPT_ALL = IPT_ALL + NPTT
      ENDDO  !  DO ILAY =1,NLAY
!--------------------------------------------------
!     END OF LOOP OVER INTEGRATION POINTS (LAYERS)
!--------------------------------------------------
!     TEST OF ELEMENT FAILURE
!--------------------------------------------------
      ! Flag for printing element deletion message
      PRINT_FAIL(1:NEL) = .TRUE.
      ! Check element deletion from failure criterion
      IF (IFAILURE == 1 .and. IXFEM == 0) THEN
         IF (ORTH_DAMAGE == 1) THEN   ! /fail/alter + front_wave only
            TFAIL => GBUF%DMG(1+NEL:NEL*2)  ! only for /FAIL/ALTER
            CALL FAIL_SETOFF_WIND_FRWAVE(&
            &ELBUF_STR,MAT_ELEM ,GEO      ,PID(1)   ,&
            &NGL      ,NEL      ,IR       ,IS       ,&
            &NLAY     ,NPTTOT   ,THK_LY   ,THKLY    ,&
            &OFF      ,NPG      ,STACK    ,ISUBSTACK,&
            &IGTYP    ,FAILWAVE ,FWAVE_EL ,DMG_FLAG ,&
            &TT       ,TRELAX   ,TFAIL    ,DMG_GLOB_SCALE)
         ELSEIF (NPG == 1) THEN
            CALL FAIL_SETOFF_C(ELBUF_STR,MAT_ELEM ,GEO      ,PID(1)   ,&
            &NGL      ,NEL      ,NLAY     ,NPTTOT   ,&
            &THK_LY   ,THKLY    ,OFF      ,STACK    ,&
            &ISUBSTACK,IGTYP    ,FAILWAVE ,FWAVE_EL ,&
            &NLAY_MAX ,LAYNPT_MAX,NUMGEO  ,NUMSTACK ,&
            &IGEO     ,PRINT_FAIL)
         ELSE
            CALL FAIL_SETOFF_NPG_C(&
            &ELBUF_STR,MAT_ELEM ,GEO      ,PID(1)   ,&
            &NGL      ,NEL      ,IR       ,IS       ,&
            &NLAY     ,NPTTOT   ,THK_LY   ,THKLY    ,&
            &OFF      ,NPG      ,STACK    ,ISUBSTACK,&
            &IGTYP    ,FAILWAVE ,FWAVE_EL ,NLAY_MAX ,&
            &LAYNPT_MAX,NUMGEO  ,IPG      ,NUMSTACK ,&
            &IGEO     ,PRINT_FAIL)
         ENDIF
      ENDIF
!---
      ! Checking element deletion and printing element deletion messages (if needed)
      NINDX = 0
      IF (IXFEM == 0) THEN
         DO I=JFT,JLT
            IF (OFF(I) == FOUR_OVER_5 .and. IOFF_DUCT(I) == 0 .or.&   ! rupture /fail
            &OFF(I) > ZERO   .and. OFF_OLD(I) < EM01 .or.&   ! rupture progressive law 2,22,25
            &OFF(I) > ZERO   .and. OFF(I) < ONE .and. DMG_FLAG == 1 .and.&
            &DMG_GLOB_SCALE(I) < EM02) THEN
               OFF(I) = ZERO
               ! Printing message not always mandatory
               IF (PRINT_FAIL(I)) THEN
                  NINDX  = NINDX + 1
                  INDX(NINDX) = I
               ENDIF
            ENDIF
         ENDDO
      ENDIF
!--------------------------------------------------------
!     SHOOTING NODES ALGORITHM ACTIVATION
!--------------------------------------------------------
      DO I = 1,NEL
         IF ((OFF_OLD(I) > ZERO) .AND. (OFF(I) == ZERO)) THEN
            IDEL7NOK = 1
         ENDIF
      ENDDO
!------------------------------------------------------------------
!     MEMBRANE VISCOSITY
!---------------------------
      IF (IGTYP == 11 .AND. IGMAT > 0) THEN
         IPGMAT = 700
         DO I=JFT,JLT
            RHO(I) = GEO(IPGMAT+1,PID(1))
            SSP(I) = GEO(IPGMAT+9,PID(1))
         ENDDO
      ELSEIF (IGTYP == 52 .OR.&
      &((IGTYP == 17 .OR. IGTYP == 51) .AND. IGMAT > 0)) THEN
         DO I=JFT,JLT
            SSP(I) = STACK%PM(9,ISUBSTACK)
            RHO(I) = STACK%PM(1,ISUBSTACK)
         ENDDO
      ENDIF
!---
! Special treatment for law 19
!---
!  --- start treatment law 19---
!-----------------------------------------------------------
!     DESACTIVATION SI SURFACE < SURFACE MIN
!-----------------------------------------------------------
      IF (MTN == 19) THEN
         MX = MAT(JFT)
         DO I=JFT,JLT
            AREAMIN(I)  = PM(53,MX)
            DAREAMIN(I) = PM(54,MX)
         ENDDO
         IF (ISMSTR == 3) THEN
            DO I=JFT,JLT
               IF (AREAMIN(I) > ZERO) THEN
                  AA = (ONE+GSTR(I,1)+GSTR(I,2) - AREAMIN(I)) * DAREAMIN(I)
                  AA = MIN(MAX(AA,ZERO),ONE)
                  FOR(I,1)=FOR(I,1)*AA
                  FOR(I,2)=FOR(I,2)*AA
                  FOR(I,3)=FOR(I,3)*AA
               ENDIF
            ENDDO
         ELSE
            DO I=JFT,JLT
               IF(AREAMIN(I) > ZERO)THEN
                  VV = GSTR(I,1)+GSTR(I,2)
                  VV = ONE + (ONE + (HALF + ONE_OVER_6*VV)*VV)*VV
                  AA = (VV - AREAMIN(I)) * DAREAMIN(I)
                  AA = MIN(MAX(AA,ZERO),ONE)
                  FOR(I,1)=FOR(I,1)*AA
                  FOR(I,2)=FOR(I,2)*AA
                  FOR(I,3)=FOR(I,3)*AA
               ENDIF
            ENDDO
         ENDIF ! IF (ISMSTR == 3)
      ENDIF  ! IF (MTN == 19)
!  --- end treatment law 19---
!-----------------------------------------------------------------------
      THK(JFT:JLT) = MAX(THKN(JFT:JLT),EM30)
!
      FACT = ONEP414*DM
      VISC(JFT:JLT) = FACT*SSP(JFT:JLT)*SQRT(AREA(JFT:JLT))*DT_INV(JFT:JLT)*RHO(JFT:JLT)
!
      FOR(JFT:JLT,1)=FOR(JFT:JLT,1)+VISC(JFT:JLT)*(EXX(JFT:JLT)+HALF*EYY(JFT:JLT))
      FOR(JFT:JLT,2)=FOR(JFT:JLT,2)+VISC(JFT:JLT)*(EYY(JFT:JLT)+HALF*EXX(JFT:JLT))
      FOR(JFT:JLT,3)=FOR(JFT:JLT,3)+VISC(JFT:JLT)* EXY(JFT:JLT) *THIRD
!
      FOR(JFT:JLT,1)=FOR(JFT:JLT,1)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      FOR(JFT:JLT,2)=FOR(JFT:JLT,2)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      FOR(JFT:JLT,3)=FOR(JFT:JLT,3)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      FOR(JFT:JLT,4)=FOR(JFT:JLT,4)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      FOR(JFT:JLT,5)=FOR(JFT:JLT,5)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      MOM(JFT:JLT,1)=MOM(JFT:JLT,1)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      MOM(JFT:JLT,2)=MOM(JFT:JLT,2)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
      MOM(JFT:JLT,3)=MOM(JFT:JLT,3)*OFF(JFT:JLT)*DMG_GLOB_SCALE(JFT:JLT)
!
!!  --- specific treatment for law 119 - scale factor applied on internal forces---
      IF (ILAW == 119) THEN
         FOR(JFT:JLT,1)=FOR(JFT:JLT,1)*GBUF%INTVAR(JFT:JLT)
         FOR(JFT:JLT,2)=FOR(JFT:JLT,2)*GBUF%INTVAR(JFT:JLT)
         FOR(JFT:JLT,3)=FOR(JFT:JLT,3)*GBUF%INTVAR(JFT:JLT)
         FOR(JFT:JLT,4)=FOR(JFT:JLT,4)*GBUF%INTVAR(JFT:JLT)
         FOR(JFT:JLT,5)=FOR(JFT:JLT,5)*GBUF%INTVAR(JFT:JLT)
         MOM(JFT:JLT,1)=MOM(JFT:JLT,1)*GBUF%INTVAR(JFT:JLT)
         MOM(JFT:JLT,2)=MOM(JFT:JLT,2)*GBUF%INTVAR(JFT:JLT)
         MOM(JFT:JLT,3)=MOM(JFT:JLT,3)*GBUF%INTVAR(JFT:JLT)
      ENDIF
!
      DEGMB(JFT:JLT) = DEGMB(JFT:JLT)+ FOR(JFT:JLT,1)*EXX(JFT:JLT)+FOR(JFT:JLT,2)*EYY(JFT:JLT)&
      &+ FOR(JFT:JLT,3)*EXY(JFT:JLT)+FOR(JFT:JLT,4)*EYZ(JFT:JLT)+ FOR(JFT:JLT,5)*EXZ(JFT:JLT)
      DEGFX(JFT:JLT) = DEGFX(JFT:JLT)+ MOM(JFT:JLT,1)*KXX(JFT:JLT)+MOM(JFT:JLT,2)*KYY(JFT:JLT)+MOM(JFT:JLT,3)*KXY(JFT:JLT)
!-----------------------------------------------------------------------
!---
      IF (MTN == 25) THEN
!----------------------------
!  SHEAR DELAMINATION
!----------------------------
! is an obsolete option (still present for backward compatibility)
         IF (IGMAT == 0)&
         &CALL M25DELAM(JFT,JLT,PM,GSTR,GBUF%DAMDL,MAT,NGL,NEL)
!
         IF (ISHPLYXFEM > 0) THEN
            MX = MAT(JFT)
            IPT_ALL = 0
            DO ILAY=1,NLAY
               ILAYER = ILAY
!  cas xfem multilayer
               IF (IXFEM == 1 .AND. IXLAY > 0) ILAYER = IXLAY
               NPTT = ELBUF_STR%BUFLY(ILAYER)%NPTT
               DO IT=1,NPTT
                  IPT = IPT_ALL + IT        ! count all NPTT through all layers
                  DO I=JFT,JLT
!
                     PLY_F(I,1,IPT) = PLY_F(I,1,IPT) + VISC(I)*(PLY_EXX(I,IPT)+HALF*PLY_EYY(I,IPT))
                     PLY_F(I,2,IPT) = PLY_F(I,2,IPT) + VISC(I)*(PLY_EYY(I,IPT)+HALF*PLY_EXX(I,IPT))
                     PLY_F(I,3,IPT) = PLY_F(I,3,IPT) + VISC(I)* PLY_EXY(I,IPT)*THIRD
                  ENDDO
!
                  DO I=JFT,JLT
                     PLY_F(I,1,IPT) = PLY_F(I,1,IPT)*OFF(I)
                     PLY_F(I,2,IPT) = PLY_F(I,2,IPT)*OFF(I)
                     PLY_F(I,3,IPT) = PLY_F(I,3,IPT)*OFF(I)
                     PLY_F(I,4,IPT) = PLY_F(I,4,IPT)*OFF(I)
                     PLY_F(I,5,IPT) = PLY_F(I,5,IPT)*OFF(I)
                  ENDDO
               ENDDO ! DO IT=1,NPTT
               IPT_ALL = IPT_ALL + NPTT
            ENDDO ! DO ILAY=1,NLAY
         ENDIF ! IF (ISHPLYXFEM /= 0)
      ENDIF ! IF (MTN == 25)
!---
      DO I=JFT,JLT
         VOL2 = HALF*VOL0(I)
         IF (MTN == 22) VOL2 = VOL2*OFF(I)
         EINT(I,1) = EINT(I,1) + DEGMB(I)*VOL2
         EINT(I,2) = EINT(I,2) + DEGFX(I)*THK0(I)*VOL2
      ENDDO
!
      IF (JTHE > 0 .AND. MTN /= 2) THEN
         DIE(JFT:JLT) = DIE(JFT:JLT) +&
         &COEF(JFT:JLT)*( DEGMB(JFT:JLT)*HALF*VOL0(JFT:JLT) + DEGFX(JFT:JLT)*THK0(JFT:JLT)*HALF*VOL0(JFT:JLT) )
      ENDIF
!---------------------------------------------------
!      check element failure with xfem
      IF (IXFEM > 0) THEN
         DO I=JFT,JLT
            IF (OFF(I) == FOUR_OVER_5) THEN
               OFF(I) = ZERO
               NINDX  = NINDX + 1
               INDX(NINDX) = I
            ENDIF
         ENDDO
      ENDIF

!---  Shell failure print out
!
      IOFC = NINDX  !  INDX used before in IELOF - check if still useful
      IF (NINDX > 0 .and. IXEL == 0) THEN
         IF (IMCONV == 1) THEN
            DO II = 1,NINDX
               I = INDX(II)
!$OMP CRITICAL
               WRITE(IOUT, 1000) NGL(I)
               WRITE(ISTDO,1100) NGL(I),TT
!$OMP END CRITICAL
            ENDDO
         ENDIF
      ENDIF
!---------------------------------------------------
1000  FORMAT(1X,'-- RUPTURE OF SHELL ELEMENT NUMBER ',I10)
1100  FORMAT(1X,'-- RUPTURE OF SHELL ELEMENT :',I10,' AT TIME :',G11.4)
!---------------------------------------------------
      RETURN
   END
!-----
END MODULE MULAWC_MOD
