# qb-lapdance [![Release](https://img.shields.io/badge/Release-V%201.0-blue)](https://github.com/clementinise/qb-lapdance/releases/latest)

Lapdance resource for the Unicorn strip club - https://forum.cfx.re/t/qbcore-free-unicorn-lap-dance-qb-lapdance-v1-0/4769570

## FEATURES
* Strip-Club Blip & Lap Dance Marker at the Unicorn
* Update Checker on resource start
* Run under 0.01ms on idle and 0.03ms when in lap dance (Max reach was 0.07ms)
* Stripper animation from [esx_lapdance](https://github.com/Loffes/esx_lapdance) by [Loffes](https://forum.cfx.re/u/Loffes)
* Players need to wait that a lap dance finishes before starting another one to avoid conflict or dupe
* French, English language included (Locale system in a QBCore resource yeah you read right)
* If you run into any issue with this resource, just set 'Config.Debug' to true, it will print some debug logs in the client console. You can then send them [here](https://forum.cfx.re/t/qbcore-free-unicorn-lap-dance-qb-lapdance-v1-0/4769570).
## qb-lapdance is easily configurable: 
* **Config.LapDanceCost**
Set the cost of the lap dance
* **Config.LegMoney**
Little easter egg for your player, will add an accessory "Leg money" to the stripper if the player has more than 'Config.LegMoney' in cash. Set to a huge value if you don't want this
* **Config.Nudity**
Set to true if you want the stripper to be topless (Only for player above 'Config.NudityAge')
* **Config.NudityAge**
Player age restriction. If underage and 'Config.Nudity' is set to true, the stripper won't be topless. Set to 0 if you don't want age restriction
* **Config.UpdateChecker**
Set to false if you don't want to check for qb-lapdance update on start
* **Config.ChangeLog**
Set to false if you don't want to display the changelog if new version is found
* **Config.Blip**
Set to false if you don't want the blip on the map
* **Config.BlipStripclub**
This config will let you easily modify the blip to your need. It also include comments to help you in modifying it
* **Config.BlipCoord**
If you want to move the blip on the map, change this.
* **Config.Language**
Set the language variable that will be used for the locale system. For now, qb-lapdance has translation in French and English (fr or en)



Some new features will be added soon:  Being able to use the 7 seats and not only the first in the Unicorn, choose between different stripper, different gender for stripper(?), member card for cheaper lap dance(?)

**KNOWN BUG :** 
* None (For now I guess?)

**Preview:** [Coming Soon]()

### Requirements
* [qb-core](https://forum.cfx.re/t/qbcore-framework/4116674)

### Installation
Download the [latest release](https://github.com/clementinise/qb-lapdance/releases/latest).

Drag the folder into your `<server-data>/resources/[qb]` folder
If you don't have ``ensure [qb]`` in your server.cfg you will need to add this
```
start qb-lapdance
```
