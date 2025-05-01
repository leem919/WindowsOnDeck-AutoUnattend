@echo off

set AMDLOC=HKCU\SOFTWARE\AMD\CN
set AMDMAN=HKLM\SOFTWARE\AMD\CN

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

:AMDADRUI
CLS&CALL .\bin64\ATILibAcals.cmd
CLS&CALL .\bin64\ATILibScals.cmd
GOTO %ZCALSMN%

:AMDADRUIHOME
CLS&
set GITCCC2330=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.5/ccc2_install_v5.5_23.30.exe
set GITCCC2320=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.5/ccc2_install_v5.5_23.20.exe
set GITCCC2310=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.5/ccc2_install_v5.5_23.10.exe
set GITCCC2240=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.0/ccc2_install_v5.0_22.40.exe
set GITCCC2220=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.0/ccc2_install_v5.0_22.20.exe
set GITCCC2210=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.0/ccc2_install_v5.0_22.10.exe
set GITCCC2150=https://onboardcloud.dl.sourceforge.net/project/amernimezone/Dependencies/V5.0/ccc2_install_v5.0_21.50.exe
set GIT2330EXE=ccc2_install_v5.5_23.30.exe
set GIT2320EXE=ccc2_install_v5.5_23.20.exe
set GIT2310EXE=ccc2_install_v5.5_23.10.exe
set GIT2240EXE=ccc2_install_v5.0_22.40.exe
set GIT2220EXE=ccc2_install_v5.0_22.20.exe
set GIT2210EXE=ccc2_install_v5.0_22.10.exe
set GIT2150EXE=ccc2_install_v5.0_21.50.exe
COLOR 0F
CLS&ECHO  ============================================================================================================
SET GETVAXYREQ=BREAKSETUP&GOTO BREAKPOINT
GOTO AMDADRUIHOME

:AMDADRUIGPENDFUNC
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 2F "  CONFIGURATION  " 0E 
ECHO   Radeon Game Profile Endpoint Function
ECHO.
ECHO   - Auto    : Decide by Driver                            
ECHO   - Enabled : Enable Radeon Game Profile Endpoint         
ECHO   - ASIC 1  : Radeon Game Profile Endpoint ASIC Mode 1    ( default for Polaris and Vega    )
ECHO   - ASIC 2  : Radeon Game Profile Endpoint ASIC Mode 2    ( default for Raphael and Phoenix )
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Auto      ]" "   [  Enabled   ]" "   [  ASIC 1    ]" "   [  ASIC 2    ]" "   [  Cancel    ]"
if /i "%Errorlevel%" == "1" (SET ICALSACTMMPROF=RSEndpointFuncClr&SET COMPMESSAGE=Radeon Game Profile Endpoint Function Auto&GOTO RSENDFUNCACT)
if /i "%Errorlevel%" == "2" (SET ICALSACTMMPROF=RSEndpointFuncOn&SET COMPMESSAGE=Radeon Game Profile Endpoint Function Enabled&GOTO RSENDFUNCACT)
if /i "%Errorlevel%" == "3" (SET ICALSACTMMPROF=RSEndpointFuncASC1&SET COMPMESSAGE=Radeon Game Profile Endpoint Function ASIC 1&GOTO RSENDFUNCACT)
if /i "%Errorlevel%" == "4" (SET ICALSACTMMPROF=RSEndpointFuncASC2&SET COMPMESSAGE=Radeon Game Profile Endpoint Function ASIC 2&GOTO RSENDFUNCACT)
if /i "%Errorlevel%" == "5" (GOTO AMDADRUI)

:RSENDFUNCACT
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
GOTO RSENDFUNCCOMPLETED

