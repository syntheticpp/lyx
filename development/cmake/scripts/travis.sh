
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

if [ "$iam" = "$travis" ]; then
    deploybinary=1
else
    deploybinary=0
fi

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
if [ $deploybinary -eq 1 ]; then
    if [ "$iam" = "$travis" ]; then
        cd ~
        tar xf $startdir/development/cmake/scripts/lyxdeploy.tar.gz
        checkExitCode
    fi

    cd $startdir
    lyxbinary=LyX-bleeding-edge
    rm -rf $lyxbinary
    mkdir $lyxbinary
    cd $lyxbinary
    git init --quiet
    git config user.name "travis"
    git config user.email travis@noreply.org
    git remote add origin git@github.com:syntheticpp/$lyxbinary.git
    git fetch origin master --quiet
fi
cd $startdir

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
    branch=LyX$ver-master-win64
else
    win=win32
    mingw=i686-w64-mingw32
    exc=-dw2
    mingwdir=mingw32$exc
    branch=LyX$ver-master-win32
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
mv ../lyx/development/cmake/modules/FindQt4.cmake $builddir/FindQt4.cmake

#mergefile=-DLYX_MERGE_FILE
#pch=-DLYX_PCH=1

$cmakebin ../lyx/ \
    -DLYX_CPACK=1 \
    -DLYX_PROGRAM_SUFFIX="" \
    -DLYX_CONSOLE=FORCE \
    -DLYX_XMINGW=/opt/$mingwdir/bin/$mingw \
    -DLYX_QT4=/opt/$qtver \
    -DLYX_QUIET=1 \
    -DGNUWIN32_DIR=$builddir/../lyx/development/3rdparty/win_x86 \
    $pch $mergefile

checkExitCode


processors=6 # /proc reports 32
make -j $processors
checkExitCode

mv $builddir/FindQt4.cmake ../lyx/development/cmake/modules/



# ---------------------------------------------------------
#
# deploy
#
make package
checkExitCode

mv LyX22-2.2.0-win32.zip $branch.zip

if [ ! -e $branch.zip ]; then
    exit 1
fi

if [ $deploybinary -eq 1 ]; then
    cd $startdir/$lyxbinary
    git checkout master
    git branch -D $branch
    git checkout -b $branch
    cp -f $builddir/$branch.zip .
    git add $branch.zip
    checkExitCode

    git commit --quiet -m"Update $win binary to version $versionname"
    checkExitCode

    git push origin HEAD --quiet -f
    checkExitCode
fi


cd $startdir

