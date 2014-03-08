#!/bin/sh
#
#set -x
#
startdir=$PWD


# ---------------------------------------------------------
#
# set 'versionname' to overwrite generated one based on 'ver'
#

if [ ! -z $1 ]; then
    ver=-$1
fi

date=`date --utc '+%Y.%m.%d-%H.%M'`
if [ -z $versionname ]; then
    versionname=LyX$ver-$date
fi

echo ---------------------------------------------------------
echo ---------- Building $versionname
echo ---------------------------------------------------------



# ---------------------------------------------------------
#
# print some info about the system
#
echo
echo Build system:
echo
uname -a
lsb_release -a
processors=`grep -c processor /proc/cpuinfo`
echo number of processors: $processors
dpkg --get-selections | grep mingw
iam=`whoami`
travis=travis
if [ "$iam" = "$travis" ]; then
    sudo rm -rf /usr/lib/jvm
    df -h
fi
echo ---------------------------------------------------------
echo



# ---------------------------------------------------------
# 
# helper function to check return code
#
checkExitCode() {
    exitcode=$?
    if [ $exitcode -ne 0 ]; then
        echo Command failed
        exit 1
    fi
}



# ---------------------------------------------------------
# 
# checkout bleeding edge
#
if [ "$iam" = "$travis" ]; then
    cd ~
    tar xf $startdir/development/cmake/scripts/lyxdeploy.tar.gz
    checkExitCode
    
    cd $startdir
    git config --global push.default matching
    git config --global user.name "travis"
    git config --global user.email travis@noreply.org
    lyxbinary=LyX-bleeding-edge
    git clone --quiet git@github.com:syntheticpp/$lyxbinary.git
    exitcode=$?
    if [ $exitcode -ne 0 ]; then
        rm -rf $lyxbinary
        git clone --quiet git@github.com:syntheticpp/$lyxbinary.git
    fi
    checkExitCode
fi


# ---------------------------------------------------------
#
# make build directory
#
cd ..
build=_b
if [ -d "$build" ]; then
    echo Removing old build directory $build
    rm -rf $build
fi
mkdir $build
builddir=$PWD/$build
cd $builddir



# ---------------------------------------------------------
#
# get actual cmake 
#
cmakever=cmake-2.8.12.2-Linux-i386

if [ "$iam" = "$travis" ]; then
	if [ ! -d /opt/$cmakever ]; then
		  cmakebin=x
		  if [ ! -d /opt/$cmakever ]; then
			  wget http://www.cmake.org/files/v2.8/$cmakever.tar.gz
			  checkExitCode
			  cd /opt
			  sudo tar xf $builddir/$cmakever.tar.gz
			  checkExitCode
			  cd $builddir
		  fi
	fi
	cmakebin=/opt/$cmakever/bin/cmake
else
	cmakebin=cmake
fi
$cmakebin --version
checkExitCode

gccver=4.7.2
if [ "$2" = "x64" ]; then
	win=win64
	mingw=x86_64-w64-mingw32
    exc=-seh
    mingwdir=mingw64$exc
	branch=
else
	win=win32
	mingw=i686-w64-mingw32
	exc=-dw2
	mingwdir=mingw32$exc
	branch=LyX$ver-win32
fi

qtver=4.8.4
qtver=Qt-$qtver-$win-g++-$mingw$exc-$gccver
mingwver=$mingw-gcc$exc-$gccver


server=http://sourceforge.net/projects/kst/files/3rdparty
# ---------------------------------------------------------
#
# download and install mingw
#
if [ ! -d /opt/$mingwdir ]; then
    mingwtar=$mingwver-Ubuntu64-12.04.tar
    wget $server/$mingwtar.xz
    checkExitCode
    xz -d $mingwtar.xz
    cd /opt
    sudo tar xf $builddir/$mingwtar
    checkExitCode
    cd $builddir
fi

echo Checking mingw installation ...
/opt/$mingwdir/bin/$mingw-gcc -dumpversion
checkExitCode



# ---------------------------------------------------------
#
# download and install Qt
#
if [ ! -d /opt/$qtver ]; then
    qttar=$qtver-Ubuntu64-12.04.tar
    wget $server/$qttar.xz
    checkExitCode
    xz -d $qttar.xz
    cd /opt
    sudo tar xf $builddir/$qttar
    checkExitCode
    cd $builddir
fi
export PATH=/opt/$qtver/bin:$PATH
echo Checking Qt installation ...
which qmake
checkExitCode



# ---------------------------------------------------------
#
# build LyX
#
cd $builddir

# use cmake's version
mv ../lyx2/development/cmake/modules/FindQt4.cmake $builddir/FindQt4.cmake

#mergefile=-DLYX_MERGE_FILE
#pch=-DLYX_PCH=1

$cmakebin ../lyx2/ \
    -DLYX_CPACK=1 \
    -DLYX_PROGRAM_SUFFIX="" \
    -DLYX_CONSOLE=FORCE \
    -DLYX_XMINGW=/opt/$mingwdir/bin/$mingw \
    -DLYX_QT4=/opt/$qtver \
    -DLYX_QUIET=1 \
    $pch $mergefile

checkExitCode


processors=6 # /proc reports 32
make -j $processors
checkExitCode

mv $builddir/FindQt4.cmake ../lyx2/development/cmake/modules/



# ---------------------------------------------------------
#
# deploy
#
make package
checkExitCode

mv LyX-2.1.0-win32.zip $versionname-$win.zip

if [ ! -e $versionname-$win.zip ]; then
    exit 1
fi

if [ "$iam" = "$travis" ]; then
    cd $startdir/$lyxbinary
    git checkout master
    git branch -D $branch
    git checkout -b $branch
    cp -f $builddir/$versionname-$win.zip .
    git add $versionname-$win.zip
    checkExitCode
    
    git commit --quiet -m"Update $win binary to version $versionname"
    checkExitCode

    git push origin HEAD --quiet -f
    checkExitCode
fi


cd $startdir

