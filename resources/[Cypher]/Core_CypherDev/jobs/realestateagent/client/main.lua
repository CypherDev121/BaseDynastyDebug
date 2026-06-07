local hasAlreadyEnteredMarker, CurrentActionData = false, {}
local CurrentAction, CurrentActionMsg, LastZone
local inImmo = false

Citizen.CreateThread(function()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	if ESX.PlayerData.job.name == 'realestateagent' then
		ImmoConfig.Zones.OfficeActions.Type = 1
	else
		ImmoConfig.Zones.OfficeActions.Type = -1
	end
end)

function OpenRealestateAgentMenu()

	RealEstateManagementMenu = {
		Base = { Title = "Agence", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "agent immobilier" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == 'boss' then
				CloseMenu()
				Wait(100)
				OpenBossMenu("realestateagent", 1)
			elseif btn.action == 'properties' then
				CloseMenu()
				Wait(100)
				OpenPropertiesMenu()
			elseif btn.action == 'customers' then
				CloseMenu()
				Wait(100)
				OpenCustomersMenu()
			end
		end
	  },
	
	  Menu = {
		["agent immobilier"] = {
			b = {
				{name = "Propriétés", action = 'properties', ask = "→", askX = true},
				{name = "Client",    action = 'customers', ask = "→", askX = true},
			}
		}
	 }
	}

	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(RealEstateManagementMenu.Menu["agent immobilier"].b, {
			name = "Menu Patron",
			action = 'boss', 
			ask = "→", 
			askX = true
		})
	end
	
	CreateMenu(RealEstateManagementMenu)

end

function OpenPropertiesMenu()
	TriggerEvent('property:getProperties', function(properties)

		RealEstatePropertiesMenu = {
			Base = { Title = "Propriétés", HeaderColor = {169, 187, 232} },
			Data = { currentMenu = "proprietes" },
		
			Events = {
			onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
				if btn.action == 'choices' then
					RealEstatePropertiesMenu.Menu["actions"].b = {}
					table.insert(RealEstatePropertiesMenu.Menu["actions"].b, {
						name = 'Assigner [Vente]',
						data = btn.data,
						action = 'sell', 
						ask = "→", 
						askX = true
					})
					table.insert(RealEstatePropertiesMenu.Menu["actions"].b, {
						name = 'Assigner [Location]',
						data = btn.data,
						action = 'rent', 
						ask = "→", 
						askX = true
					})
					table.insert(RealEstatePropertiesMenu.Menu["actions"].b, {
						name = 'GPS',
						data = btn.data,
						action = 'gps', 
						ask = "→", 
						askX = true
					})
					OpenMenu('actions')
				elseif btn.action == 'sell' then
					local amount = KeyboardInput("ESTATE_SELLPRICE", "Prix de la propriété ?", "", 9)
					if tonumber(amount) ~= nil then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification("aucun joueur à proximité")
							CloseMenu()
						else
						TriggerServerEvent('realestateagentjob:sell', GetPlayerServerId(closestPlayer), btn.data.name, tonumber(amount))
						end
					end
				elseif btn.action == 'rent' then
					local amount = KeyboardInput("ESTATE_RENTPRICE", "Loyer de la propriété ?", "", 9)
					if tonumber(amount) ~= nil then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification("aucun joueur à proximité")
							CloseMenu()
						else
							TriggerServerEvent('realestateagentjob:rent', GetPlayerServerId(closestPlayer), btn.data.name, tonumber(amount))
						end
					end
				elseif btn.action == 'gps' then
					TriggerEvent('property:getProperty', btn.data.name, function(property)
						if property.isSingle then
							SetNewWaypoint(property.entering.x, property.entering.y)
						else 
							TriggerEvent('property:getGateway', property, function(gateway)
								SetNewWaypoint(gateway.entering.x, gateway.entering.y)
							end)
						end
					end)
					CloseMenu()
				end
			end
		  },
		
		  Menu = {
			["proprietes"] = {
				b = {
					
				}
			},
			["actions"] = {
				b = {
					
				}
			}
		 }
		}


		for i=1, #properties, 1 do
			table.insert(RealEstatePropertiesMenu.Menu["proprietes"].b, {
				name = properties[i].label,
				data = properties[i],
				action = 'choices', 
				ask = "→", 
				askX = true
			})
			
		end
		
		CreateMenu(RealEstatePropertiesMenu)
	end)
end