:RSENDFUNCCOMPLETED
CLS&CALL %NIRCMD% killprocess amddow.exe > nul
CLS&CALL %NIRCMD% killprocess cncmd.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSServ.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSSrcExt.exe > nul
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: %COMPMESSAGE%
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:AMDADRUIGPEND
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 2F "  CONFIGURATION  " 0E 
ECHO   Radeon Game Profile Endpoint CAPS Mode
ECHO.
ECHO   - Auto   : Let's driver configure itself, Default for Polaris and Vega based Arch
ECHO   - Mode 1 : ConfigSupport CAPS, default for RDNA/NAVI based Arch
ECHO   - Mode 2 : ConfigSupport and AppProfileSupport CAPS
ECHO   - Mode 3 : ConfigSupport + AppProfileSupport + and ManagerSupport CAPS
ECHO.
ECHO   RSR* : require GPU Architecture Support
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Auto     ]" "   [  Mode 1   ]" "   [  Mode 2   ]" "   [  Mode 3   ]" "   [  Cancel   ]"
if /i "%Errorlevel%" == "1" (SET ICALSACTMMPROF=RSEndpointClr&SET COMPMESSAGE=Radeon Game Profile Endpoint Caps AUTO&GOTO RSENDACT)
if /i "%Errorlevel%" == "2" (SET ICALSACTMMPROF=RSEndpointMD1&SET COMPMESSAGE=Radeon Game Profile Endpoint Caps Mode 1&GOTO RSENDACT)
if /i "%Errorlevel%" == "3" (SET ICALSACTMMPROF=RSEndpointMD2&SET COMPMESSAGE=Radeon Game Profile Endpoint Caps Mode 2&GOTO RSENDACT)
if /i "%Errorlevel%" == "4" (SET ICALSACTMMPROF=RSEndpointMD3&SET COMPMESSAGE=Radeon Game Profile Endpoint Caps Mode 3&GOTO RSENDACT)
if /i "%Errorlevel%" == "5" (GOTO AMDADRUI)

:RSENDACT
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
GOTO RSENDCOMPLETED

:RSENDCOMPLETED
CLS&CALL %NIRCMD% killprocess amddow.exe > nul
CLS&CALL %NIRCMD% killprocess cncmd.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSServ.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSSrcExt.exe > nul
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: %COMPMESSAGE%
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:AMDADRUISPOSEL
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 2F "  CONFIGURATION  " 0E 
ECHO   AMD Radeon Software HYPR-RX Overrider
ECHO.
ECHO   RADEON SOFTWARE BASIC PROFILE   ( activate toggle only )
ECHO   - HYPR-RX MODE 1             : Toggle Chill, AntiLag, FRTC Pro, RIS, RSR*
ECHO   - HYPR-RX MODE 2             : Toggle Chill, AntiLag, FRTC Pro, Scaling, RIS, RSR*
ECHO.
ECHO   RADEON SOFTWARE CUSTOM PROFILE  ( override slider config )
ECHO   - CUST HYPR-RX ECO POWER 1   : Chill 30fps    , AntiLag, FRTC Pro, 83%% Scaling, 10%% RIS, RSR*
ECHO   - CUST HYPR-RX ECO POWER 2   : Chill 30-45fps , AntiLag, FRTC Pro, 83%% Scaling, 10%% RIS, RSR*
ECHO   - CUST HYPR-RX BALANCED      : Chill 30-60fps , AntiLag, FRTC Pro, 83%% Scaling, 10%% RIS, RSR*
ECHO   - CUST HYPR-RX ECO GAMING 1  : Chill 60-75fps , AntiLag, FRTC Pro, 83%% Scaling, 20%% RIS, RSR*
ECHO   - CUST HYPR-RX ECO GAMING 2  : Chill 75-90fps , AntiLag, FRTC Pro, 67%% Scaling, 20%% RIS, RSR*
ECHO   - CUST HYPR-RX ESPORT GAMING : Uncapped, AntiLag, 67%% Scaling, 20%% RIS, RSR*
ECHO.
ECHO   RSR* : require GPU Architecture Support
ECHO   NOTE : Please configure Radeon Chill and Frame Rate Target Control slider manually after applying
ECHO          HYPR-RX MODE 1 or 2
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  HYPR-RX MODE 1      ]" "   [  HYPR-RX MODE 2      ]" "   [  CUST ECO POWER 1    ]" "   [  CUST ECO POWER 2    ]" "   [  CUST BALANCED       ]" "   [  CUST ECO GAMING 1   ]" "   [  CUST ECO GAMING 2   ]" "   [  CUST ESPORT GAMING  ]" "   [  CANCEL              ]"
if /i "%Errorlevel%" == "1" (GOTO HYPRMD1)
if /i "%Errorlevel%" == "2" (GOTO HYPRMD2)
if /i "%Errorlevel%" == "3" (GOTO CHYPRECO1)
if /i "%Errorlevel%" == "4" (GOTO CHYPRECO2)
if /i "%Errorlevel%" == "5" (GOTO CHYPRMED)
if /i "%Errorlevel%" == "6" (GOTO CHYPRGAME1)
if /i "%Errorlevel%" == "7" (GOTO CHYPRGAME2)
if /i "%Errorlevel%" == "8" (GOTO CHYPRESPORT)
if /i "%Errorlevel%" == "9" (GOTO AMDADRUI)

