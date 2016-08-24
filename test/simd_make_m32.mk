
INC_PATH =                              \
        -I../core/

SRC_LIST =                              \
        simd_test.cpp

LIB_PATH =

LIB_LIST =                              \
        -lm

simd_test:
	mips-mti-linux-gnu-g++ -O3 -g -static -EL -mips32r5 -mmsa \
        -DRT_LINUX -DRT_M32 -DRT_128=1 -DRT_DEBUG=0 \
        -DRT_POINTER=32 -DRT_ADDRESS=32 -DRT_ELEMENT=32 -DRT_ENDIAN=0 \
        ${INC_PATH} ${SRC_LIST} ${LIB_PATH} ${LIB_LIST} -o simd_test.m32

# The up-to-date MIPS toolchain (g++ & QEMU) can be found here:
# https://community.imgtec.com/developers/mips/tools/codescape-mips-sdk/

# On Ubuntu 16.04 Live CD add "universe multiverse" to "main restricted"
# in /etc/apt/sources.list (sudo gedit /etc/apt/sources.list) then run:
# sudo apt-get update (ignoring the old database errors in the end)
#
# Prerequisites for the build:
# (cross-)compiler for MIPS+MSA is installed and in the PATH variable.
# Codescape.GNU.Tools.Package.2015.06-05.for.MIPS.MTI.Linux.CentOS-5.x86_64
# is unpacked and folder mips-mti-linux-gnu/2015.06-05/bin is added to PATH:
# PATH=/home/ubuntu/Downloads/mips-mti-linux-gnu/2015.06-05/bin:$PATH
#
# Prerequisites for emulation:
# recent QEMU(-2.5) is installed or built from source and in the PATH variable.
# sudo apt-get install qemu
#
# Building/running SIMD test:
# make -f simd_make_m32.mk
# qemu-mipsel -cpu P5600 simd_test.m32

# For MIPS32 Release 6 target use the following options (replace):
# mips-img-linux-gnu-g++ -mips32r6 -DRT_M32=6
# For MIPS32 Release 6 emulation use QEMU 2.4.0.1.0 from imgtec.com:
# qemu-mipsel -cpu mips32r6-generic simd_test.m32

# For MIPS32 big-endian (r5 and r6) use (replace): -EB -DRT_ENDIAN=1
# qemu-mips -cpu *** simd_test.m32
# where *** is P5600 for r5 build and mips32r6-generic for r6 build.
