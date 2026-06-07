local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
local HeartBeats = 0
local blkey = {121, 178, 10, 11}
local ClearHeartBeat = true

Citizen.CreateThread(function()
    if ACConfig.Enable then
        StartAC()
    end
end)

function StartAC()
    print(ACConfig.Prefix .. "Loaded")
    --StartHeartBeatThread()
    if ACConfig.EnableChecks then
        if ACConfig.ServerType.ESX then
           while not ESX.PlayerLoaded do 
            Wait(0)
           end 
        end
    if ACConfig.EnableChecks.Weapons and ACConfig.ServerType then
        StartWeaponCheck()
    end
    if ACConfig.EnableChecks.CarSpawn then
        StartCarSpawnCheck()
    end
    if ACConfig.EnableChecks.ResourceInject then
        StartResourceCheck()
    end
    if ACConfig.EnableChecks.Others then
        StartSomeChecks()
        if ACConfig.EnableChecks.Others.WeaponDrops then
            RemoveWeaponDrops()
        end
        if ACConfig.EnableChecks.Others.GodMode then
            StartGodModeCheck()
        end
        if ACConfig.EnableChecks.Others.AntiEngineDestroy then
            StartAntiEngineDestroy()
        end
    end
    end
end
function StartHeartBeatThread()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            if ESX.PlayerData.PassJoin then
            HeartBeats = HeartBeats - 1
            end
            if HeartBeats < -2 then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Attempt to stop resource : pouf")
                break
            end
            Citizen.CreateThread(function()
                SendHeartBeat()
            end)
            if ClearHeartBeat and HeartBeats > 0 then
                HeartBeats = 0
            end
            Wait(2500)
        end
    end)
end

function SendHeartBeat()
    exports.pouf:checkStop()
    ClearHeartBeat = false
end

function CyphercheckStop()
    HeartBeats = HeartBeats + 1
end

function StartWeaponCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(2000)
            local PedWeapons = {}
            local weapon = GetSelectedPedWeapon(ESX.PlayerData.cache.playerped)
            if weapon ~= GetHashKey("weapon_unarmed") and weapon ~= 0 then
                local weaponData = ESX.GetWeaponFromHash(weapon)
                TriggerServerEvent(ACConfig.Name .. ":checkWeapon", weaponData)
            end 
        end
    end)
end

function StartCarSpawnCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(500)
            for vehicle in EnumerateVehicles() do
                local handle = GetEntityScript(vehicle)
				if handle and not ACConfig.WhiteListedResources[handle] then
                    Delete(vehicle)
                    TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Car spawn")
                    break
				end
            end
        end
    end)
end

function StartResourceCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            local resourceList = {}
            for i=0,GetNumResources()-1 do
                resourceList[i+1] = GetResourceByFindIndex(i)
            end
            TriggerServerEvent(ACConfig.Name .. ":checkResources", resourceList)
            Citizen.Wait(10000)
        end
    end)
end

function StartSomeChecks()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Citizen.Wait(1000)
            local ped = ESX.PlayerData.cache.playerped
            if ACConfig.EnableChecks.Others.Spectator and NetworkIsInSpectatorMode() and ESX.PlayerData.group == "user" then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Spectator Mode")
                break
            end
            if ACConfig.EnableChecks.Others.ThermalVision and GetUsingseethrough() then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Thermal Vision")
                break
            end
            if ACConfig.EnableChecks.Others.NightVision and GetUsingnightvision() then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Night Vision")
                break
            end
            if ACConfig.EnableChecks.texturenamebl then
                for k, v in pairs(ACConfig.EnableChecks.Others.texturename) do
                    if HasStreamedTextureDictLoaded(v) then
                        --TriggerServerEvent(ACConfig.Name .. ":clientDetect", "Anti BlackListed Texture : ".. v )
                        break
                    end
                end
            end
        end
    end)
end

function StartGodModeCheck()
    Citizen.CreateThread(function()
        while ACConfig.Enable do
            Wait(1000)
            CheckPlayerProofs()
        end
    end)
end

function CheckPlayerProofs()
    local retval, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof = GetEntityProofs(ESX.PlayerData.cache.playerped)
    local checks = {retval = retval, bulletProof = bulletProof, fireProof = fireProof, explosionProof = explosionProof, collisionProof = collisionProof, meleeProof = meleeProof, steamProof = steamProof, p7 = p7, drownProof = drownProof}
    for k, v in pairs(checks) do
        if k ~= "retval" then
            if v == 1 then
                TriggerServerEvent(ACConfig.Name .. ":clientDetect", "God Mode")
                break
            end
        end
    end
end

function RemoveWeaponDrops()
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
    end
end

function StartAntiEngineDestroy()
    Citizen.CreateThread(function()
        while ACConfig.Enable do 
            Wait(5000)
            local ped = ESX.PlayerData.cache.playerped
            if IsPedSittingInAnyVehicle(ped) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                if GetVehicleEngineHealth(vehicle) <= 500 then
                    if not GetIsVehicleEngineRunning(vehicle) then
                        SetVehicleEngineOn(vehicle, true, false, true)
                        SetVehicleUndriveable(vehicle, false)
                    end
                    SetVehicleEngineHealth(vehicle, 1000.0)
                else
                    Wait(2500)
                end
            else
                Wait(2500)
            end
        end
    end)
end