:HYPRMD1
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOff
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=HYPR-RX MODE 1 - Please configure Radeon Chill and Frame Rate Target Control Slider manually after this
GOTO HYRXCOMPLETED

:HYPRMD2
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=HYPR-RX MODE 2 - Please configure Radeon Chill and Frame Rate Target Control Slider manually after this
GOTO HYRXCOMPLETED

:CHYPRECO1
REM == Capped 30 == Ticked ==
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync83
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen10
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=CUST HYPR-RX ECO MODE 1
GOTO HYRXCOMPLETED

:CHYPRECO2
REM == Min 30 == Max 45 == Ticked ==
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst2
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync83
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen10
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst2
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst2
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=CUST HYPR-RX ECO MODE 2
GOTO HYRXCOMPLETED

:CHYPRMED
REM == Min 30 == Max 60 == Ticked ==
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst1
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst3
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync83
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen10
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst3
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst3
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=CUST HYPR-RX BALANCED
GOTO HYRXCOMPLETED

:CHYPRGAME1
REM == Min 60 == Max 75 == Ticked ==
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst3
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst4
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync67
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen20
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOff
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst4
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst4
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=CUST HYPR-RX ECO GAMING 1
GOTO HYRXCOMPLETED

:CHYPRGAME2
REM == Min 75 == Max 90 == Ticked ==
SET ICALSACTMMPROF=RadeonChillFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst4
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst5
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync67
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen20
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOff
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst5
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst5
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=CUST HYPR-RX ECO GAMING 2
GOTO HYRXCOMPLETED

:CHYPRESPORT
REM == Min 144 == Max 144 == Unticked ===
SET ICALSACTMMPROF=RadeonChillFuncOff
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMinPst7
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RadeonChillMaxPst7
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=DeLagOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDyncFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdDync67
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpenFuncOn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RdSharpen20
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCFuncOff
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCProPst7
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=FRTCPst7
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET ICALSACTMMPROF=RSROn
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
SET COMPMESSAGE=HYPR-RX CUST ESPORT GAMING 
GOTO HYRXCOMPLETED

:HYRXCOMPLETED
ECHO Disabling GPU ...
START /b %NIRCMD% mediaplay 2500 "%SNDDEVDIS%"
set atihwid_r300_plus=.\Bin64\devcon.exe disable "PCI\VEN_1002
CALL .\bin64\ATIHWID_R300_plus.cmd 
set atihwid_r300_legacy=.\Bin64\devcon.exe disable "PCI\VEN_1002
CALL .\bin64\ATIHWID_R300_Legacy.cmd
ECHO Re-Enable GPU ...
START /b %NIRCMD% mediaplay 2500 "%SNDDEVINS%"
set atihwid_r300_plus=.\Bin64\devcon.exe enable "PCI\VEN_1002
CALL .\bin64\ATIHWID_R300_plus.cmd 
set atihwid_r300_legacy=.\Bin64\devcon.exe enable "PCI\VEN_1002
CALL .\bin64\ATIHWID_R300_Legacy.cmd
CLS

