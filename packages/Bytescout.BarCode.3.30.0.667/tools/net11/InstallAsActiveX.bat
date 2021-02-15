REM change current directory (required for Vista and higher)
@setlocal enableextensions
@cd /d "%~dp0"

REM coping Bytescout.BarCode.dll into /System32/ as COM server libraries
copy Bytescout.BarCode.dll %windir%\System32\Bytescout.BarCode.dll
copy Bytescout.BarCode.tlb %windir%\System32\Bytescout.BarCode.tlb

REM register the dll as ActiveX library
%windir%\Microsoft.NET\Framework\v1.1.4322\regasm.exe %windir%\System32\Bytescout.BarCode.dll /tlb:%windir%\System32\Bytescout.BarCode.tlb /codebase
