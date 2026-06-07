local MarkersData = {
	size = {4.0, 4.0, 1.5},
	color = {168, 50, 50, 100},
	DrawDistance = 10.0,
	Messages = {
		["harvest"] = "Appyuez sur ~INPUT_CONTEXT~ pour récolter : ",
		["transform"] = "Appyuez sur ~INPUT_CONTEXT~ pour traîter : ",
		["sell"] = "Appyuez sur ~INPUT_CONTEXT~ pour vendre : ",
		["sellall"] = "Appyuez sur ~INPUT_CONTEXT~ pour vendre : "
	}
}


local IsUsingDrugSystem = false

local AntiSpamDrugs = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local sleep = true
        local InZone = false

        for a, b in pairs(DrugsZones) do
            for k, v in pairs(b) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

                -- Vérification de la distance pour afficher le marqueur
                if distance < MarkersData.DrawDistance then
                    sleep = false
                     DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, MarkersData.size[1], MarkersData.size[2], MarkersData.size[3], MarkersData.color[1], MarkersData.color[2], MarkersData.color[3], MarkersData.color[4], false, true, 2, false, false, false, false)
            end
                -- Vérification de la proximité pour les interactions
                if distance < 4.0 then
                    InZone = true
                    if not IsUsingDrugSystem then
                        ESX.ShowHelpNotification(MarkersData.Messages[k] .. " " .. a)
                        if IsControlJustReleased(0, 38) then
                            DrugControlManager(k, a)
                            IsUsingDrugSystem = true
                        end
                    end
                end
            end
        end

        -- Gestion de l'état d'utilisation du système de drogue
        if not InZone and IsUsingDrugSystem then
            IsUsingDrugSystem = false
            TriggerServerEvent("drugs:stopHarvest")
            TriggerServerEvent("drugs:stopTransform")
            TriggerServerEvent("drugs:stopSell")
        end

        -- Réduire la fréquence d'itération si aucune zone n'est détectée
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)


function DrugControlManager(zone, drug)
	if zone == "harvest" then
	TriggerServerEvent("drugs:startHarvest", drug)
	elseif zone == "transform" then
	TriggerServerEvent("drugs:startTransform", drug)
	elseif zone == "sell" then
	TriggerServerEvent("drugs:startSell", drug)
elseif zone == "sellall" then
    TriggerServerEvent("drugs:startSellAll")
	end
end


Citizen.CreateThread(function()
	while true do
	 Citizen.Wait(2500)
	 if IsUsingDrugSystem then
		 RequestAnimDict("pickup_object")
		 while not HasAnimDictLoaded("pickup_object") do
		   Citizen.Wait(100)
		 end
		 TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 2.0, 2.0, -1, 1, 0, false, false, false)
		 Citizen.Wait(1200)
		 ClearPedTasksImmediately(PlayerPedId())
		 RemoveAnimDict("pickup_object")
	   end
	 end
	
   end)