CLS&CALL %NIRCMD% killprocess amddow.exe > nul
CLS&CALL %NIRCMD% killprocess cncmd.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSServ.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSSrcExt.exe > nul
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   %COMPMESSAGE%
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:ONAMDADRUI_UWP
COLOR 0F
CLS&ECHO  ============================================================================================================
ECHO.
ECHO   ### AMD Radeon Software Interface UWP MS Store Configuration
ECHO.
ECHO      [1] Disable AMD UWP Handler
ECHO          Disable AMD UWP Handler if you want to use Standard AMD UI Dependencies
ECHO.
ECHO      [2] Enable AMD UWP Handler
ECHO          Enable AMD UWP Handler if you want to use AMD UI MS Store Edition
ECHO.
ECHO.     [3] Select AMD UWPPair Version
ECHO      [4] Download AMD Radeon Software MS Store Edition
ECHO.
ECHO  ============================================================================================================
ECHO   [B] BACK                                 
ECHO  ============================================================================================================
ECHO.
SET /P AMDUWP=- Insert the option above and press ENTER: 
ECHO.
IF NOT DEFINED AMDUWP GOTO ONAMDADRUI_UWP
IF %AMDUWP%==1 GOTO ONAMDADRUIUWPDISA
IF %AMDUWP%==2 GOTO ONAMDADRUIUWPENA
IF %AMDUWP%==3 GOTO ONAMDADRUIUWPSEL
IF %AMDUWP%==4 GOTO ONAMDADRUIDOWN
IF %AMDUWP%==x GOTO BREAKSETUP
IF %AMDUWP%==X GOTO BREAKSETUP
IF %AMDUWP%==b GOTO AMDADRUI
IF %AMDUWP%==B GOTO AMDADRUI
GOTO ONAMDADRUI_UWP

:ONAMDADRUIUWPSEL
COPY .\MultiParse\sdi_uwp.cfg .\sdi.cfg /Y > nul
call .\Packages\sdi.exe > %UserName%-SnappyLogs-%date:~0,2%%date:~3,2%%date:~8,2%-UWPPair.txt
GOTO ONAMDADRUI_UWP

:ONAMDADRUIUWPDISA
CLS&CALL .\bin64\devcon.exe disable "SWC\VID1002&PID0001" > nul
REM CLS&%WMICREM% "SWD\DEVGEN\AMDUWP" > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: Disable AMD UWP Handler
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 3 0.0.0.0 > nul
GOTO ONAMDADRUI_UWP

:ONAMDADRUIUWPENA
CLS&%WMICADD% "AMDUWP" /hardwareid "SWC\VID1002&PID0001" > NUL
CLS&CALL .\bin64\devcon.exe enable "SWC\VID1002&PID0001" > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: Enable AMD UWP Handler
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 3 0.0.0.0 > nul
GOTO ONAMDADRUI_UWP

:ONAMDADRUIDOWN
CLS
start https://apps.microsoft.com/store/detail/amd-radeon-software/9NZ1BJQN6BHL
GOTO ONAMDADRUI_UWP

