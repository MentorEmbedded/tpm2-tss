#!/bin/sh

ENDIAN=`echo -n I | od -to2 | head -n1 | cut -f2 -d" " | cut -c6`

if [ x"$ENDIAN" = x"0" ]; then
    echo "Big Endian"
else
    echo "Little Endian"
    exit
fi

ACTION="$1"
if [ x"$ACTION" = "x" ]; then
    exit
fi

if [ x"$ACTION" = "xpatch" ]; then
    if [ -f ./sysapi/include/endianConv.h ]; then
	if [ -e ./sysapi/include/endianConv.h.debbak01 ]; then
	    echo "skip patching"
	else
	    mv -f ./sysapi/include/endianConv.h ./sysapi/include/endianConv.h.debbak01
	    sed 's/^#define LITTLE_ENDIAN_CPU$/\/* #define LITTLE_ENDIAN_CPU *\//g' ./sysapi/include/endianConv.h.debbak01 > ./sysapi/include/endianConv.h
	fi
    fi
elif [ x"$ACTION" = "xunpatch" ]; then
    if [ -e ./sysapi/include/endianConv.h.debbak01 ]; then
	mv -f ./sysapi/include/endianConv.h.debbak01 ./sysapi/include/endianConv.h
    fi
fi
