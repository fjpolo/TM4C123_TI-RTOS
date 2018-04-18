#
_XDCBUILDCOUNT = 
ifneq (,$(findstring path,$(_USEXDCENV_)))
override XDCPATH = D:/ti/tirtos_tivac_2_00_01_23/packages;D:/ti/tirtos_tivac_2_00_01_23/products/bios_6_40_01_15/packages;D:/ti/tirtos_tivac_2_00_01_23/products/ndk_2_23_01_01/packages;D:/ti/tirtos_tivac_2_00_01_23/products/uia_2_00_00_28/packages;D:/ti/ccsv7/ccs_base;D:/TI_RTOS/Workspace/DSP_FIR_CB/.config
override XDCROOT = D:/ti/xdctools_3_30_01_25_core
override XDCBUILDCFG = ./config.bld
endif
ifneq (,$(findstring args,$(_USEXDCENV_)))
override XDCARGS = 
override XDCTARGETS = 
endif
#
ifeq (0,1)
PKGPATH = D:/ti/tirtos_tivac_2_00_01_23/packages;D:/ti/tirtos_tivac_2_00_01_23/products/bios_6_40_01_15/packages;D:/ti/tirtos_tivac_2_00_01_23/products/ndk_2_23_01_01/packages;D:/ti/tirtos_tivac_2_00_01_23/products/uia_2_00_00_28/packages;D:/ti/ccsv7/ccs_base;D:/TI_RTOS/Workspace/DSP_FIR_CB/.config;D:/ti/xdctools_3_30_01_25_core/packages;..
HOSTOS = Windows
endif