:AMDADRUIBRANDING
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 2F "  CONFIGURATION  " 0E 
ECHO       AMD Radeon Software Branding Configuration
ECHO.
ECHO   ITEM HELP:
ECHO   - Adrenalin    : Red Accent   / AMD Radeon Software Adrenalin Edition
ECHO   - Enteprise    : Blue Accent  / AMD Radeon Software Enterprise Edition
ECHO   - Creator      : Blue Accent  / AMD Radeon Software Creator Edition
ECHO   - Radeon Lite  : Blue Accent  / AMD Radeon Software Minimal Edition
ECHO   - Cloud Lite   : White Accent / AMD Radeon Software Cloud Edition
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Adrenalin     ]" "   [  Enterprise    ]" "   [  Creator       ]" "   [  Radeon Lite   ]" "   [  Cloud Lite    ]" "   [  Cancel        ]"
if /i "%Errorlevel%" == "1" (SET ICALSACTMMPROF=AMDDRSServ_Adr&SET COMPMESSAGE=Red Accent  / AMD Radeon Software Adrenalin Edition&GOTO RSBAct)
if /i "%Errorlevel%" == "2" (SET ICALSACTMMPROF=AMDDRSServ_Pro&SET COMPMESSAGE=Blue Accent / AMD Radeon Software Enterprise Edition&GOTO RSBAct)
if /i "%Errorlevel%" == "3" (SET ICALSACTMMPROF=AMDDRSServ_Ctr&SET COMPMESSAGE=Blue Accent / AMD Radeon Software Creator Edition&GOTO RSBAct)
if /i "%Errorlevel%" == "4" (SET ICALSACTMMPROF=AMDDRSServ_Gen&SET COMPMESSAGE=Blue Accent / AMD Radeon Software Lite - Minimal Edition&GOTO RSBAct)
if /i "%Errorlevel%" == "5" (SET ICALSACTMMPROF=AMDDRSServ_Cld&SET COMPMESSAGE=White Accent / AMD Radeon Software Cloud - Minimal Edition&GOTO RSBAct)
if /i "%Errorlevel%" == "6" (GOTO AMDADRUI)

:RSBAct
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
GOTO RSBEXECCompleted

:RSBEXECCompleted
CLS&CALL %NIRCMD% killprocess amddow.exe > nul
CLS&CALL %NIRCMD% killprocess cncmd.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSServ.exe > nul
CLS&CALL %NIRCMD% killprocess AMDRSSrcExt.exe > nul
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: %COMPMESSAGE%
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:AMDADRUIPROFILE
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
ECHO   ### Select Radeon UI Profile
ECHO.
ECHO   Lite     : Minimal Radeon Software Features
ECHO   Basic    : Radeon Overlay and HotKey Only
ECHO   Standard : Standard Radeon Software Feature, required for AMD GPU Tuning
ECHO   Advanced : Additional Radeon Software Feature
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Minimal   ]" "   [  Basic     ]" "   [  Standard  ]" "   [  Advanced  ]" "   [  Cancel    ]"
if /i "%Errorlevel%" == "1" (SET EXEMDL=AMDDRSExt_Lite&SET COMPMESSAGE=Minimal Radeon Software Features&GOTO RSPROFACT)
if /i "%Errorlevel%" == "2" (SET EXEMDL=AMDDRSExt_Basic&SET COMPMESSAGE=Radeon Overlay and HotKey Only&GOTO RSPROFACT)
if /i "%Errorlevel%" == "3" (SET EXEMDL=AMDDRSExt_Regular&SET COMPMESSAGE=Standard Radeon Software Feature, required for AMD GPU Tuning&GOTO RSPROFACT)
if /i "%Errorlevel%" == "4" (SET EXEMDL=AMDDRSExt_Advanced&SET COMPMESSAGE=Additional Radeon Software Feature&GOTO RSPROFACT)
if /i "%Errorlevel%" == "5" (GOTO AMDADRUI)

:RSPROFACT
CLS&CALL .\bin64\ATIVaxyCalsMM.cmd
GOTO RSPROFEXECCompleted

:RSPROFEXECCompleted
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   COMPLETED: %COMPMESSAGE%
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDPOPUP%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:NOINTERNET_CCCUNIV
CLS&COLOR 0F
ECHO  ============================================================================================================
ECHO.
ECHO   HYBRID MODE DEPENDENCIES FILE HANDLER
ECHO   - Dependencies %ADLBASE% / %ADLVER%
ECHO.
ECHO  ============================================================================================================
ECHO.
ECHO Checking local %GITDIR%\%GITEXE% availiblity ...
mkdir %SYSTEMDRIVE%\AMD\ > nul
ping.exe amd.com -n 3 > nul
if exist "%GITDIR%\%GITEXE%" (GOTO CHECKCCC_CCCUNIV)

