################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
build-1974262273:
	@$(MAKE) -Onone -f subdir_rules.mk build-1974262273-inproc

build-1974262273-inproc: ../empty_min.cfg
	@echo 'Building file: $<'
	@echo 'Invoking: XDCtools'
	"D:/ti/xdctools_3_30_01_25_core/xs" --xdcpath="D:/ti/tirtos_tivac_2_00_01_23/packages;D:/ti/tirtos_tivac_2_00_01_23/products/bios_6_40_01_15/packages;D:/ti/tirtos_tivac_2_00_01_23/products/ndk_2_23_01_01/packages;D:/ti/tirtos_tivac_2_00_01_23/products/uia_2_00_00_28/packages;D:/ti/ccsv7/ccs_base;" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M4F -p ti.platforms.tiva:TM4C123GH6PM -r release -c "D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS" "$<"
	@echo 'Finished building: $<'
	@echo ' '

configPkg/linker.cmd: build-1974262273 ../empty_min.cfg
configPkg/compiler.opt: build-1974262273
configPkg/: build-1974262273

main.obj: ../main.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 -me -O4 --opt_for_speed=3 --include_path="D:/TI_RTOS/Workspace/DSP_FIR_CB" --include_path="D:/ti/tirtos_tivac_2_00_01_23/products/TivaWare_C_Series-2.1.0.12573c" --include_path="D:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.1.LTS/include" --define=ccs="ccs" --define=PART_TM4C123GH6PM --define=ccs --define=TIVAWARE -g --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="main.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


