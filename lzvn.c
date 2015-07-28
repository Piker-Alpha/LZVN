/*
 * Created: 31 October 2014
 * Name...: lzvn.c
 * Author.: Pike R. Alpha
 * Purpose: Command line tool to LZVN encode/decode a prelinked kernel/file.
 *
 * Updates:
 *			- Support for lzvn_decode() added (Pike R. Alpha, November 2014).
 *			- Support for prelinkedkernels added (Pike R. Alpha, December 2014).
 *			- Debug output data added (Pike R. Alpha, July 2015).
 */

#include "lzvn.h"

//==============================================================================

int main(int argc, const char * argv[])
{
	FILE *fp								= NULL;

	unsigned char * fileBuffer				= NULL;
	unsigned char * workSpaceBuffer			= NULL;
	unsigned char * bufend					= NULL;
	unsigned char * buffer					= NULL;

	PrelinkedKernelHeader * prelinkHeader	= NULL;
	struct fat_header * fatHeader			= NULL;
	struct fat_arch   * fatArch				= NULL;

	unsigned long fileLength				= 0;
	unsigned long byteshandled				= 0;
	unsigned long file_adler32				= 0;
	unsigned long buffer_adler32			= 0;

	size_t compsize							= 0;
	size_t workSpaceSize					= 0;

	if (argc < 3 || argc > 4)
	{
		printf("Usage (encode): %s lzvn <infile> <outfile>\n", argv[0]);
		printf("Usage (decode): %s lzvn -d <infile> <outfile>\n", argv[0]);
		exit(-1);
	}
	else
	{
		// Do we need to decode a file?
		if (!strncmp(argv[1], "-d", 2))
		{
			// Yes. Try to open the file.
			fp = fopen(argv[2], "rb");

			// Check file pointer.
			if (fp == NULL)
			{
				printf("Error: Opening of %s failed... exiting\nDone.\n", argv[1]);
				exit(-1);
			}
			else
			{
				fseek(fp, 0, SEEK_END);
				fileLength = ftell(fp);
				
				printf("Filesize: %ld bytes\n", fileLength);
				
				fseek(fp, 0, SEEK_SET);
				fileBuffer = malloc(fileLength);
				
				if (fileBuffer == NULL)
				{
					printf("ERROR: Failed to allocate file buffer... exiting\nAborted!\n\n");
					fclose(fp);
					exit(-1);
				}
				else
				{
					fread(fileBuffer, fileLength, 1, fp);
					fclose(fp);

					// Check for prelinked kernel
					fatHeader = (struct fat_header *) fileBuffer;

					if (fatHeader->magic == FAT_CIGAM)
					{
						unsigned int i = 1;
						fatArch = (struct fat_arch *)(fileBuffer + sizeof(fatHeader));
						prelinkHeader = (PrelinkedKernelHeader *)((unsigned char *)fileBuffer + OSSwapInt32(fatArch->offset));

						while ((i < OSSwapInt32(fatHeader->nfat_arch)) && (prelinkHeader->signature != OSSwapInt32('comp')))
						{
							printf("Scanning ...\n");
							fatArch = (struct fat_arch *)((unsigned char *)fatArch + sizeof(fatArch));
							prelinkHeader = (PrelinkedKernelHeader *)(fileBuffer + OSSwapInt32(fatArch->offset));
							++i;
						}

						// Is this a LZVN compressed file?
						if (prelinkHeader->compressType == OSSwapInt32('lzvn'))
						{
							printf("Prelinkedkernel found!\n");
							fileBuffer = (unsigned char *)prelinkHeader + sizeof(PrelinkedKernelHeader);
							workSpaceSize = OSSwapInt32(prelinkHeader->uncompressedSize);
							fileLength = OSSwapInt32(prelinkHeader->compressedSize);
						}
						else
						{
							printf("ERROR: Unsupported compression format detected!\n");
							exit(-1);
						}
					}
					else
					{
						// printf("Getting WorkSpaceSize\n");
						workSpaceSize = lzvn_encode_work_size();
					}


					fp = fopen(argv[3], "wb");

					if (fp == NULL)
					{
						printf("Error: Opening of %s failed... exiting\nDone.\n", argv[3]);
						exit(-1);
					}
					else
					{
						// printf("workSpaceSize: %ld \n", workSpaceSize);
						workSpaceBuffer = malloc(workSpaceSize);

						if (workSpaceBuffer == NULL)
						{
							printf("ERROR: Failed to allocate workSpaceBuffer ... exiting\nAborted!\n\n");
							exit(-1);
						}
						else
						{
							printf("Decoding data ...\nWriting data to: %s\n", argv[3]);

							/* if (workSpaceSize > 0x80000)
							{ */
								compsize = lzvn_decode(workSpaceBuffer, workSpaceSize, fileBuffer, fileLength);

								if (compsize > 0)
								{
									// Are we unpacking a prelinkerkernel?
									if (prelinkHeader)
									{
										printf("Checking adler32 ... ");

										// Yes. Check adler32.
										if (OSSwapInt32(prelinkHeader->adler32) != local_adler32(workSpaceBuffer, workSpaceSize))
										{
											printf("ERROR: Adler32 mismatch!\n");
											free(workSpaceBuffer);
											fclose(fp);
											exit(-1);
										}
										else
										{
											printf("OK (0x%08x)\n", OSSwapInt32(prelinkHeader->adler32));
										}
									}

									fwrite(workSpaceBuffer, 1, compsize, fp);
								}
							/* }
							else
							{
								while ((compsize = lzvn_decode(workSpaceBuffer, workSpaceSize, fileBuffer, fileLength)) > 0)
								{
									printf("compsize: %ld\n", compsize);
									fwrite(workSpaceBuffer, 1, compsize, fp);
									fileBuffer += workSpaceSize;
									byteshandled += workSpaceSize;
								}
							
								fileBuffer -= byteshandled;
							} */

							free(workSpaceBuffer);

							printf("%ld bytes written\n", ftell(fp));
							fclose(fp);
							printf("Done.\n");
							exit(0);
						}
					}
				}
			}
		}
		else // Do we need to encode a file?
		{
			fp = fopen(argv[1], "rb");

			if (fp == NULL)
			{
				printf("Error: Opening of %s failed... exiting\nDone.\n", argv[1]);
				exit(-1);
			}
			else
			{
				fseek(fp, 0, SEEK_END);
				fileLength = ftell(fp);
				printf("fileLength...: %ld/0x%08lx - %s\n", fileLength, fileLength, argv[1]);
				fseek(fp, 0, SEEK_SET);

				fileBuffer = malloc(fileLength);

				if (fileBuffer == NULL)
				{
					printf("ERROR: Failed to allocate file buffer... exiting\nAborted!\n\n");
					fclose(fp);
					exit(-1);
				}
				else
				{
					fread(fileBuffer, fileLength, 1, fp);
					fclose(fp);

					size_t workSpaceSize = lzvn_encode_work_size();
					void * workSpace = malloc(workSpaceSize);

					if (workSpace == NULL)
					{
						printf("\nERROR: Failed to allocate workspace... exiting\nAborted!\n\n");
						exit(-1);
					}
					else
					{
						printf("workSpaceSize: %ld/0x%08lx\n", workSpaceSize, workSpaceSize);

						if (fileLength > workSpaceSize)
						{
							workSpaceSize = fileLength;
						}

						workSpaceBuffer = (void *)malloc(workSpaceSize);

						if (workSpaceBuffer == NULL)
						{
							printf("ERROR: Failed to allocate workSpaceBuffer ... exiting\nAborted!\n\n");
							exit(-1);
						}
						else
						{
							printf("adler32......: 0x%08x\n", local_adler32(fileBuffer, fileLength));

							size_t outSize = lzvn_encode(workSpaceBuffer, workSpaceSize, (u_int8_t *)fileBuffer, (size_t)fileLength, workSpace);
							printf("outSize......: %ld/0x%08lx\n", outSize, outSize);

							free(workSpace);

							if (outSize != 0)
							{
								bufend = workSpaceBuffer + outSize;
								compsize = bufend - workSpaceBuffer;
								printf("compsize.....: %ld/0x%08lx\n", compsize, compsize);

								fp = fopen (argv[2], "wb");
								fwrite(workSpaceBuffer, outSize, 1, fp);
								fclose(fp);
							}
						}

						free(fileBuffer);
						free(workSpaceBuffer);

						exit(0);

					}
				}
			}
		}
	}

	exit(-1);
}
