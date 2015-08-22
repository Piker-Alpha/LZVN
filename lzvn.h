/*
 * Created..: 31 October 2014
 * Filename.: lzvn.c
 * Author...: Pike R. Alpha
 * Purpose..: Command line tool to LZVN encode/decode a file.
 *
 * Updates:
 *			- Prelinkedkerel check added (Pike R. Alpha, August 2015).
 *			- Mach header injection for prelinkedkernels added (Pike R. Alpha, August 2015).
 *			- Extract kernel option added (Pike R. Alpha, August 2015).
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


//==============================================================================

uint8_t saveKernel(unsigned char * aFileBuffer)
{
	struct segment_command_64 * lastSegment			= NULL;
	struct segment_command_64 *	prelinkTextSegment	= NULL;
	struct segment_command_64 *	prelinkInfoSegment	= NULL;
	struct segment_command_64 *	linkeditSegment		= NULL;

	struct section_64 * prelinkTextSection			= NULL;
	struct section_64 * prelinkInfoSection			= NULL;

	struct mach_header_64 * machHeader = (struct mach_header_64 *)((unsigned char *)aFileBuffer);
	
	if ((lastSegment = find_segment_64(machHeader, "__LAST")) == NULL)
	{
		printf("ERROR: find_segment_64(\"__LAST\") failed!\n");
		return -1;
	}

	if ((prelinkTextSegment = find_segment_64(machHeader, "__PRELINK_TEXT")) == NULL)
	{
		printf("ERROR: find_segment_64(\"__PRELINK_TEXT\") failed!\n");
		return -1;
	}

	if ((prelinkInfoSegment = find_segment_64(machHeader, "__PRELINK_INFO")) == NULL)
	{
		printf("ERROR: find_segment_64(\"__PRELINK_INFO\") failed!\n");
		return -1;
	}

	if ((linkeditSegment = find_segment_64(machHeader, SEG_LINKEDIT)) == NULL)
	{
		printf("ERROR: find_segment_64(\"__LINKEDIT\") failed!\n");
		return -1;
	}
	
	prelinkTextSegment->vmaddr = linkeditSegment->vmaddr;
	prelinkTextSegment->vmsize = 0;
	prelinkTextSegment->fileoff = (lastSegment->fileoff + lastSegment->filesize);
	prelinkTextSegment->filesize = 0;

	prelinkTextSection = (struct section_64 *)((uint64_t)prelinkTextSegment + sizeof(struct segment_command_64));

	prelinkTextSection->addr = prelinkTextSegment->vmaddr;
	prelinkTextSection->size = 0;
	prelinkTextSection->offset = prelinkTextSegment->fileoff;
		
	prelinkInfoSegment->vmaddr = linkeditSegment->vmaddr;
	prelinkInfoSegment->vmsize = 0;
	prelinkInfoSegment->fileoff = (lastSegment->fileoff + lastSegment->filesize);
	prelinkInfoSegment->filesize = 0;

	prelinkInfoSection = (struct section_64 *)((uint64_t)prelinkInfoSegment + sizeof(struct segment_command_64));

	prelinkInfoSection->addr = prelinkTextSegment->vmaddr;
	prelinkInfoSection->size = 0;
	prelinkInfoSection->offset = prelinkInfoSegment->fileoff;
		
	FILE *fp = fopen("kernel", "wb");
	fwrite(aFileBuffer, 1, (long)(linkeditSegment->fileoff + linkeditSegment->filesize), fp);
	printf("%ld bytes written\n", ftell(fp));
	fclose(fp);
	
	return 0;
}