:INTERNET_CCCUNIV
ECHO Local file not found, checking for internet connection ...
ping.exe amd.com -n 3 > nul
if errorlevel 1 (goto PINGFAIL_CCCUNIV)
if errorlevel 0 (goto PINGDONE_CCCUNIV)

:PINGFAIL_CCCUNIV
if not exist "%GITDIR%\%GITEXE%" (GOTO PINGDONE_MANUAL)

:PINGDONE_CCCUNIV
ECHO Internet connection available.
ECHO.
ECHO  Select downloading dependencies method :
ECHO  - Auto   : Automatic mode, downloading through CLI
ECHO  - Manual : Manual mode, downloading using browser, useful for slow connection
ECHO             Alternative if automatic mode fails.
ECho.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Auto    ]" "   [  Manual  ]" "   [  Cancel  ]"
if /i "%Errorlevel%" == "1" (GOTO PINGDONE_AUTO)
if /i "%Errorlevel%" == "2" (START %GITOND%&GOTO PINGDONE_MANUAL)
if /i "%Errorlevel%" == "3" (GOTO AMDADRUI)

:PINGDONE_AUTO
ECHO.
curl %GITOND% -o %GITDIR%\%GITEXE%
CLS
mkdir %SYSTEMDRIVE%\AMD
rmdir %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install /s /q
mkdir %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install
REM .\Bin64\7z.exe x %GITDIR%\%GITEXE% -o%SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install -aoa
REM DEL %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\Support64\CCC2App64.exe /s /f /q
REM MKDIR %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\Support64\CCC2App64.exe
CLS
%GITDIR%\%GITEXE%
CLS&CALL %NIRCMD% killprocess CCC2App64.exe > nul
%CENUMDEL% %AMDLOC% /v CNVersion /f
%CENUMDEL% %AMDMAN% /v CNVersion /f
%CENUMDEL% %AMDLOC% /v DriverVersion /f
%CENUMDEL% %AMDMAN% /v DriverVersion /f
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS
GOTO AMDADRUI

:PINGDONE_MANUAL
CLS&COLOR 0F
CLS
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
ECHO  ============================================================================================================
ECHO.
ECHO   ### Dependencies %ADLBASE% / %ADLVER%
ECHO.
ECHO   Place AMD Adrenalin UI Installation (%GITEXE%) on %GITDIR%
ECHO.
ECHO   HINTS: You can re-use previous downloadeded (%GITEXE%) matching prereq in SourceForge
ECHO.
ECHO  ============================================================================================================
ECHO.
ECHO   Press any key to try again or place manually %GITEXE% in %GITDIR% folder ...
PAUSE > nul

:CHECKCCC_CCCUNIV
if not exist "%GITDIR%\%GITEXE%" (GOTO NOCCC_CCCUNIV)
CLS
mkdir %SYSTEMDRIVE%\AMD
rmdir %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install /s /q
mkdir %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install
REM .\Bin64\7z.exe x %GITDIR%\%GITEXE% -o%SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install -aoa
REM DEL %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\Support64\CCC2App64.exe /s /f /q
REM MKDIR %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\Support64\CCC2App64.exe
CLS
%GITDIR%\%GITEXE%
CLS&CALL %NIRCMD% killprocess CCC2App64.exe > nul
%CENUMDEL% %AMDLOC% /v CNVersion /f
%CENUMDEL% %AMDMAN% /v CNVersion /f
%CENUMDEL% %AMDLOC% /v DriverVersion /f
%CENUMDEL% %AMDMAN% /v DriverVersion /f
CLS&CALL %NIRCMD% killprocess RadeonSoftware.exe > nul
CLS
GOTO AMDADRUI

:NOCCC_CCCUNIV
CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDALERT%"
ECHO  ============================================================================================================
ECHO.
ECHO   ### Dependencies %ADLBASE% / %ADLVER%
ECHO.
ECHO       "%GITEXE%" was not found. Press re-download or place it manually in
ECHO       %GITDIR% if you have it.
ECHO.
ECHO  ============================================================================================================
ECHO.
CALL .\bin64\ATICMDMenu.exe 0FF1 "   [  Try Again    ]" "   [  Re-Download  ]" "   [  Abort        ]"
if /i "%Errorlevel%" == "1" (GOTO CHECKCCC_CCCUNIV)
if /i "%Errorlevel%" == "2" (GOTO NOINTERNET_CCCUNIV)
if /i "%Errorlevel%" == "3" (GOTO AMDADRUI)

