cd ../..
mkdir leem919_WoD
cd leem919_WoD

reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 0

curl -o bluetooth.zip https://steamdeck-packages.steamos.cloud/misc/windows/drivers/RTBlueR_FilterDriver_1041.3005_1201.2021_new_L.zip
tar -xf bluetooth.zip
del bluetooth.zip

curl -o sdcard.zip https://steamdeck-packages.steamos.cloud/misc/windows/drivers/BayHub_SD_STOR_installV3.4.01.89_W10W11_logoed_20220228.zip
tar -xf sdcard.zip
del sdcard.zip

curl -o sound1.zip https://steamdeck-packages.steamos.cloud/misc/windows/drivers/cs35l41-V1.2.1.0.zip
tar -xf sound1.zip
del sound1.zip

curl -o sound2.zip https://steamdeck-packages.steamos.cloud/misc/windows/drivers/NAU88L21_x64_1.0.6.0_WHQL%%20-%%20DUA_BIQ_WHQL.zip
tar -xf sound2.zip
del sound2.zip

curl -o wifi.zip https://codeload.github.com/ryanrudolfoba/SteamDeck-Windows-WiFi-Fix/zip/refs/heads/main
tar -xf wifi.zip
del wifi.zip
cd SteamDeck-Windows-WiFi-Fix-main
del Setup.bat
curl -o Setup.bat https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/Setup-wifi.bat
cd ..

mkdir amd
cd amd
curl -o 7zr.exe https://www.7-zip.org/a/7zr.exe
curl -L -o amd.7z https://sourceforge.net/projects/radeon-id-distribution/files/Release%20Polaris-Vega-Navi/Release%20AMD%20SoC/WHQL-AMD-Software-Hybrid-Edition-23.11.1-PVN-AMDSoC-Nebula-Native-DCH.7z/download
7zr x amd.7z
del amd.zip
cd Bin64
del ATIBINSetup.cmd ATICMDPX.cmd ATICMDQC.cmd ATICMDRSB.cmd ATICMDRSProf.cmd ATICMDULPS.cmd ATIVaxyPanel.cmd SetupBIN.cmd /q
curl -o ATIBINSetup.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATIBINSetup.cmd
curl -o ATICMDPX.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATICMDPX.cmd
curl -o ATICMDQC.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATICMDQC.cmd
curl -o ATICMDRSB.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATICMDRSB.cmd
curl -o ATICMDRSProf.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATICMDRSProf.cmd
curl -o ATICMDULPS.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATICMDULPS.cmd
curl -o ATIVaxyPanel.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/ATIVaxyPanel.cmd
curl -o SetupBIN.cmd https://raw.githubusercontent.com/leem919/WindowsOnDeck-AutoUnattend/refs/heads/main/changedscripts/SetupBIN.cmd
cd ../..

curl -o SteamSetup.exe https://cdn.fastly.steamstatic.com/client/installer/SteamSetup.exe


cd BayHub_SD_STOR_ installV3.4.01.89_W10W11_logoed_20220228
setup.exe /S
cd ..

cd cs35l41-V1.2.1.0
pnputil -i -a cs35l41.inf
cd ..

cd NAU88L21_x64_1.0.6.0_WHQL - DUA_BIQ_WHQL
pnputil -i -a NAU88L21.inf
cd ..

cd amd
SetupCLI.exe
cd ..

cd SteamDeck-Windows-WiFi-Fix-main
start Setup.bat
cd ..

SteamSetup.exe /S

cd RTBlueR_FilterDriver_1041.3005_1201.2021_new_L
InstallDriver.cmd
cd ..
