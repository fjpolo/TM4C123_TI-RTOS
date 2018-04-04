################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
build-1137176593:
	@$(MAKE) -Onone -f subdir_rules.mk build-1137176593-inproc

build-1137176593-inproc: ../empty.cfg
	@echo 'Building file: $<'
	@echo 'Invoking: XDCtools'
	"D:/ti/xdctools_3_30_01_25_core/xs" --xdcpath="D:/ti/ccsv7/ccs_base;D:/ti/tirtos_tivac_2_00_01_23/packages;D:/ti/tirtos_tivac_2_00_01_23/products/bios_6_40_01_15/packages;D:/ti/tirtos_tivac_2_00_01_23/products/ndk_2_23_01_01/packages;D:/ti/tirtos_tivac_2_00_01_23/products/uia_2_00_00_28/packages;D:/ti/tirtos_tivac_2_00_01_23/products/bios_6_41_00_26/packages;D:/ti/tirtos_tivac_2_00_01_23/products/ndk_2_24_01_18/packages;D:/ti/tirtos_tivac_2_00_01_23/products/uia_2_00_02_39/packages;" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M4F -p ti.platforms.tiva:TM4C123GH6PM -r release -c "D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS" "$<"
	@echo 'Finished building: $<'
	@echo ' '

configPkg/linker.cmd: build-1137176593 ../empty.cfg
configPkg/compiler.opt: build-1137176593
configPkg/: build-1137176593

main.obj: ../main.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 --abi=eabi -me --include_path="D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS/include" --include_path="D:/ti/tirtos_tivac_2_00_01_23/products/TivaWare_C_Series-2.1.0.12573c" -g --gcc --define=PART_TM4C123GH6PM --define=ccs --define=TIVAWARE --define=ccs="ccs" --diag_wrap=off --diag_warning=225 --display_error_number --gen_func_subsections=on --preproc_with_compile --preproc_dependency="main.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