:CHAMDADRUI
CLS&if exist "%PROGRAMFILES%\AMD\CNext\CNext\RadeonSoftware.exe" (GOTO AMDCLASSICUI)
GOTO NOTCLASSICUI

:AMDCLASSICUI
COLOR 0F
CLS&ECHO  ============================================================================================================
ECHO.
ECHO    ### Re-Live VR requires Re-Live DVR Installed
ECHO.
ECHO    ### To Remove completely AMD Radeon Software UI, use Control Panel or Program and Features,
ECHO        select AMD Settings in Program List then Uninstall
ECHO.
ECHO    AMD Radeon Software Interface Component 
ECHO.
ECHO    [1] Add AMD Re-Live DVR Addon
ECHO    [2] Add AMD Re-Live DVR with VR-Addon
ECHO.
ECHO    [3] Remove AMD Re-Live DVR Addon
ECHO    [4] Remove AMD Re-Live VR-Addon
ECHO    [5] Remove AMD Radeon Software Interface
ECHO.
ECHO  ============================================================================================================
ECHO    [B] BACK                             
ECHO  ============================================================================================================
ECHO.

SET /P AMDUICOM=- Insert the option above and press ENTER: 
IF NOT DEFINED AMDUICOM GOTO CHAMDADRUI
IF %AMDUICOM%==1 GOTO InstAddonLive
IF %AMDUICOM%==2 GOTO InstAddonUIVR
IF %AMDUICOM%==3 GOTO RemoAddonUILive
IF %AMDUICOM%==4 GOTO RemoAddonUILiveVR
IF %AMDUICOM%==5 GOTO RemoAdrUI
IF %AMDUICOM%==b GOTO AMDADRUI
IF %AMDUICOM%==B GOTO AMDADRUI
GOTO CHAMDADRUI

:InstAddonLive
CLS&ECHO.
ECHO  Adding AMD Re-Live DVR Addon...
%WINDIR%\SYSTEM32\MSIEXEC.EXE LAUNCHED_FROM_CIM=1 /i %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\CN\amddvr\amddvr64\amddvr64.msi
CLS
%CENUMIMPORT% %ENUMSID%\StubRegularDVRRadeon.dat > nul
CLS
%CENUMIMPORT% %ENUMSID%\StubANR.dat > nul

:InstAddonLive0000
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonLive0000found
if %ERRORLEVEL% EQU 1 GOTO InstAddonLive0001
:InstAddonLive0000found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0000.dat > nul
CLS

:InstAddonLive0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonLive0001found
if %ERRORLEVEL% EQU 1 GOTO InstAddonLive0002
:InstAddonLive0001found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0001.dat > nul
CLS

:InstAddonLive0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonLive0002found
if %ERRORLEVEL% EQU 1 GOTO InstAddonLive0003
:InstAddonLive0002found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0002.dat > nul
CLS

:InstAddonLive0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonLive0003found
if %ERRORLEVEL% EQU 1 GOTO InstAddonLiveFinish
:InstAddonLive0003found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0003.dat > nul
CLS

:InstAddonLiveFinish
GOTO CHAMDADRUI

:InstAddonUIVR
CLS&ECHO.
ECHO  Adding AMD Re-Live VR Addon...
%WINDIR%\SYSTEM32\MSIEXEC.EXE LAUNCHED_FROM_CIM=1 /i %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\CN\wvr64\WVR64.msi
CLS
%CENUMIMPORT% %ENUMSID%\StubRegularDVRRadeon.dat > nul
CLS
%CENUMIMPORT% %ENUMSID%\StubANR.dat > nul

