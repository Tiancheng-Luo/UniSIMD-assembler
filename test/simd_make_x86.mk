
INC_PATH =                              \
        -I../core/config/

SRC_LIST =                              \
        simd_test.cpp

LIB_PATH =

LIB_LIST =                              \
        -lm


build: simd_test_x86 simd_test_x86avx simd_test_x86avx512

strip:
	strip simd_test.x86*

clean:
	rm simd_test.x86*

macOS:
	mv simd_test.x86 simd_test.o86
	mv simd_test.x86avx simd_test.o86avx
	mv simd_test.x86avx512 simd_test.o86avx512

macRD:
	rm -fr simd_test.x86*.dSYM/

macRM:
	rm simd_test.o86*


simd_test_x86:
	g++ -O3 -g -m32 \
        -DRT_LINUX -DRT_X86 -DRT_128=2 -DRT_DEBUG=0 \
        -DRT_POINTER=32 -DRT_ADDRESS=32 -DRT_ELEMENT=32 -DRT_ENDIAN=0 \
        ${INC_PATH} ${SRC_LIST} ${LIB_PATH} ${LIB_LIST} -o simd_test.x86

simd_test_x86avx:
	g++ -O3 -g -m32 \
        -DRT_LINUX -DRT_X86 -DRT_256=1 -DRT_DEBUG=0 \
        -DRT_POINTER=32 -DRT_ADDRESS=32 -DRT_ELEMENT=32 -DRT_ENDIAN=0 \
        ${INC_PATH} ${SRC_LIST} ${LIB_PATH} ${LIB_LIST} -o simd_test.x86avx

simd_test_x86avx512:
	g++ -O3 -g -m32 \
        -DRT_LINUX -DRT_X86 -DRT_512=1 -DRT_DEBUG=0 \
        -DRT_POINTER=32 -DRT_ADDRESS=32 -DRT_ELEMENT=32 -DRT_ENDIAN=0 \
        ${INC_PATH} ${SRC_LIST} ${LIB_PATH} ${LIB_LIST} -o simd_test.x86avx512


# Prerequisites for the build:
# native/multilib-compiler for x86/x86_64 is installed and in the PATH variable.
# sudo apt-get install g++ (for x86 host)
# sudo apt-get install g++-multilib (for x86_64 host)
# (installation of g++-multilib removes any g++ cross-compilers)
#
# When building on macOS install Command Line Tools first.
# http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/
#
# Prerequisites for emulation:
# http://software.intel.com/en-us/articles/intel-software-development-emulator
# Intel SDE is downloaded, unpacked and in the PATH variable.
#
# Building/running SIMD test:
# make -f simd_make_x86.mk
# ./simd_test.x86
# ./simd_test.x86avx
# ./simd_test.x86avx512
# sde -snb -- ./simd_test.x86avx -c 1
# sde -knl -- ./simd_test.x86avx512 -c 1
# Use "-c 1" option to reduce test time when emulating with Intel SDE

# Clang compilation works too (takes much longer prior to 3.8), use (replace):
# clang++ (in place of g++)
# sudo apt-get install clang (requires g++-multilib for non-native ABI)

# For interpretation of SIMD build flags check compatibility layer in rtzero.h

# For 128-bit SSE1 build use (replace): RT_128=1
# For 128-bit SSE2 build use (replace): RT_128=2
# For 128-bit SSE4 build use (replace): RT_128=4
# For 128-bit AVX1 build use (replace): RT_128=8            (AMD's AVX1-only)
# For 128-bit FMA3 build use (replace): RT_128=16           (AMD's AVX1+FMA3)
# For 128-bit AVX2 build use (replace): RT_128=32           (AMD's AVX2+FMA3)

# For 256-bit AVX1 build use (replace): RT_256=1          (Intel's AVX1-only)
# For 256-bit AVX2 build use (replace): RT_256=2          (Intel's AVX2+FMA3)
# For 512-bit AVX512F  build use (replace): RT_512=1
# For 512-bit AVX512DQ build use (replace): RT_512=2
