@ECHO off

git submodule update --init
mkdir artifacts\win32-x86-64
cd libsass
git reset --hard HEAD
"%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSbuild.exe" win\libsass.sln /p:Configuration=Release
copy win\bin\libsass.dll ..\artifacts\win32-x86-64\libsass.dll
cd ..
