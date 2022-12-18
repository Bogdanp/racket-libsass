@ECHO off

git submodule update --init
mkdir artifacts\win32-i386
cd libsass
"%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\15.0\Bin\MSbuild.exe" win\libsass.sln /p:Configuration=Release /p:Platform=Win32 /m
copy win\bin\libsass.dll ..\artifacts\win32-i386\libsass.dll
cd ..
