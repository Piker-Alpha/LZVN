/*
 * Created..: 31 October 2014
 * Filename.: lzvn.c
 * Author...: Pike R. Alpha
 * Purpose..: Command line tool to LZVN compress a file.
 */

#include "FastCompression.h"

//==============================================================================

int main(int argc, const char * argv[])
{
	FILE *fp							= NULL;

	unsigned char * fileBuffer			= NULL;
	unsigned char * uncompressedBuffer	= NULL;
	unsigned char * bufend				= NULL;

	unsigned long fileLength = 0;

	size_t compsize = 0;

	if (argc != 3)
	{
		printf("Usage: %s lzvn <infile> <outfile>\n", argv[0]);
		exit(-1);
	}
	else
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
			printf("fileLength: %ld\n", fileLength);
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
				printf("workSpaceSize: %ld \n", workSpaceSize);

				void * workSpace = malloc(workSpaceSize);

				if (workSpace == NULL)
				{
					printf("ERROR: Failed to allocate workspace... exiting\nAborted!\n\n");
					exit(-1);
				}
				else
				{
					printf("workSpace declared\n");
                    
					if (fileLength > workSpaceSize)
					{
                        workSpaceSize = fileLength;
					}

					uncompressedBuffer = (void *)malloc(workSpaceSize);

					if (uncompressedBuffer == NULL)
					{
						printf("ERROR: Failed to allocate uncompressed buffer... exiting\nAborted!\n\n");
						exit(-1);
					}
					else
					{
						size_t outSize = lzvn_encode(uncompressedBuffer, workSpaceSize, (u_int8_t *)fileBuffer, (size_t)fileLength, workSpace);
						printf("outSize: %ld\n", outSize);

						free(workSpace);

						if (outSize != 0)
						{
							bufend = uncompressedBuffer + outSize;
							compsize = bufend - uncompressedBuffer;
							printf("compsize: %ld\n", compsize);

							fp = fopen (argv[2], "wb");
							fwrite(uncompressedBuffer, outSize, 1, fp);
							fclose(fp);
						}
					}

					free(fileBuffer);
					free(uncompressedBuffer);

					exit(0);

				}
			}
		}
	}

	exit(-1);
}
