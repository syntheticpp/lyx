echo off

REM Add path to qmake here or set PATH correctly on your system.
set PATH=C:\Qt\Qt5.6.0\5.6\mingw492_32\bin;%PATH%
set PATH=C:\Qt\Qt5.6.0\Tools\mingw492_32\bin;%PATH%

set GNUWIN32_DIR=C:\LyXGit\msvc2010-deps
set PATH="%GNUWIN32_DIR%\deps20\Python";%PATH%

::del CMakeCache.txt

REM set -DLYX_MERGE_REBUILD and -DLYX_MERGE_FILES to 1 for a version released with an installer
cmake ..\lyx -GNinja -DLYX_3RDPARTY_BUILD=ON -DLYX_ENABLE_CXX11=ON -DLYX_USE_QT=QT5 -DLYX_MERGE_REBUILD=1 -DLYX_MERGE_FILES=1 -DLYX_NLS=1 -DLYX_INSTALL=1 -DLYX_RELEASE=1 -DLYX_CONSOLE=OFF 
ninja


:eof
