      !||====================================================================
      !||    mod_sms_work       ../engine/source/ams/sms_mass_scale_2.F
      !||--- called by ------------------------------------------------------
      !||    sms_build_mat_2    ../engine/source/ams/sms_build_mat_2.F
      !||    sms_encin_2        ../engine/source/ams/sms_encin_2.F
      !||    sms_mass_scale_2   ../engine/source/ams/sms_mass_scale_2.F
      !||====================================================================
      module MOD_SMS_WORK
      implicit none
#include      "my_real.inc"
      my_real
     .       , DIMENSION(:,:), ALLOCATABLE :: CJWORK, FREA, 
     .         ARWORK,PR,ZR,YR
      INTEGER, DIMENSION(:), ALLOCATABLE :: IRWL_WORK
C-----
      INTEGER, DIMENSION(:), ALLOCATABLE :: LIST_SMS,LIST_RMS
      my_real
     .       , DIMENSION(:), ALLOCATABLE :: MSKYI_FI_SMS
      my_real
     .       , DIMENSION(:,:), ALLOCATABLE :: VFI
      DOUBLE PRECISION
     .       , DIMENSION(:,:), ALLOCATABLE :: MW6
      END MODULE MOD_SMS_WORK
      