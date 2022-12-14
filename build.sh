#!/usr/bin/env sh
#$Id: build.sh,v 1.26 2008/09/12 13:57:01 khorben Exp $
#Copyright (c) 2011 Pierre Pronchery <ppronchery@bearstech.com>
#This file is part of RunningBear



#variables
CFLAGS=
CPATH=
CPPFLAGS=
LDFLAGS=
DESTDIR=
HOST=
IMAGE_FILE=
IMAGE_TYPE=
ARCH=
LANG=C
PREFIX=
SYSTEM=
TARGET=
VENDOR="RunningBear"

#executables
CC=
CHMOD="chmod"
CHOWN="chown"
DD="dd bs=1024"
INSTALL="install"
LD=
LN="ln -f"
MAKE="make"
MKDIR="mkdir -m 755 -p"
MKNOD="mknod"
MV="mv -f"
RM="rm -f"
RMDIR="rmdir -p"
SUDO=

#internals
DEVZERO="/dev/zero"
PROGNAME="$0"


#functions
#check
check()
{
	USAGE="$1"
	EMPTY=

	shift
	for i in $@; do
		VAR=`eval echo "\\\$\$i"`
		[ -z "$VAR" ] && EMPTY="$EMPTY $i"
	done
	[ -z "$EMPTY" ] && return
	USAGE=`echo -e "$USAGE\n\nError:$EMPTY need to be set"`
	usage "$USAGE"
	exit 2
}


#error
error()
{
	echo "build.sh: $1" 1>&2
	exit 2
}


#usage
usage()
{
	echo "Usage: build.sh [option=value...] target..."
	echo "Targets:"
	echo "  all		Build everything"
	echo "  clean		Remove object files"
	echo "  distclean	Remove all compiled files"
	echo "  install	Install everything"
	echo "  image		Create an image"
	echo "  uninstall	Uninstall everything"
	if [ ! -z "$1" ]; then
		echo
		echo "$1"
	fi
	exit 1
}


#target
target()
{
	_MAKE="$MAKE"
	[ ! -z "$DESTDIR" ] && _MAKE="$_MAKE DESTDIR=\"$DESTDIR\""
	[ ! -z "$PREFIX" ] && _MAKE="$_MAKE PREFIX=\"$PREFIX\""
	[ ! -z "$CC" ] && _MAKE="$_MAKE CC=\"$CC\""
	[ ! -z "$CPPFLAGS" ] && _MAKE="$_MAKE CPPFLAGS=\"$CPPFLAGS\""
	[ ! -z "$CFLAGS" ] && _MAKE="$_MAKE CFLAGS=\"$CFLAGS\""
	[ ! -z "$LD" ] && _MAKE="$_MAKE LD=\"$LD\""
	[ ! -z "$LDFLAGS" ] && _MAKE="$_MAKE LDFLAGS=\"$LDFLAGS\""
	[ ! -z "$HOST" ] && _MAKE="$_MAKE HOST=\"$HOST\""
	for i in $SUBDIRS; do
		(cd "$i" && eval $_MAKE "$1") || return $?
	done
	return 0
}


#main
#environment
umask 022
#parse options
while [ $# -gt 0 ]; do
	case "$1" in
		*=*)
			VAR=${1%%=*}
			VALUE=${1#*=}
			eval "$VAR='$VALUE'; export $VAR"
			shift
			;;
		*)
			break
			;;
	esac
done

#initialize target
[ -z "$ARCH" ] && ARCH=`uname -m`
[ -z "$SYSTEM" ] && SYSTEM=`uname -s`
[ -z "$TARGET" ] && TARGET="$SYSTEM-$ARCH"
#FIXME partially disabled for now
if [ ! -f "Apps/Devel/Sources/scripts/targets/$TARGET" ]; then
	case "$ARCH" in
		arm*b|arm*l)
			ARCH="arm"
			;;
		i?86)
			ARCH="i386"
			;;
		sparc64)
			ARCH="sparc"
			;;
		x86_64)
			ARCH="amd64"
			;;
	esac
	TARGET="$SYSTEM-$ARCH"
fi
if [ ! -f "Apps/Devel/Sources/scripts/targets/$TARGET" ]; then
	echo "$PROGNAME: warning: $TARGET: Unsupported target" 1>&2
else
	. "Apps/Devel/Sources/scripts/targets/$TARGET"
fi

#initialize variables
[ -z "$IMAGE_TYPE" ] && IMAGE_TYPE="image"
[ -z "$IMAGE_FILE" ] && IMAGE_FILE="$VENDOR-$IMAGE_TYPE.img"
[ -z "$DESTDIR" ] && DESTDIR="$PWD/destdir"
[ -z "$PREFIX" ] && PREFIX="/usr/local"
[ -z "$SUBDIRS" ] && SUBDIRS="System/Sources/libc \
	System/Sources/openssl \
	System/Sources/libSystem \
	System/Sources/Init \
	Apps/Unix/Sources/sh \
	Apps/Unix/Sources/utils \
	Apps/Unix/Sources/others \
	Apps/Unix/Sources/devel \
	Apps/GNU/Sources/getopt \
	Apps/GNU/Sources/gettext \
	Apps/GNU/Sources/libiconv \
	Apps/Graphics/Sources/xynth \
	Apps/Devel/Sources/glib \
	Apps/Devel/Sources/python"
[ -z "$UID" ] && UID=`id -u`
[ -z "$SUDO" -a "$UID" -ne 0 ] && SUDO="sudo"


#run targets
if [ $# -lt 1 ]; then
	usage
	exit $?
fi
while [ $# -gt 0 ]; do
	case "$1" in
		all|install)
			echo "$PROGNAME: Making target $1 on $TARGET" 1>&2
			target "install"			|| exit 2
			;;
		clean|distclean|uninstall)
			echo "$PROGNAME: Making target $1 on $TARGET" 1>&2
			target "$1"				|| exit 2
			;;
		image)
			echo "$PROGNAME: Making target $1 on $TARGET" 1>&2
			target_image				|| exit 2
			;;
		*)
			echo "build.sh: $1: Unknown target" 1>&2
			usage
			exit $?
			;;
	esac
	shift
done
