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

CLS&COLOR 0E
START /b %NIRCMD% mediaplay 2500 "%SNDASK%"
GOTO ASKRSPROFRegular

:ASKRSPROFMinimal
SET EXEPROF=AMDDRSExt_Lite
GOTO ASKRSPROFEXEC

:ASKRSPROFBasic
SET EXEPROF=AMDDRSExt_Basic
GOTO ASKRSPROFEXEC

:ASKRSPROFRegular
SET EXEPROF=AMDDRSExt_Regular
GOTO ASKRSPROFEXEC

:ASKRSPROFAdvanced
SET EXEPROF=AMDDRSExt_Advanced
GOTO ASKRSPROFEXEC

:ASKRSPROFEXEC
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSPROFEXEC0000found
if %ERRORLEVEL% EQU 1 GOTO ASKRSPROFEXEC0001
:ASKRSPROFEXEC0000found
CLS
%CENUMIMPORT% %ENUMSID%\%EXEPROF%_0000.dat > nul
CLS

:ASKRSPROFEXEC0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSPROFEXEC0001found
if %ERRORLEVEL% EQU 1 GOTO ASKRSPROFEXEC0002
:ASKRSPROFEXEC0001found
CLS
%CENUMIMPORT% %ENUMSID%\%EXEPROF%_0001.dat > nul
CLS

:ASKRSPROFEXEC0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSPROFEXEC0002found
if %ERRORLEVEL% EQU 1 GOTO ASKRSPROFEXEC0003
:ASKRSPROFEXEC0002found
CLS
%CENUMIMPORT% %ENUMSID%\%EXEPROF%_0002.dat > nul
CLS

:ASKRSPROFEXEC0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSPROFEXEC0003found
if %ERRORLEVEL% EQU 1 GOTO ENDCMD
:ASKRSPROFEXEC0003found
CLS
%CENUMIMPORT% %ENUMSID%\%EXEPROF%_0003.dat > nul
CLS

:ENDCMD
CLS