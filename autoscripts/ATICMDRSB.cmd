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
GOTO AskRSBAdr

:ASKRSBAdr
SET EXERSB=AMDDRSServ_Adr
GOTO ASKRSBEXEC

:ASKRSBPro
SET EXERSB=AMDDRSServ_Pro
GOTO ASKRSBEXEC

:ASKRSBCtr
SET EXERSB=AMDDRSServ_Ctr
GOTO ASKRSBEXEC

:ASKRSBGen
SET EXERSB=AMDDRSServ_Gen
GOTO ASKRSBEXEC

:ASKRSBGen
SET EXERSB=AMDDRSServ_Cld
GOTO ASKRSBEXEC

:ASKRSBEXEC
%CENUMQUERY% %ENUM_0000% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSBEXEC0000found
if %ERRORLEVEL% EQU 1 GOTO ASKRSBEXEC0001
:ASKRSBEXEC0000found
CLS
%CENUMIMPORT% %ENUMSID%\%EXERSB%_0000.dat > nul
CLS

:ASKRSBEXEC0001
%CENUMQUERY% %ENUM_0001% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSBEXEC0001found
if %ERRORLEVEL% EQU 1 GOTO ASKRSBEXEC0002
:ASKRSBEXEC0001found
CLS
%CENUMIMPORT% %ENUMSID%\%EXERSB%_0001.dat > nul
CLS

:ASKRSBEXEC0002
%CENUMQUERY% %ENUM_0002% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSBEXEC0002found
if %ERRORLEVEL% EQU 1 GOTO ASKRSBEXEC0003
:ASKRSBEXEC0002found
CLS
%CENUMIMPORT% %ENUMSID%\%EXERSB%_0002.dat > nul
CLS

:ASKRSBEXEC0003
%CENUMQUERY% %ENUM_0003% /v %RADVWMIC% > nul
if %ERRORLEVEL% EQU 0 GOTO ASKRSBEXEC0003found
if %ERRORLEVEL% EQU 1 GOTO ENDCMD
:ASKRSBEXEC0003found
CLS
%CENUMIMPORT% %ENUMSID%\%EXERSB%_0003.dat > nul
CLS

:ENDCMD
CLS
%NIRCMD% killprocess amddow.exe > nul
CLS
%NIRCMD% killprocess AMDRSServ.exe > nul
CLS
%NIRCMD% killprocess AMDRSSrcExt.exe > nul
CLS
%NIRCMD% killprocess RadeonSoftware.exe > nul
CLS