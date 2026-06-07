---
---
---

local myVehicles = {}
local impoundVeh = 0

RegisterNetEvent('cypherdev_ui:loadVehicles')
AddEventHandler('cypherdev_ui:loadVehicles', function(vehicles)
    impoundVeh = 0
    myVehicles = {}
    for i = 1, #vehicles do
        if not vehicles[i].state then
            impoundVeh = impoundVeh + 1
        end
        myVehicles[vehicles[i].plate] = {
            name = vehicles[i].label or "Véhicule "..i,
            model = vehicles[i].model,
            vehicle = nil,
            plate = vehicles[i].plate,
            favorite = false,
            avaliable = vehicles[i].state and true or false,
            vehicleStats = {
                maxSpeed = 400,
                acceleration = 500,
                vault = 50
            }
        }
    end
end)

local function loadVehiclesData(data)
    ---[{"plate":"CPY 979","state":true,"vehicle":{"plate":"CPY 979","model":788045382},"type":"car","model":788045382}]
    impoundVeh = 0
    myVehicles = {}
    for i = 1, #data do
        if not data[i].state then
            impoundVeh = impoundVeh + 1
        end
        myVehicles[data[i].plate] = {
            name = GetLabelText(GetDisplayNameFromVehicleModel(data[i].model)) or "Véhicule "..i,
            model = data[i].model,
            vehicle = nil,
            plate = data[i].plate,
            favorite = false,
            avaliable = data[i].state and true or false,
            vehicleStats = {
                maxSpeed = 400,
                acceleration = 500,
                vault = 50
            }
        }
    end
end

RegisterNetEvent('garage:openUI')
AddEventHandler('garage:openUI', function()
    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        loadVehiclesData(vehicles)
        Citizen.Wait(250)
        TriggerEvent('cypherdev_ui:SetNuiFocus', true)
        TriggerEvent('cypherdev_ui:SendNUIMessage', "garage", {
            action = "show",
            identityName = GetPlayerName(PlayerId()),
            selectedVehicle = nil,
            impoundVehicle = impoundVeh,
            zoneGarage = "Parking",
            garageData = myVehicles,
            searchVehicle = "",
        })
    end)
end)

do
    Citizen.Wait(1000)
    TriggerEvent('cypherdev_ui:RegisterNUICallback', "garage", "close", function(data, cb)
        TriggerEvent('cypherdev_ui:SetNuiFocus', false)
        cb('ok')
    end)
    TriggerEvent('cypherdev_ui:RegisterNUICallback', "garage", "outVehicle", function(data, cb)
        TriggerEvent('cypherdev_ui:SetNuiFocus', false)
        TriggerEvent('cypherdev_ui:SendNUIMessage', "garage", { action = "hide" })
        print(json.encode(data))
        ESX.TriggerServerCallback('garage:SpawnVehicle', function(success, vehicle, props)
            if success then
                Citizen.Wait(500)
                local veh = NetworkGetEntityFromNetworkId(vehicle)
                NetworkRequestControlOfEntity(veh)
                local timeout = 10
                while not NetworkHasControlOfEntity(veh) and timeout > 0 do
                    Wait(100)
                    timeout = timeout - 1
                end
                ESX.Game.SetVehicleProperties(veh, props)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                SetVehicleNumberPlateText(veh, props.plate)
            else
                ESX.ShowNotification("Impossible de sortir le véhicule")
            end            
        end, data.vehicle.plate, GetEntityCoords(PlayerPedId()))
        cb('ok')
    end)
    
end