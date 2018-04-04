# invoke SourceDir generated makefile for empty_min.pem4f
empty_min.pem4f: .libraries,empty_min.pem4f
.libraries,empty_min.pem4f: package/cfg/empty_min_pem4f.xdl
	$(MAKE) -f D:\TI_RTOS\Workspace\TM4C_TI_RTOS_new/src/makefile.libs

clean::
	$(MAKE) -f D:\TI_RTOS\Workspace\TM4C_TI_RTOS_new/src/makefile.libs clean

