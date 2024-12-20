Config = {}
Config.Devmode = false -- Set to true only on dev servers (this provides a command/tool to place gifts)
Config.defaultlang = 'en_lang' -- Set your language here current supported languages: "en_lang" = english, "ro_lang" = romanian
--- Holiday Tree Configs.
Config.DisplayItemActive = true
Config.DisplayItemModel = 'mp006_p_xmastree01x' --p_scarecrow01x, mp006_p_xmastree01x
Config.DisplayItemLocations = {
    { x = -311.06158447266,   y = 797.4072265625,   z = 117.98825073242 },
    { x = -176.2783966064453, y = 636.850830078125, z = 113.13392639160156 },
    { z = 42.69183349609375,  y = -1326.426513671875, x = -809.2332763671875 },
    { z = -14.34250831604003, y = -2607.149169921875, x = -3622.480224609375 },
    { z = -2.75130534172058, y = -2916.92236328125, x = -5512.28564453125 },
    { z = 79.48858642578125, y = -1381.448974609375, x = 1348.2962646484376 },
    { z = 51.24612045288086, y = -1295.560302734375, x = 2645.551513671875 }
}

Config.PickupCooldown = 60000 -- Cooldown in miliseconds 60000ms = 1min
--- Weather Configs
Config.WeatherActive = true
Config.PermanentSnow = true
Config.ServerStartupWeather = 'fog' --sunny, fog, overcast, rain

----- GiftBox Configs
Config.GiftboxesAvailable = true
Config.ViewDistance = 3.0
Config.ResetGiftsOnRestart = false --Toggling this to true will respawn all gifts on server/script restart.
Config.GiftboxModel = 'p_cs_giftbox01x' -- p_cs_giftbox01x, p_package09, p_pumpkin_01x

-- What items should be available within a giftbox (Player gets a random change to get any one of the items, quantity between the min/max)
-- List of textures you can find them in here 
-- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures
-- List of colors you can find them in here 
-- https://github.com/femga/rdr3_discoveries/blob/master/useful_info_from_rpfs/colours/README.md

Config.GiftableItems = {
    {
        item = 'apple',
        itemLabel = "Apple",
        itemTextureDict = 'inventory_items',
        itemTexturehashname = 'consumable_apple',
        itemTextureColor = 'COLOR_GREENDARK',
        quantity = {
            max = 4,
            min = 1
        }
    },
    {
        item = 'water',
        itemLabel = "Water",
        itemTextureDict = 'inventory_items',
        itemTexturehashname = 'generic_bottle',
        itemTextureColor = 'COLOR_GREENDARK',
        quantity = {
            max = 2,
            min = 1
        }
    }
}
