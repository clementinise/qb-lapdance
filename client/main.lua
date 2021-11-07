local QBCore = exports['qb-core']:GetCoreObject()
local InLapdance = false
local InCooldown = false
local NearText = false
local NearMarker = false

-- Locale system
local language = "Locale." .. Config.Language
language = (load)("return "..language)()

-- Locale in var
lapText = language.LapText
StandalonelapText = language.StandaloneLapText
StripperPause = language.StripperPause

-- Create Blips
Citizen.CreateThread(function()	
	if Config.Blip then
		for i=1, #Config.BlipCoord, 1 do

			local blip = AddBlipForCoord(Config.BlipCoord[i].x, Config.BlipCoord[i].y, Config.BlipCoord[i].z)

			SetBlipSprite (blip, Config.BlipStripclub.Sprite)
			SetBlipDisplay(blip, Config.BlipStripclub.Display)
			SetBlipScale  (blip, Config.BlipStripclub.Scale)
			SetBlipColour (blip, Config.BlipStripclub.Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.BlipName)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

RegisterNetEvent('qb-lapdance:showNotify')
AddEventHandler('qb-lapdance:showNotify', function(notify)
	ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	
	if Config.Framework == "standalone" then
		lapText = StandalonelapText
	end

    while true do
    
    	if not NearMarker then 
			Citizen.Wait(800)
		else
			Citizen.Wait(0)
		end

        if NearMarker then
            DrawMarker(2, 117.04, -1294.8, 29.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 100, false, true, 2, false, false, false, false)
            if NearText then
				DrawText3D(117.04, -1294.8, 29.25, lapText)
				if IsControlPressed(0, 38) and not InCooldown then
					TriggerServerEvent('qb-lapdance:buy')
					Citizen.Wait(5000)
				elseif IsControlPressed(0, 38) and InCooldown and Config.Framework == 'qbcore' then
					QBCore.Functions.Notify(StripperPause, "error")
					Citizen.Wait(5000)
				elseif IsControlPressed(0, 38) and InCooldown and Config.Framework ~= 'qbcore' then
					ShowAboveRadarMessage(StripperPause)
					Citizen.Wait(5000)
				end
        	end
    	end
    end
end) 

Citizen.CreateThread(function()
    while true do
    
    Citizen.Wait(600)
	
		local Player = PlayerPedId()
		local coords = GetEntityCoords(Player)
		local markerdist = #(coords - vector3(117.04, -1294.8, 28.42))
        if markerdist < 20 then
			NearMarker = true
		else
			NearMarker = false
		end
		if markerdist < 2.2 then
			NearText = true
		else
			NearText = false
		end
    end
end) 

RegisterNetEvent('qb-lapdance:lapdance')
AddEventHandler('qb-lapdance:lapdance', function(PlayerMoney, PlayerBirthdate, TodayDate)
	local Player = PlayerPedId()
	Birthdate = {}
	Date = {}

	if Config.Framework == 'qbcore' then
		index = 1
		for value in string.gmatch(PlayerBirthdate, "[^-]+") do
			Birthdate[index] = value
			index = index + 1
		end

		index = 1
		for value in string.gmatch(TodayDate, "[^-]+") do
			Date[index] = value
			index = index + 1
		end

		Year = Date[1] - Birthdate[1]
		Month = Date[2] - Birthdate[2]
		Day = Date[3] - Birthdate[3]
	else
		Year = 1000
		Month = 0
		Day = 0
	end
		
	RequestModel(1846523796)
	InCooldown = true
	TriggerServerEvent('qb-lapdance:active')
	while not HasModelLoaded(1846523796) do
		Wait(20)
	end

	SetEntityHeading(Player, 120.18)
	local SpawnObject = CreatePed(4, 1846523796, 116.59, -1301.04, 28.05, true)
	SetPedComponentVariation(SpawnObject, 1, 0) -- Head
	SetPedComponentVariation(SpawnObject, 2, 0) -- Hair
	SetPedComponentVariation(SpawnObject, 3, 0) -- Torso
	SetPedComponentVariation(SpawnObject, 4, 1) -- Shooes
	SetPedComponentVariation(SpawnObject, 6, 0) -- Underwear
	SetPedComponentVariation(SpawnObject, 10, 0) -- Decals ??
	SetPedComponentVariation(SpawnObject, 11, 0) -- Auxiliary parts for torso

	if Year >= Config.NudityAge + 1 then
		underage = false
	elseif Year == Config.NudityAge then
		if Month == 0 and Day <= 0 then
			underage = false
		else
			underage = true
		end
	else
		underage = true
	end

	if underage then
		SetPedComponentVariation(SpawnObject, 8, 0) -- Not Topless
	elseif not underage and not Config.Nudity then
		SetPedComponentVariation(SpawnObject, 8, 0) -- Not Topless
	else
		SetPedComponentVariation(SpawnObject, 8, 1) -- Topless
	end
	
	if Config.Framework ~= 'standalone' then
		if PlayerMoney >= Config.LegMoney then
			SetPedComponentVariation(SpawnObject, 9, 1)
		else
			SetPedComponentVariation(SpawnObject, 9, 0)
		end
	end

	if Config.Debug then
		print("------ qb-lapdance : Debug print start ------")
		print("Player cash: ", PlayerMoney, "Player birthdate: ", PlayerBirthdate, "Today date: ", TodayDate)
		print('Config.Language is set to: ' .. Config.Language)
		print('Framework used: ' .. Config.Framework)
		print(Config.Language .. "", language)
		--[[ print("Birthdate split: ", Birthdate[1], Birthdate[2], Birthdate[3])
		print("Date split: ", Date[1], Date[2], Date[3]) ]]
		print("Year: ", Year, "Month: ", Month, "Day: ", Day)
		print(GetPedDrawableVariation(SpawnObject, 1), "Head")
		print(GetPedDrawableVariation(SpawnObject, 2), "Beard")
		print(GetPedDrawableVariation(SpawnObject, 3), "Torso")
		print(GetPedDrawableVariation(SpawnObject, 4), "Legs")
		print(GetPedDrawableVariation(SpawnObject, 5), "Hands")
		print(GetPedDrawableVariation(SpawnObject, 6), "Foot")
		print(GetPedDrawableVariation(SpawnObject, 7), "???")
		print(GetPedDrawableVariation(SpawnObject, 8), "Accessories 1")
		print(GetPedDrawableVariation(SpawnObject, 9), "Accessories 2")
		print(GetPedDrawableVariation(SpawnObject, 10), "Decals")
		print(GetPedDrawableVariation(SpawnObject, 11), "Auxiliary parts for torso")
		print('')
		if underage then
			print("Player is underage")
		else
			print("Player isn't underage")
		end
		if not Config.Nudity and underage then
			print("Stripper isn't topless")
		elseif not Config.Nudity and not underage then
			print("Stripper isn't topless")
		else
			print("Stripper is topless")
		end
		print("------ qb-lapdance : Debug print end ------")
	end

	RequestAnimDict("mini@strip_club@idles@stripper")
	while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
		Citizen.Wait(20)
	end
	TaskPlayAnim(SpawnObject, "mini@strip_club@idles@stripper", "stripper_idle_02", 8.0, -8.0, -1, 0, 0, false, false, false)

	InLapdance = true

	SetEntityCoords(Player, 116.88, -1295.04, 28.42)
	SetEntityHeading(SpawnObject, 303.19)
	FreezeEntityPosition(SpawnObject, true)
	TaskGoToCoordAnyMeans(Player, 118.29, -1301.43, 28.42, 1.0, 0, 0, 786603, 1.0)
	Citizen.Wait(4900)

	FreezeEntityPosition(SpawnObject, false)
	TaskGoToCoordAnyMeans(SpawnObject, 118.0, -1300.3, 28.17, 174.93, 0, 0, 0, 0xbf800000)
	Citizen.Wait(2000)

	TaskGoToCoordAnyMeans(SpawnObject, 118.74, -1301.91, 29.27, 174.93, 0, 0, 0, 0xbf800000)
	Citizen.Wait(2100)

	FreezeEntityPosition(SpawnObject, true)
	SetEntityHeading(SpawnObject, 216.6)
	RequestAnimDict("mini@strip_club@private_dance@part2")
	while not HasAnimDictLoaded("mini@strip_club@private_dance@part2") do
		Citizen.Wait(20)
	end
	TaskPlayAnim(SpawnObject, "mini@strip_club@private_dance@part2", "priv_dance_p2", 8.0, -8.0, -1, 0, 0, false, false, false)
	Citizen.Wait(30000)

	RequestAnimDict("mini@strip_club@backroom@")
	while not HasAnimDictLoaded("mini@strip_club@backroom@") do
		Citizen.Wait(20)
	end
	TaskPlayAnim(SpawnObject, "mini@strip_club@backroom@", "stripper_b_backroom_idle_b", 8.0, -8.0, -1, 0, 0, false, false, false)
	Citizen.Wait(5000)

	FreezeEntityPosition(SpawnObject, false)
	TaskGoToCoordAnyMeans(SpawnObject, 116.59, -1301.04, 28.17, 174.93, 0, 0, 0, 0xbf800000)
	Citizen.Wait(2000)

	RequestAnimDict("mini@strip_club@idles@stripper")
	while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
		Citizen.Wait(20)
	end
	TaskPlayAnim(SpawnObject, "mini@strip_club@idles@stripper", "stripper_idle_02", 8.0, -8.0, -1, 0, 0, false, false, false)
	SetEntityHeading(SpawnObject, 308.6)

	InLapdance = false

	Citizen.Wait(10000)

	InCooldown = false
	TriggerServerEvent('qb-lapdance:idle')

	DeleteEntity(SpawnObject)
end)

Citizen.CreateThread(function()

	while true do

		if not InLapdance then
			Citizen.Wait(1000)
		else
			Citizen.Wait(0)
		end

		if InLapdance then
			SetFollowPedCamViewMode(4)
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 257, true)
			DisableControlAction(2, 25, true)
			DisableControlAction(2, 263, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 8, true)
			DisableControlAction(2, 9, true)
		end
	end
end)

Citizen.CreateThread(function()

	while true do

		if not InLapdance then
			Citizen.Wait(1000)
		else
			Citizen.Wait(0)
		end
	
		local Player = PlayerPedId()
		local coords = GetEntityCoords(Player)
		local sitdist = #(coords - vector3(118.75, -1301.97, 28.42))
		if sitdist < 1.5 and InLapdance then
		
			local dict = "mini@strip_club@lap_dance_2g@ld_2g_reach"
			RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(20)
				end
			SetEntityCoords(Player, 119.06, -1302.66, 27.78)
			FreezeEntityPosition(Player, true)
			SetEntityHeading(Player, 40.0)
			TaskPlayAnim(Player, dict, "ld_2g_sit_idle", 8.0, -8.0, -1, 0, 0, false, false, false)
			repeat
			TaskPlayAnim(Player, dict, "ld_2g_sit_idle", 8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(550)
			until(InLapdance == false)
			FreezeEntityPosition(Player, false)
			SetEntityCoords(Player, 118.75, -1301.99, 28.42)
			Citizen.Wait(200)
			TaskGoToCoordAnyMeans(Player, 117.48, -1294.82, 28.43, 1.0, 0, 0, 786603, 1.0)
			Citizen.Wait(5800)
		end
	end
end)