function OpenCustomersMenu()
	ESX.TriggerServerCallback('realestateagentjob:getCustomers', function(customers)

		RealEstateCustomersMenu = {
			Base = { Title = "Clients", HeaderColor = {169, 187, 232} },
			Data = { currentMenu = "customers" },
		
			Events = {
			onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
				if btn.action == 'choices' then
					RealEstateCustomersMenu.Menu["actions"].b = {}
					table.insert(RealEstateCustomersMenu.Menu["actions"].b, {
						name = 'Révoquer l\'appartement',
						data = btn.data,
						action = 'revoke', 
						ask = "→", 
						askX = true
					})
					table.insert(RealEstateCustomersMenu.Menu["actions"].b, {
						name = 'GPS',
						data = btn.data,
						action = 'gps', 
						ask = "→", 
						askX = true
					})
					OpenMenu('actions')
				elseif btn.action == 'revoke' then
					TriggerServerEvent('realestateagentjob:revoke', btn.data.propertyName, btn.data.propertyOwner)
				elseif btn.action == 'gps' then
					TriggerEvent('property:getProperty', btn.data.propertyName, function(property)
						if property.isSingle then
							SetNewWaypoint(property.entering.x, property.entering.y)
						else 
							TriggerEvent('property:getGateway', property, function(gateway)
								SetNewWaypoint(gateway.entering.x, gateway.entering.y)
							end)
						end
					end)
					CloseMenu()
				end
			end
		  },
		
		  Menu = {
			["customers"] = {
				b = {
					
				}
			},
			["actions"] = {
				b = {
					
				}
			}
		 }
		}

		for i=1, #customers, 1 do
			table.insert(RealEstateCustomersMenu.Menu["customers"].b, {
				name = customers[i].name .. ' | ' .. customers[i].propertyLabel,
				data = customers[i],
				action = 'choices', 
				ask = "→", 
				askX = true
			})
			
		end
		
		CreateMenu(RealEstateCustomersMenu)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	if ESX.PlayerData.job.name == 'realestateagent' then
		ImmoConfig.Zones.OfficeActions.Type = 1
	else
		ImmoConfig.Zones.OfficeActions.Type = -1
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(ImmoConfig.Zones.OfficeEnter.Pos.x, ImmoConfig.Zones.OfficeEnter.Pos.y, ImmoConfig.Zones.OfficeEnter.Pos.z)

	SetBlipSprite (blip, 357)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 59)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Agence Immobilière")
	EndTextCommandSetBlipName(blip)
end)

local IsMenuOpen = false
local HasAlreadyEnteredMarker = false

-- Draw Marker / Control Listener
Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
   
     local pedCoords = ESX.PlayerData.cache.coords
     local isInMarker = false
     local letSleep = true
   
     for k,v in pairs(ImmoConfig.Zones) do
	   if k == "OfficeEnter" or inImmo then 
       if (GetDistanceBetweenCoords(pedCoords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then
         letSleep = false
		 DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, ImmoConfig.MarkerColor.r, ImmoConfig.MarkerColor.g, ImmoConfig.MarkerColor.b, 100, false, true, 2, false, false, false, false)
       end
   
       if v.Type ~= -1 and GetDistanceBetweenCoords(pedCoords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ((v.Size.x + v.Size.x) / 2) then
         HasAlreadyEnteredMarker = true
         isInMarker = true
         ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
         if IsControlJustPressed(1, 38) then
			if k == 'OfficeEnter' then
				local playerPed = ESX.PlayerData.cache.playerped
				SetEntityCoords(playerPed, ImmoConfig.Zones.OfficeInside.Pos.x, ImmoConfig.Zones.OfficeInside.Pos.y, ImmoConfig.Zones.OfficeInside.Pos.z)
				inImmo = true
			elseif k == 'OfficeExit' then
				local playerPed = ESX.PlayerData.cache.playerped
				SetEntityCoords(playerPed, ImmoConfig.Zones.OfficeOutside.Pos.x, ImmoConfig.Zones.OfficeOutside.Pos.y, ImmoConfig.Zones.OfficeOutside.Pos.z)
				inImmo = false
			elseif k == 'OfficeActions' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' then
				OpenRealestateAgentMenu()
			end
         end
       end
	end
     end
   
     if not isInMarker and HasAlreadyEnteredMarker then
       HasAlreadyEnteredMarker = false
       CloseMenu()
     end
   
     if letSleep then
       Citizen.Wait(5000)
     end
    end
end)

-- Load IPLS
Citizen.CreateThread(function()
	LoadMpDlcMaps()
	RequestIpl('ex_dt1_02_office_02c')
end)