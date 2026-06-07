local validResourceList

local TimeWithoutCall = {}

local function collectValidResourceList()
    validResourceList = {}
    for i=0,GetNumResources()-1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end

function AnticheatPlayerJoined(source)
    TimeWithoutCall[source] = 0
end

local function StartStopperThread()
    CreateThread(function()
        while true do
            Wait(7500)
            for k, v in pairs(TimeWithoutCall) do
                if TimeWithoutCall[k] >= 2 then
                    SendAntiCheatLog(k, "Tried to stop resource : " .. TimeWithoutCall[k], false)
                else
                    TimeWithoutCall[k] = (TimeWithoutCall[k] or 0) + 1
                end
                Wait(5)
            end
        end
    end)
end

--StartStopperThread()

collectValidResourceList()

AddEventHandler("onResourceListRefresh", collectValidResourceList) 

RegisterServerEvent(ACConfig.Name .. ":checkResources")
AddEventHandler(ACConfig.Name .. ":checkResources", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            SendAntiCheatLog(source, "Unautorized Resource : " .. resource, true)
            DropPlayer(source, ACConfig.Name .. " : Une resource non autorisée a été detectée, Si vous pensez que c'est une erreur, merci de le signaler à un développeur")
            break
        end
    end
end)

RegisterServerEvent(ACConfig.Name .. ":checkWeapon")
AddEventHandler(ACConfig.Name .. ":checkWeapon", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    if weapon then
        local weaponName = weapon.name
        if string.lower(weaponName) == "weapon_snspistol_mk2" and xPlayer.getGroup() ~= "user" then return end
        if not xPlayer.hasWeapon(string.lower(weaponName)) and not xPlayer.hasPermWeapon(string.lower(weaponName)) then
            SendAntiCheatLog(source, "Weapon Give : " .. weaponName, true)
        end
    end
end)

--[[RegisterServerEvent(ACConfig.Name .. ":checkCHEAT")
AddEventHandler(ACConfig.Name .. ":checkCHEAT", function()
    local _source = source

    TimeWithoutCall[_source] = (TimeWithoutCall[_source] or 1) - 1

end)]]

RegisterServerEvent(ACConfig.Name .. ":clientDetect")
AddEventHandler(ACConfig.Name .. ":clientDetect", function(reason)
    if reason == "SuperJump" and not IsPlayerUsingSuperJump(source) then return end
    if ACConfig.ServerType.Framework and reason == "Resource Stop" then
        return
    end
    SendAntiCheatLog(source, reason, true)
end)

RegisterServerEvent(ACConfig.Name .. ":CheckWeaponKillAll") 
AddEventHandler(ACConfig.Name .. ":CheckWeaponKillAll", function(weaponhash) 
    if weaponhash == -1569615261 then
        SendAntiCheatLog(source, "KillAll", true)
    end
end)

Citizen.CreateThread(function()
    Wait(5000)
    if ACConfig.Enable then
    RegisterAnticheatEvents()
    if ACConfig.RateLimit.Enable then
        RegisterRateLimit()
    end
    loadAnticheatBanList()
    StartAnticheat()
    end
end)