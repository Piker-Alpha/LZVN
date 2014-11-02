##
#
# LZVN encode/decode routines
#
# Intel 64-bit (x86_64) version
#
##

PREFIX=/usr/local

AS=as
AR=ar
CC=cc
RANLIB=ranlib
INSTALL=install
ASFLAGS=-arch x86_64
ARFLAGS=cru
CFLAGS=-arch x86_64 -O2

all: lzvn

.s.o:
	$(AS) $(ASFLAGS) -o $@ $<

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

libFastCompression.a: lzvn_encode.o
	$(AR) $(ARFLAGS) $@ lzvn_encode.o
	$(RANLIB) libFastCompression.a

lzvn: lzvn.o libFastCompression.a
	$(CC) $(CFLAGS) -o $@ lzvn.o -L. -lFastCompression

clean:
	rm -f *.o lzvn

install: lzvn.h
	$(INSTALL) lzvn $(PREFIX)/bin
