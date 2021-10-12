Config                              = Config or {}

-- Framework
Config.Framework					= 'qbcore'		-- Choose which framework your server is using so qb-lapdance can work with it [esx, qbcore, standalone]
-- Since there is too many esx version, only this one is supported (https://github.com/esx-framework/es_extended/tree/v1-final). Maybe I will test other version, but not a priority

-- Lap dance 
Config.LapDanceCost					= 120 		-- Cost of the lap dance
Config.LegMoney                     = 10000     -- Little easter egg for your player, will add an accessory "Leg money" to the stripper if the player has more than 'Config.LegMoney' in cash. Set to a huge value if you don't want this
Config.Nudity                       = true      -- Set to true if you want the stripper to be topless (Only for player above 'Config.NudityAge')
Config.NudityAge                    = 21        -- (QBCore only!!) Player age restriction. If underage and 'Config.Nudity' is set to true, the stripper won't be topless. Set to 0 if you don't want age restriction

-- Blip
Config.Blip                         = true         -- Set to false if you don't want the blip on the map
Config.BlipName                     = "Strip-Club" -- Blip name
Config.BlipStripclub = {
	Sprite = 121,  -- Sprite list can be found here: https://docs.fivem.net/docs/game-references/blips/
	Colour = 50,   -- Color list in the same URL as above
	Display = 27,   -- Explanation here: https://docs.fivem.net/natives/?_0x9029B2F3DA924928
	Scale = 0.7    -- Self explanatory, let you set the scale of the blip
}
Config.BlipCoord = {
	{x=128.87, y=-1298.93, z=4.0}               -- If you want to move the blip on the map, change this.
}

-- Locale
Config.Language						= 'fr'		-- Currently Available: fr, en
-- Locales can be easily created or modified in `qb-lapdance/locales`

-- Misc
Config.Debug        				= true   	-- If you think something is not working, you can set 'Config.Debug' to true. It will then print a lot of debug information in your console
Config.UpdateChecker                = true      -- Set to false if you don't want to check for resource update on start
Config.ChangeLog					= true		-- Set to false if you don't want to display the changelog if new version is find