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

#include <sys/types.h>

#include <mach-o/fat.h>
#include <mach-o/loader.h>
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

static u_int32_t gFileHeader[ 103 ] =
{
	0xBEBAFECA, 0x01000000, 0x07000001, 0x03000000, 0x1C000000, 0xFFFFFFFF, 0x00000000, 0x706D6F63,
	0x6E767A6C, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x01000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000
};

/*==============================================================================
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


//==============================================================================

struct segment_command_64 * find_segment_64(struct mach_header_64 * aMachHeader, const char * aSegmentName)
{
	struct load_command *loadCommand;
	struct segment_command_64 *segment;
	
	// First LOAD_COMMAND begins straight after the mach header.
	loadCommand = (struct load_command *)((uint64_t)aMachHeader + sizeof(struct mach_header_64));
	
	while ((uint64_t)loadCommand < (uint64_t)aMachHeader + (uint64_t)aMachHeader->sizeofcmds + sizeof(struct mach_header_64))
	{
		if (loadCommand->cmd == LC_SEGMENT_64)
		{
			// Check load command's segment name.
			segment = (struct segment_command_64 *)loadCommand;
			
			if (strcmp(segment->segname, aSegmentName) == 0)
			{
				return segment;
			}
		}
		
		// Next load command.
		loadCommand = (struct load_command *)((uint64_t)loadCommand + (uint64_t)loadCommand->cmdsize);
	}
	
	// Return NULL on failure (segment not found).
	return NULL;
}


//==============================================================================

uint8_t is_prelinkedkernel(unsigned char * aFileBuffer)
{
	struct segment_command_64 *	prelinkTextSegment	= NULL;
	struct segment_command_64 *	prelinkInfoSegment	= NULL;
	
	struct mach_header_64 * machHeader = (struct mach_header_64 *)((unsigned char *)aFileBuffer);
	
	prelinkTextSegment = find_segment_64(machHeader, "__PRELINK_TEXT");
	prelinkInfoSegment = find_segment_64(machHeader, "__PRELINK_INFO");
	
	if ((prelinkTextSegment && prelinkInfoSegment->filesize) &&
		(prelinkTextSegment && prelinkTextSegment->filesize))
	{
		return 1;
	}
	
	return 0;
}

