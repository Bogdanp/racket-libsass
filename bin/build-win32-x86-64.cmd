@ECHO off

git submodule update --init
mkdir artifacts\win32-x86-64
cd libsass
"%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSbuild.exe" win\libsass.sln /p:Configuration=Release /p:Platform=Win64 /m
copy win\bin\libsass.dll ..\artifacts\win32-x86-64\libsass.dll
cd ..
