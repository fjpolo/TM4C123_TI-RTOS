# invoke SourceDir generated makefile for empty.pem4f
empty.pem4f: .libraries,empty.pem4f
.libraries,empty.pem4f: package/cfg/empty_pem4f.xdl
	$(MAKE) -f D:\TI_RTOS\Workspace\blink_TM4C_MBX_QUEUE/src/makefile.libs

clean::
	$(MAKE) -f D:\TI_RTOS\Workspace\blink_TM4C_MBX_QUEUE/src/makefile.libs clean

