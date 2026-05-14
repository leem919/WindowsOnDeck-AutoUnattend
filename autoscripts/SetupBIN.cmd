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

echo off
mode con: cols=111 lines=41
color 07
setlocal EnableExtensions
@CD /d "%~dp0"
cd.. 

START /b .\bin64\nircmd.exe mediaplay 2500 "%WINDIR%\Media\Windows Notify System Generic.wav"
CLS&CALL .\Bin64\cmdLibCoInst.cmd&cls
%CENUMADD% "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /VE /T REG_SZ /F /D "Service" > nul
%CENUMADD% "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /VE /T REG_SZ /F /D "Service" > nul
IF EXIST *.log (goto CLEANPARAM1)
IF EXIST *.txt (goto CLEANPARAM1)
GOTO CLEANSKIP1

:CLEANPARAM1
CLS&attrib .\*.txt -h > nul
CLS&attrib .\*.log -h > nul
CLS&DEL *.log /q > nul
CLS&DEL *.txt /q > nul

:CLEANSKIP1
set BGM=AudioModule.exe
set BGMPATH=.\Bin64\AudioModule.exe
set COINSTEXE=CoInst.exe
set COINSTPATH=.\Bin64\CoInst.exe
call .\Bin64\NirCMD.exe killprocess tasklist.exe > nul
%CENUMIMPORT% .\Bin64\MPlayEx.msu > nul

:MUSICBGM
CLS&CALL .\Bin64\NirCMD.exe killprocess tasklist.exe > nul
call tasklist | find "%BGM%" > nul && (goto BGMFOUND)
GOTO BGMNOTFOUND

:BGMFOUND
CLS&CALL %NIRCMD% killprocess %BGM% > nul
call %NIRCMD% killprocess %COINSTEXE% > nul
call %NIRCMD% killprocess tasklist.exe > nul
IF EXIST *.log (goto CLEANBGMFOUND1)
IF EXIST *.txt (goto CLEANBGMFOUND1)
GOTO CLEANBGMFOUNDSKIP1

:CLEANBGMFOUND1
DEL *.txt /q > nul
DEL *.log /q > nul

:CLEANBGMFOUNDSKIP1
GOTO CHFIRSTRUN

:BGMNOTFOUND
CLS
START /b %BGMPATH%
call %NIRCMD% killprocess %COINSTEXE% > nul
call %NIRCMD% killprocess tasklist.exe > nul
IF EXIST *.log (goto CLEANBGMNOTFOUND1)
IF EXIST *.txt (goto CLEANBGMNOTFOUND1)
GOTO CLEANBGMNOTFOUNDSKIP1

:CLEANBGMNOTFOUND1
DEL *.txt /q > nul
DEL *.log /q > nul

:CLEANBGMNOTFOUNDSKIP1
GOTO CHFIRSTRUN

:CHFIRSTRUN
CLS&CALL .\Bin64\cmdLibCoInst.cmd&cls
SET INFSELTAR=VanGogh&SET INFSELVER=2330&SET ATIBDESC=AMD SoC %DRVPACKAGE% for Steam Deck / VanGogh&GOTO CHAMDDRVUSRINST
REM   ============================================================================================================
REM     FOR DEBUGGING PURPOSE
REM   ============================================================================================================
IF %SETUPF%==d call .\Bin64\ATIBinSetupVaxy.cmd&GOTO CHFIRSTRUN
IF %SETUPF%==D call .\Bin64\ATIBinSetupVaxy.cmd&GOTO CHFIRSTRUN
REM IF %SETUPF%==g GOTO GUISETUP
REM IF %SETUPF%==G GOTO GUISETUP
GOTO CHFIRSTRUN

:AMDADRUI
CALL .\Bin64\ATIVaxyPanel.cmd&GOTO ATIVAXYINIT

:ATIVAXYINIT
GOTO %GETVAXYREQ%&GOTO ATIVAXYINIT

:ATIVAXYINIT2
%GETVAXYREQ%&GOTO ATIVAXYINIT2

REM   ============================================================================================================
REM    Universal Consumer Radeon Devices
REM   ============================================================================================================

:CHAMDDRVUSRINST
CLS&SET INFNAME=%UNIVERSALINF%
SET INFPROFILE=_%INFSELTAR%_%INFSELVER%.inf
SET INFDEST=%UNIVERSALINF%.inf
SET ATICOMDESC=%ATIBDESC%
call .\Bin64\ATIBINSetup.cmd
GOTO %BREAKSTATE%

REM   ============================================================================================================
REM    Universal Enteprise Radeon Devices
REM   ============================================================================================================

:CHAMDDRVPROINST
CLS&SET INFNAME=%UNIVERSALINF%
SET INFPROFILE=_%INFSELTAR%_%INFSELVER%.inf
SET INFDEST=%UNIVERSALINF%.inf
SET ATICOMDESC=%ATIBDESC%
call .\Bin64\ATIBINSetupPro.cmd
GOTO %BREAKSTATE%

REM   ============================================================================================================
REM    Universal Mac Radeon Devices
REM   ============================================================================================================

:CHAMDDRVMACINST
CLS&SET INFNAME=%UNIFLEXPVNMACINF%
SET INFPROFILE=_%INFSELTAR%_%INFSELVER%.inf
SET INFDEST=%UNIFLEXPVNMACINF%.inf
SET ATICOMDESC=%ATIBDESC%
call .\Bin64\ATIBINSetupPro.cmd
GOTO %BREAKSTATE%


REM   ============================================================================================================
REM    Universal Flex for Polaris / Vega / Navi
REM   ============================================================================================================

