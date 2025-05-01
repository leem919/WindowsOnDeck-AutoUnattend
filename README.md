# WindowsOnDeck-AutoUnattend
An answer file that handles initial setup and app debloating of Windows 11 on the LCD Steam Deck

This file will apply some system configurations that I personally believe improve windows on the steam deck. It also removes lots of apps from the Microsoft Store that I don't think most steam deck users will need. Though they can be redownloaded from the store if necessary. Finally, it runs a script that will download and install the drivers necessary for windows on the steam deck.

The xml file was generated using [Schneegans' Autounattend Generator](https://schneegans.de/windows/unattend-generator). If you would like to see exactly what is happening in the file, you can import it there and scroll through the configuration.
The AMD drivers were sourced from [Radeon-ID](https://sourceforge.net/projects/radeon-id-distribution/files/Release%20Polaris-Vega-Navi/Release%20AMD%20SoC/), as they are further up to date and provide fixes for issues that Valve's drivers have.
The Wi-Fi drivers were sourced from [ryanrudolfoba's SteamDeck-Windows-WiFi-Fix](https://github.com/ryanrudolfoba/SteamDeck-Windows-WiFi-Fix) for the deck optimizations.
The bluetooth, sd card, and audio drivers are sourced from Valve's official support page.

# How to use
After flashing a windows 11 installer to removable storage, place the `autounattend.xml` file in the root of it and continue with installing windows like normal.
