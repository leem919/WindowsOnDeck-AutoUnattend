@echo off

REM
REM   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
REM   ;;;                                                                  ;;;
REM   ;;;  Dynamic Link Binaries-Setup Packages                            ;;;
REM   ;;;  Property of AMD-ID.com, do not distribute without crediting     ;;;
REM   ;;;  or mentioning owners                                            ;;;
REM   ;;;  RdN_ID-Community/drivers/distribution                           ;;;
REM   ;;;                                                                  ;;;
REM   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
REM

CLS
del %AMDINFDISP%\%UNIVERSALINF%.inf /q > nul
CLS
del %AMDINFDISP%\%UNIFLEXAPUINF%.inf /q > nul
CLS
del %AMDINFDISP%\%UNIFLEXMACINF%.inf /q > nul
CLS
del %AMDINFDISP%\%UNIFLEXGPUINF%.inf /q > nul
CLS
COPY .\MultiParse\sdi_display.cfg .\sdi.cfg /Y > nul
COPY .\MultiParse\%INFNAME%%INFPROFILE% %AMDINFDISP%\%INFDEST% /Y > nul
CLS
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
SET ATISETMODE=ATIBINNATIVE&GOTO COINSTINIT

:COINSTINIT
cls
tasklist.exe > task.log
findstr "%BGM%" task.log && (goto COFOUND) > nul
GOTO %ATISETMODE%

:COFOUND
cls
%NIRCMD% killprocess %BGM% > nul
START /b %COINSTPATH% > nul
DEL *.log /q > nul
GOTO %ATISETMODE%

:ATIBINNATIVE
call .\Bin64\ATILibCOM.cmd
call .\Bin64\ATILibCOMGen.cmd
call .\Bin64\ATILibCOMDisp.cmd
call .\Bin64\ATILibCOMAud.cmd
call .\Bin64\ATILibCOMNS.cmd
call .\Bin64\ATIVaxyProxy.cmd
GOTO FINALIZE

:ATIBINSDI
call .\Bin64\ATILibCOM.cmd
call .\Bin64\ATILibCOMGen.cmd
call .\Packages\sdi.exe > %UserName%-SnappyLogs-%date:~0,2%%date:~3,2%%date:~8,2%-%INFNAME%%INFPROFILE%.txt
call .\Bin64\ATILibCOMNS.cmd
GOTO FINALIZE

:FINALIZE
REM call .\Bin64\ATICMDADL.cmd ; skipped for non-pro system
call .\Bin64\ATICMDPX.cmd
call .\Bin64\ATICMDULPS.cmd
call .\Bin64\ATICMDRSB.cmd
call .\Bin64\ATICMDRSProf.cmd
call .\bin64\ATICMDQC.cmd

:DRIVERCOMP
CLS
RMDIR "%SYSTEMDRIVE%\Program Files\AMD\amdkmpfd_in" /s /q
RMDIR "%AMDWINDIR%\amdkmpfd" /s /q

:AskPciBusReqDisa0000
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO AskPciBusReqDisa0000found
if %ERRORLEVEL% EQU 1 GOTO AskPciBusReqDisa0001
:AskPciBusReqDisa0000found
CLS
%CENUMIMPORT% %ENUMSID%\PciBusReqDisa_0000.dat > nul
CLS

:AskPciBusReqDisa0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO AskPciBusReqDisa0001found
if %ERRORLEVEL% EQU 1 GOTO AskPciBusReqDisa0002
:AskPciBusReqDisa0001found
CLS
%CENUMIMPORT% %ENUMSID%\PciBusReqDisa_0001.dat > nul
CLS

:AskPciBusReqDisa0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO AskPciBusReqDisa0002found
if %ERRORLEVEL% EQU 1 GOTO AskPciBusReqDisa0003
:AskPciBusReqDisa0002found
CLS
%CENUMIMPORT% %ENUMSID%\PciBusReqDisa_0002.dat > nul
CLS

:AskPciBusReqDisa0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO AskPciBusReqDisa0003found
if %ERRORLEVEL% EQU 1 GOTO DRIVERFINAL
:AskPciBusReqDisa0003found
CLS
%CENUMIMPORT% %ENUMSID%\PciBusReqDisa_0003.dat > nul
CLS

:DRIVERFINAL
CLS
ECHO.
ECHO  Create/Repair Task Scheduler ...
powershell.exe Unregister-ScheduledTask -TaskName "NzAutoRepairUI" -Confirm:$false > nul
powershell.exe Unregister-ScheduledTask -TaskName "MSFTAutoRepairUI" -Confirm:$false > nul
powershell.exe Unregister-ScheduledTask -TaskName "StartCNHealth" -Confirm:$false > nul
RMDIR %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth /s /q
MKDIR %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth
COPY .\Bin64\devgen.exe %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\devgen.exe
COPY .\Bin64\ATICN.nss %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\ATICN.cmd
COPY .\Bin64\ATICMD.exe %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\ATICMD.exe
COPY .\Bin64\msvcp140d.dll %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\msvcp140d.dll
COPY .\Bin64\vcruntime140d.dll %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\vcruntime140d.dll
COPY .\Bin64\ucrtbased.dll %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\ucrtbased.dll
schtasks /create /xml ".\Bin64\StartCNHealth.xml" /tn "\StartCNHealth" /f

ver | find "10.0.1" && (goto DRIVERCOMPLETED_W10)
ver | find "10.0.2" && (goto DRIVERCOMPLETED_W11)

:DRIVERCOMPLETED_W10
COPY %ENUMSID%\StubRadeonError10.dat %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\StubRadeonError.dat /Y
GOTO DRIVERCOMPLETED

:DRIVERCOMPLETED_W11
COPY %ENUMSID%\StubRadeonError11.dat %SYSTEMDRIVE%\ProgramData\AMD\StartCNHealth\StubRadeonError.dat /Y
GOTO DRIVERCOMPLETED

:DRIVERCOMPLETED
CLS
%CENUMIMPORT% %ENUMSID%\StubDrv.dat > nul
CLS
COLOR 0F
CLS
ECHO  ============================================================================================================
ECHO.
ECHO   ACTION:
ECHO   Driver Installation Completed 
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
%WINDIR%\SYSTEM32\PING.EXE -n 2 0.0.0.0 > nul

:ASKUI
CLS
COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
GOTO UIBEGIN

:UIBEGIN
cls
SET BREAKSTATE=AMDADRUI
goto FINALINIT

:BREAKCALS
cls
SET BREAKSTATE=CHFIRSTRUN
goto FINALINIT

:FINALINIT
cls
call tasklist | find "%COINSTEXE%" && (goto FINALFOUND)  > nul
GOTO FINALE

:FINALFOUND
cls
%NIRCMD% killprocess %COINSTEXE% > nul
START /b %BGM% > nul
DEL *.log /q
GOTO FINALE

:FINALE
cls
del %AMDINFDISP%\%INFDEST% /q > nul
cls