:CHFLEXPVNAPUINST
CLS&SET INFNAME=%UNIFLEXPVNAPUINF%
SET INFPROFILE=_%INFSELTAR%_%INFSELVER%.inf
SET INFDEST=%UNIFLEXPVNAPUINF%.inf
SET ATICOMDESC=%ATIBDESC%
call .\Bin64\ATIBINSetup.cmd
GOTO %BREAKSTATE%

:CHFLEXPVNGPUINST
CLS&SET INFNAME=%UNIFLEXPVNGPUINF%
SET INFPROFILE=_%INFSELTAR%_%INFSELVER%.inf
SET INFDEST=%UNIFLEXPVNGPUINF%.inf
SET ATICOMDESC=%ATIBDESC%
call .\Bin64\ATIBINSetupCopilot.cmd
GOTO %BREAKSTATE%

:CHRSTRACT
CLS&COLOR 0E
ECHO  ============================================================================================================
ECHO.
ECHO    Windows Restore Point Manager - System State Backup 
ECHO.
ECHO  ============================================================================================================
ECHO.
SET /P RESTORENAME=- Specify Restore Point Name or type M for Main Menu: 
IF NOT DEFINED RESTORENAME GOTO CHRSTRACT
IF %RESTORENAME%==m GOTO CHFIRSTRUN
IF %RESTORENAME%==M GOTO CHFIRSTRUN
POWERSHELL.EXE -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description '%RESTORENAME%' -RestorePointType 'MODIFY_SETTINGS'"
ECHO.

CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: Creating System Restore Point
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 2 0.0.0.0 > nul
GOTO CHFIRSTRUN

:CHDXSWITCH
.\Bin64\NzDXSwitch.htm
GOTO CHAMDDXGKRNL

:RIDTTCFGWUDRV
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 2F "  CONFIGURATION  " 0E 
ECHO   Driver Updates from Windows Update Server
ECHO.
ECHO   ITEM HELP:
ECHO   - Enable  : Enable this config will include drivers with Windows updates.
ECHO   - Disable : Disable this config will not include updates that have a Driver classification.
ECHO.
ECHO  ============================================================================================================
ECHO.
call .\Bin64\ATICMDMenu.exe 0FF1 "   [  Enable   ]" "   [  Disable  ]" "   [  Cancel   ]"
if /i "%Errorlevel%" == "1" (GOTO RIDTTCFGWUDRVENA)
if /i "%Errorlevel%" == "2" (GOTO RIDTTCFGWUDRVDISA)
if /i "%Errorlevel%" == "3" (GOTO CHFIRSTRUN)

:RIDTTCFGWUDRVENA
CLS&ECHO  ============================================================================================================
ECHO.
ECHO   DETAILS: 
ECHO   Configuring Policies to Enable Driver Updates from Windows Update
ECHO.
ECHO  ============================================================================================================
ECHO.
ECHO  - Stopping Process ...
%WINDIR%\SYSTEM32\NET.EXE stop bits /y > nul
%WINDIR%\SYSTEM32\NET.EXE stop wuauserv /y > nul
%WINDIR%\SYSTEM32\NET.EXE stop dosvc /y > nul
ECHO  - Setting Policies ...
%CENUMIMPORT% %ENUMSID%\WUEnable.dat > nul
ECHO  - Restarting Service ...
%WINDIR%\SYSTEM32\NET.EXE start bits /y > nul
%WINDIR%\SYSTEM32\NET.EXE start wuauserv /y > nul
%WINDIR%\SYSTEM32\NET.EXE start dosvc /y > nul

CLS
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
GOTO CHFIRSTRUN

:RIDTTCFGWUDRVDISA
CLS&ECHO  ============================================================================================================
ECHO.
ECHO   IN PROCESS: 
ECHO   Configuring Policies to Disable Driver Updates from Windows Update
ECHO.
ECHO  ============================================================================================================
ECHO.
ECHO  - Stopping Process ...
%WINDIR%\SYSTEM32\NET.EXE stop bits /y > nul
%WINDIR%\SYSTEM32\NET.EXE stop wuauserv /y > nul
%WINDIR%\SYSTEM32\NET.EXE stop dosvc /y > nul
ECHO  - Setting Policies ...
%CENUMIMPORT% %ENUMSID%\WUDisable.dat > nul
ECHO  - Restarting Service ...
%WINDIR%\SYSTEM32\NET.EXE start bits /y > nul
%WINDIR%\SYSTEM32\NET.EXE start wuauserv /y > nul
%WINDIR%\SYSTEM32\NET.EXE start dosvc /y > nul

CLS
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
GOTO CHFIRSTRUN

:BREAKSETUP
CLS&CALL %NIRCMD% killprocess %BGM% > nul
CLS&CALL %NIRCMD% killprocess CoInst.exe > nul
CLS&CALL %NIRCMD% killprocess AudioModule.exe > nul
CLS&CALL %NIRCMD% killprocess tasklist.exe > nul
CLS
GOTO BREAKEXIT

:BREAKSETUPREBOOT
CLS&CALL %NIRCMD% killprocess %BGM% > nul
CLS&CALL %NIRCMD% killprocess CoInst.exe > nul
CLS&CALL %NIRCMD% killprocess AudioModule.exe > nul
CLS&CALL %NIRCMD% killprocess tasklist.exe > nul
CLS&COLOR 0E
CLS&ECHO  ============================================================================================================
ECHO.
ECHO   ACTION: Exiting from Installation 
ECHO   APPLYING CONFIG AND RESTARTING YOUR SYSTEM ...
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul

CLS&COLOR 0F
ECHO.
ECHO  RdN.ID Installer Engine %CLIVER%
ECHO  Copyright 2014-2023 AMD Indonesia
ECHO.
%WINDIR%\SYSTEM32\SHUTDOWN.EXE /t 0 /r /f

:BREAKEXIT