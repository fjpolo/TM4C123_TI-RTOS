/*
 * Do not modify this file; it is automatically generated from the template
 * linkcmd.xdt in the ti.platforms.tiva package and will be overwritten.
 */

/*
 * put '"'s around paths because, without this, the linker
 * considers '-' as minus operator, not a file name character.
 */


-l"D:\TI_RTOS\Workspace\DSP_FIR_CB\Debug__opt_for_speed__0\configPkg\package\cfg\empty_min_pem4f.oem4f"
-l"D:\ti\tirtos_tivac_2_00_01_23\packages\ti\drivers\lib\nonInstrumented\gpio_tivaware.aem4f"
-l"D:\TI_RTOS\Workspace\DSP_FIR_CB\src\sysbios\sysbios.aem4f"
-l"D:\ti\tirtos_tivac_2_00_01_23\products\bios_6_40_01_15\packages\ti\catalog\arm\cortexm4\tiva\ce\lib\Boot.aem4f"
-l"D:\ti\tirtos_tivac_2_00_01_23\products\bios_6_40_01_15\packages\ti\targets\arm\rtsarm\lib\ti.targets.arm.rtsarm.aem4f"
-l"D:\ti\tirtos_tivac_2_00_01_23\products\bios_6_40_01_15\packages\ti\targets\arm\rtsarm\lib\boot.aem4f"
-l"D:\ti\tirtos_tivac_2_00_01_23\products\bios_6_40_01_15\packages\ti\targets\arm\rtsarm\lib\auto_init.aem4f"

--retain="*(xdc.meta)"

/* C6x Elf symbols */
--symbol_map __TI_STACK_SIZE=__STACK_SIZE
--symbol_map __TI_STACK_BASE=__stack
--symbol_map _stack=__stack


--args 0x0
-heap  0x0
-stack 0x200

/*
 * Linker command file contributions from all loaded packages:
 */

/* Content from xdc.services.global (null): */

/* Content from xdc (null): */

/* Content from xdc.corevers (null): */

/* Content from xdc.shelf (null): */

/* Content from xdc.services.spec (null): */

/* Content from xdc.services.intern.xsr (null): */

/* Content from xdc.services.intern.gen (null): */

/* Content from xdc.services.intern.cmd (null): */

/* Content from xdc.bld (null): */

/* Content from ti.targets (null): */

/* Content from ti.targets.arm.elf (null): */

/* Content from xdc.rov (null): */

/* Content from xdc.runtime (null): */

/* Content from xdc.services.getset (null): */

/* Content from ti.targets.arm.rtsarm (null): */

/* Content from ti.sysbios.interfaces (null): */

/* Content from ti.sysbios.family (null): */

/* Content from ti.sysbios.family.arm (ti/sysbios/family/arm/linkcmd.xdt): */
--retain "*(.vecs)"

/* Content from ti.sysbios.hal (null): */

/* Content from ti.tirtos (null): */

/* Content from ti.sysbios.rts (ti/sysbios/rts/linkcmd.xdt): */

/* Content from xdc.runtime.knl (null): */

/* Content from ti.catalog.arm.peripherals.timers (null): */

/* Content from ti.catalog.arm.cortexm4 (null): */

/* Content from ti.catalog (null): */

/* Content from ti.catalog.peripherals.hdvicp2 (null): */

/* Content from xdc.platform (null): */

/* Content from xdc.cfg (null): */

/* Content from ti.catalog.arm.cortexm3 (null): */

/* Content from ti.catalog.arm.cortexm4.tiva.ce (null): */

/* Content from ti.platforms.tiva (null): */

/* Content from ti.sysbios (null): */

/* Content from ti.sysbios.knl (null): */

/* Content from ti.sysbios.family.arm.m3 (ti/sysbios/family/arm/m3/linkcmd.xdt): */
-u _c_int00
--retain "*(.resetVecs)"
ti_sysbios_family_arm_m3_Hwi_nvic = 0xe000e000;

/* Content from ti.drivers (null): */

/* Content from ti.sysbios.gates (null): */

/* Content from ti.sysbios.xdcruntime (null): */

/* Content from ti.sysbios.family.arm.lm4 (null): */

/* Content from ti.sysbios.utils (null): */

/* Content from configPkg (null): */

/* Content from xdc.services.io (null): */

/* Content from ti.sysbios.family.arm.ducati (undefined): */



/*
 * symbolic aliases for static instance objects
 */
xdc_runtime_Startup__EXECFXN__C = 1;
xdc_runtime_Startup__RESETFXN__C = 1;


SECTIONS
{
    .bootVecs:  type = DSECT
    .vecs: load > 0x20000000
    .resetVecs: load > 0x0



    xdc.meta: type = COPY
    xdc.noload: type = COPY
}

