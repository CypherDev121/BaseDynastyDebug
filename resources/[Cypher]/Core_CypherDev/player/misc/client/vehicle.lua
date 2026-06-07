link = 'aucune'
timecode = "Bientot mdr"
VideoPlaying = false
local carpos = vector3(0, 0, 0)
volume = 0.5

CarRadios = {}
    
    local kmh = 1.9
    local mph = 1.33693629
    local carspeed = 0
    local driftmode = false
    local speed = kmh
    local drift_speed_limit = 70.0

    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)
            if driftmode then
    
                if IsPedInAnyVehicle(ESX.PlayerData.cache.playerped, false) then
    
                    CarSpeed = GetEntitySpeed(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false)) * speed
    
                    if GetPedInVehicleSeat(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), -1) == ESX.PlayerData.cache.playerped then
    
                        if CarSpeed <= drift_speed_limit then  
    
                            if IsControlPressed(1, 21) then
                                SetVehicleReduceGrip(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), true)
                            else
                                SetVehicleReduceGrip(GetVehiclePedIsIn(ESX.PlayerData.cache.playerped,false), false)
                            end
                        end
                    end
                end
            end
        end
    end)

    RegisterCommand("+driftmode", function(source, args, raw)
      driftmode = not driftmode
    
                if driftmode then
                    ESX.ShowNotification("~g~Drift mode activé~s~.")
                else
                    ESX.ShowNotification("~r~Drift mode désactivé~s~.")
                end
    end, false)

    RegisterKeyMapping("+driftmode", "Mode Drift", "keyboard", "l")
  
    
    RegisterCommand("shuffle", function(source, args, raw)
    TriggerEvent("SeatShuffle")
    end, false)
    
    Citizen.CreateThread(function()
     while true do
      Citizen.Wait(2)
      if DoesEntityExist(GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)) then
        local veh = GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)
        local pedd = GetPedInVehicleSeat(veh, -1)
        if pedd then
          SetPedCanBeDraggedOut(pedd, false)
        end
      else
        Citizen.Wait(500)
      end
     end
    end)

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(2500)
     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name ~= nil then
       local playerPed = ESX.PlayerData.cache.playerped
       local coords = GetEntityCoords(playerPed)
       local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
       local carModel = GetEntityModel(veh)
       if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
         local plate = GetVehicleNumberPlateText(veh)
         local prefix = string.upper(string.sub(plate, 0, 4))
         if prefix == "POLI" and ESX.PlayerData.job.name ~= "police" and ESX.PlayerData.job.name ~= "doa" then
           ESX.ShowNotification("Un véhicule de police n'est pas réservée aux civils.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
         elseif prefix == "AMBU" and ESX.PlayerData.job.name ~= "ambulance" then
           ESX.ShowNotification("Un véhicule d'ambulance n'est pas réservée aux civils.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
         elseif prefix == "TAXI" and ESX.PlayerData.job.name ~= "taxi" then
           ESX.ShowNotification("Un véhicule de taxi n'est réservée qu'aux taxis.")
           SetVehicleUndriveable(veh, true)
           SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
        end
       end
    end
end
end)


Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   if DoesEntityExist(GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)) then
     local veh = GetVehiclePedIsTryingToEnter(ESX.PlayerData.cache.playerped)
     local pedd = GetPedInVehicleSeat(veh, -1)
     if pedd then
       SetPedCanBeDraggedOut(pedd, false)
     end
   else
     Citizen.Wait(500)
   end
  end
 end)