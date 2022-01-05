# Automatically generate lists of sources using wildcards.
# TO DELETE: Where bochs is: C:\Program Files\Bochs-2.7

C_SOURCES  = $(wildcard kernel/*.cpp drivers/*.cpp)
HEADERS    = $(wildcard kernel/*.h drivers/*.h )
BOCHS_ROOT = 'C:/Program Files/Bochs-2.7'
IMAGE_SIZE = 10485760
# TODO : Make sources dep on all header files.
# Convert the *.c filenames to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.cpp=.o}
# Default build target
all : os-image

# Run bochs to simulate booting of our code .
run : all
	$(BOCHS_ROOT)/bochs.exe
# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
os-image : boot/boot_sect.bin kernel.bin
	cat $^ > os-image
	cp os-image os-image.img
	truncate -s $(IMAGE_SIZE) os-image.img

# MAKE comment: $^ is substituted with all of the target ’s dependancy files. Dependencies being the shit on the right of the :
# MAKE comment: $< is the first dependency
# MAKE comment: $@ is the target file
# This builds the binary of our kernel from two object files :
# - the kernel_entry , which jumps to main () in our kernel
# - the compiled C kernel
kernel.bin : kernel/kernel_entry.o ${OBJ}
	ld -mi386pe -o kernel.pe -Ttext 0x1000 $^
	objcopy -O binary kernel.pe $@

# Generic rule for compiling C code to an object file
# For simplicity , C files depend on all header files .
	
%.o : %.cpp ${HEADERS}
	gcc -m32 -ffreestanding -c $< -o $@
	
# Assemble the kernel_entry .
%.o : %.asm
	nasm $< -f win -i "boot/" -o $@
%.bin : %.asm
	nasm $< -f bin -i "boot/" -o $@
clean :
	rm -fr *.bin *.dis *.o *.pe *.img *.dis os-image bochsout.txt
	rm -fr kernel/*.o boot/*.bin drivers/*.o
	
disasm : os-image
	ndisasm -b 32 os-image > os-image.dis
	
tags :
	rm tags
	ctags --extra=f --file-scope=yes -R