# Bcc Holidays

> A holiday script for your redm server!

## How to install
* Download this repo
* Copy and paste `bcc-holidays` folder to `resources/bcc-holidays`
* Add `ensure bcc-holidays` to your `server.cfg` file (ABOVE any scripts that use it)
* Now you are ready to get coding!

## Features
- Devmode (Easily add new gitbox and display item locations)
- Display Items (Scarecrows, xmas trees, etc)
- Giftbox 
    - Get a random item when found
    - Reset on server restart, or permanent use
- Weather sync support for permanent Snow on ground

![image](https://github.com/BryceCanyonCounty/bcc-holidays/assets/10902965/bbe815a7-4d12-4764-97cf-575a51a0df71)
![image](https://github.com/BryceCanyonCounty/bcc-holidays/assets/10902965/3be9e8b6-c859-4768-8167-a8a8c2a53aa2)

## How to add new giftboxes
1. In config set `Config.Devmode = true` (It is recommended to do this in a test server or instance)
2. Type command `setgiftbox` once to show placement sphere
3. Type command `setgiftbox` again to then add a new giftbox location
4. Make sure to turn devmode off when done.

## How to add new Display Items (Example trees)
1. In config set `Config.Devmode = true` (It is recommended to do this in a test server or instance)
2. Type command `setdisplayitem` once to show placement sphere
3. Type command `setdisplayitem` again to then add a new giftbox location to a file named `displayitems.json`
4. Copy paste the x, y, z values to the `Config.DisplayItemLocations` to add new Display Items
