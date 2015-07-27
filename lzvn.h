/*
 * Created..: 31 October 2014
 * Filename.: lzvn.c
 * Author...: Pike R. Alpha
 * Purpose..: Command line tool to LZVN encode/decode a file.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <mach-o/fat.h>
#include <mach/machine.h>
#include <architecture/byte_order.h>

#include "FastCompression.h"

/*
 * Copied from: kext_tools/kext_tools-326.95.1/kernelcache.h
 */

#define PLATFORM_NAME_LEN  (64)
#define ROOT_PATH_LEN     (256)

typedef struct prelinked_kernel_header
{
	uint32_t  signature;
	uint32_t  compressType;
	uint32_t  adler32;
	uint32_t  uncompressedSize;
	uint32_t  compressedSize;
	uint32_t  prelinkVersion;					// value >= 1 means KASLR supported
	uint32_t  reserved[10];
	char      platformName[PLATFORM_NAME_LEN];	// unused
	char      rootPath[ROOT_PATH_LEN];			// unused
	char      data[0];
} PrelinkedKernelHeader;

/*
 * Copied from: kext_tools/kext_tools-326.95.1/kernelcache.c
 */

u_int32_t local_adler32(u_int8_t * buffer, int32_t length)
{
	int32_t cnt;
	u_int32_t  result, lowHalf, highHalf;
	
	lowHalf = 1;
	highHalf = 0;
	
	for (cnt = 0; cnt < length; cnt++) {
		if ((cnt % 5000) == 0) {
			lowHalf  %= 65521L;
			highHalf %= 65521L;
		}
		
		lowHalf += buffer[cnt];
		highHalf += lowHalf;
	}
	
	lowHalf  %= 65521L;
	highHalf %= 65521L;
	
	result = (highHalf << 16) | lowHalf;
	
	return result;
}

