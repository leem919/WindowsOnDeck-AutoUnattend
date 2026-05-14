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
SET ICALSACTMMPROF=UlpsLong&GOTO RIDTTUNICLS
:RIDTTUNICLS
CLS&call .\bin64\ATIVaxyCalsMM.cmd

:ENDCMD