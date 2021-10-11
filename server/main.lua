local CurrentVersion = '1.0' -- Do Not Change This Value
local NewestVersion = nil 
local ChangeLogText = nil 

local LapDanceActive = false

-- Locale system
local language = "Locale." .. Config.Language
language = (loadstring or load)("return "..language)()

-- Locale in var
BoughtLapdance = language.BoughtLapdance
StripperActive = language.StripperActive
NotEnoughMoney = language.NotEnoughMoney

Citizen.CreateThread(function()
    if Config.UpdateChecker then

        PerformHttpRequest('https://raw.githubusercontent.com/clementinise/qb-lapdance/master/version', function(Error, Version, Header)
            NewestVersion = Version
        end)

        Citizen.Wait(1300)

        PerformHttpRequest('https://raw.githubusercontent.com/clementinise/qb-lapdance/master/changelog', function(Error, ChangeLog, Header)
            ChangeLogText = ChangeLog
        end)

        Citizen.Wait(1300)
        
        print('')
        print('^8QBCore ^6Lap Dance resource (qb-lapdance)')
        if CurrentVersion == NewestVersion then
            print('^2Version ' .. CurrentVersion .. ' - Up to date!')
        else
            print('^1Version ' .. CurrentVersion .. ' - Outdated!')
            print('^1New version: V' .. NewestVersion)
            if Config.ChangeLog then
                print('\n^3Changelog:')
                print(ChangeLogText)
            end
            print('')
            print('^1Please check the GitHub and download the last update')
            print('^2https://github.com/clementinise/qb-lapdance/releases/latest')
        end
        print('')
    end
end)

RegisterServerEvent('qb-lapdance:buy')
AddEventHandler('qb-lapdance:buy', function()

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Cost = Config.LapDanceCost
    PlayerMoney = Player.PlayerData.money["cash"]
    PlayerBirthdate = Player.PlayerData.charinfo.birthdate
    TodayDate = os.date("%Y-%m-%d")
	
	if PlayerMoney >= Cost then
        if not LapDanceActive then
            Player.Functions.RemoveMoney("cash", Cost)
            TriggerClientEvent('QBCore:Notify', src, BoughtLapdance, "success", 1700)
            TriggerClientEvent('qb-lapdance:lapdance', src, PlayerMoney, PlayerBirthdate, TodayDate)
        else
            TriggerClientEvent('QBCore:Notify', src, StripperActive, "error", 1700)
        end
	else
        TriggerClientEvent('QBCore:Notify', src, NotEnoughMoney, "error", 1700)
	end

end)

RegisterServerEvent('qb-lapdance:active')
AddEventHandler('qb-lapdance:active', function()

    LapDanceActive = true

end)

RegisterServerEvent('qb-lapdance:idle')
AddEventHandler('qb-lapdance:idle', function()

    LapDanceActive = false

end)

--[[ 
RegisterServerEvent("qb-lapdance:GetPlayerData")
AddEventHandler("qb-lapdance:GetPlayerData", function()

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        PlayerMoney = Player.PlayerData.money["cash"]
        PlayerBirthdate = PlayerData.charinfo.birthdate

	TriggerClientEvent("TyreSync", src, PlayerMoney, PlayerBirthdate)
end) ]]