:InstAddonUIVR0000
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonUIVR0000found
if %ERRORLEVEL% EQU 1 GOTO InstAddonUIVR0001
:InstAddonUIVR0000found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0000.dat > nul
CLS

:InstAddonUIVR0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonUIVR0001found
if %ERRORLEVEL% EQU 1 GOTO InstAddonUIVR0002
:InstAddonUIVR0001found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0001.dat > nul
CLS

:InstAddonUIVR0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonUIVR0002found
if %ERRORLEVEL% EQU 1 GOTO InstAddonUIVR0003
:InstAddonUIVR0002found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0002.dat > nul
CLS

:InstAddonUIVR0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO InstAddonUIVR0003found
if %ERRORLEVEL% EQU 1 GOTO InstAddonUIVRFinish
:InstAddonUIVR0003found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOn_0003.dat > nul
CLS

:InstAddonUIVRFinish
GOTO CHAMDADRUI

:RemoAddonUILive
CLS&ECHO.
ECHO  Remove AMD Relive DVR addon...
%WINDIR%\SYSTEM32\MSIEXEC.EXE /uninstall %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\CN\amddvr\amddvr64\amddvr64.msi
CLS
%CENUMIMPORT% %ENUMSID%\StubRegularNonDVRRadeon.dat > nul
CLS
%CENUMIMPORT% %ENUMSID%\StubANR.dat > nul

:RemoAddonUILive0000
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO RemoAddonUILive0000found
if %ERRORLEVEL% EQU 1 GOTO RemoAddonUILive0001
:RemoAddonUILive0000found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOff_0000.dat > nul
CLS

:RemoAddonUILive0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO RemoAddonUILive0001found
if %ERRORLEVEL% EQU 1 GOTO RemoAddonUILive0002
:RemoAddonUILive0001found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOff_0001.dat > nul
CLS

:RemoAddonUILive0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO RemoAddonUILive0002found
if %ERRORLEVEL% EQU 1 GOTO RemoAddonUILive0003
:RemoAddonUILive0002found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOff_0002.dat > nul
CLS

:RemoAddonUILive0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO RemoAddonUILive0003found
if %ERRORLEVEL% EQU 1 GOTO RemoAddonUILiveFinish
:RemoAddonUILive0003found
CLS
%CENUMIMPORT% %ENUMSID%\StubCLSIDOff_0003.dat > nul
CLS

:RemoAddonUILiveFinish
GOTO CHAMDADRUI

:RemoAddonUILiveVR
CLS&ECHO.
ECHO  Remove AMD Relive VR addon...
%WINDIR%\SYSTEM32\MSIEXEC.EXE /uninstall %SYSTEMDRIVE%\AMD\WU-CCC2\ccc2_install\CN\wvr64\WVR64.msi
CLS
%CENUMIMPORT% %ENUMSID%\StubRegularNonDVRRadeon.dat > nul
CLS
%CENUMIMPORT% %ENUMSID%\StubANR.dat > nul
GOTO CHAMDADRUI

:RemoAdrUI
CLS
appwiz.cpl
GOTO CHAMDADRUI

:UICALSUNKNOWN
CLS&COLOR 0E
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 0F " " 4F "  !!! FATAL ERROR !!!  " 0E "
ECHO        RDN-ID DRIVER PACKAGE NOT DETECTED OR INSTALLED PROPERLY
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDALERT%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO BREAKPOINT

:NOTCLASSICUI
CLS&COLOR 0E
ECHO  ============================================================================================================
ECHO.
%COCOLOR% 0F " " 4F "  !!! FATAL ERROR !!!  " 0E "
ECHO        CLASSIC CCC PACKAGE WERE NOT INSTALLED OR YOU'RE USING WINDOWS STORE APPS VERSION
ECHO.
ECHO  ============================================================================================================
START /b %NIRCMD% mediaplay 2500 "%SNDALERT%"
call %WINDIR%\SYSTEM32\PING.EXE -n 4 0.0.0.0 > nul
GOTO AMDADRUI

:BREAKPOINT