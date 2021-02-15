REM unregister the dll as ActiveX library
%windir%\Microsoft.NET\Framework\v1.1.4322\regasm.exe %windir%\System32\Bytescout.BarCode.dll /tlb:%windir%\System32\Bytescout.BarCode.tlb /unregister 

REM removing Bytescout.BarCode.dll
DEL %windir%\System32\Bytescout.BarCode.dll
DEL %windir%\System32\Bytescout.BarCode.tlb

