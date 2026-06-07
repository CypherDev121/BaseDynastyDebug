RegisterNetEvent("admin:requestSpectate")
RegisterNetEvent("admin:FreezePlayer")
RegisterNetEvent("admin:GoToPlayerCli")
RegisterNetEvent("admin:GoToPlayerCli2")
RegisterNetEvent("admin:SetPlayer")
RegisterNetEvent("admin:delVeh")

local DebugColor = 0

local InServiceAdmin = false

local gamerTags = {}
local gamerTagsColor = {}

local IDActive = false
local noclipse = false
local DelGunVeh = false

local BanOption = {"1 jours", "2 jours", "3 jours", "1 semaine", "Permanent"}
local JailOption = {"10 minutes", "30 minutes", "1 heure", "1 jour", "1 semaine", "Unjail"}
local FreezeOption = {"Freeze le joueur", "Defreeze le joueur"}
local MoneyGiveOption = {"Liquide", "Argent sale"}
local ItemGiveOption = {"Item", "Arme"}

local SelectedPlayer = {}
local SelectedReport = {}

local NoClip = {
    Camera = nil,
    Speed = 1.0
}

OnlinePlayers = {}

local AntiSpamReport = false

function ToggleMenu(type) 
	if InServiceAdmin then
        if type == 'staff' and ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
			openAdminMenu()
        elseif type == 'report' and ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
			openAdminReportMenu()
        end
	  else
		openAdminServiceMenu(type)
	  end
end

RegisterCommand("+noclip", function()
	if ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
		admin_no_clip()
	end
end, false)

RegisterCommand("+adminmenu", function()
	if ESX.PlayerData.group and ESX.PlayerData.group ~= "user" then
	ToggleMenu('staff')
	end
end, false)

RegisterKeyMapping("+adminmenu", "Menu Staff", "keyboard", "f10")
RegisterKeyMapping("+noclip", "Activer / désactiver Noclip", "keyboard", "f2")


RegisterNetEvent("admin:receivemessage")
AddEventHandler("admin:receivemessage", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(ESX.PlayerData.cache.playerped)
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)


function setUniformStaff()
	TriggerEvent('caruiskinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if StaffUniforms.male ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, StaffUniforms.male)
			end
		else
			if StaffUniforms.female ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, StaffUniforms.female)
			end
		end
	end)
end

function openAdminServiceMenu(menu)
	AdminService = {
    Base = { Title = "staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "menu staff" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "service" then
        TriggerServerEvent("admin:Service", true)
		InServiceAdmin = true
		CloseMenu()
		Citizen.CreateThread(function()
			while InServiceAdmin do
				Citizen.Wait(5000)
				OnlinePlayers = GetOnlinePlayers()
			end
		end)
		setUniformStaff()
		if menu == 'staff' then
		openAdminMenu()
		elseif menu == 'report' then
		openAdminReportMenu()
		end
      end
    end
  },

Menu = {
    ["menu staff"] = {
      b = {
        {name = "Mode Staff", action = "service", checkbox = InServiceAdmin},
      }
    },
}

}

CreateMenu(AdminService)
end

function openAdminMenu()
AdminMenu = {}

AdminMenu = {
    Base = { Title = "Staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "menu staff" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)

	  if btn.action == "playerslist" then
		AdminMenu.Menu["liste joueurs"].b = {{name = "rechercher un id ou uuid", action = "searchplayer", idplayer = 0, ask = "→", askX = true}}
		ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
			for k,v in pairs(playerlist) do
				if v.name then
					table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] "..v.name.."", idplayer = v.id, action = "actionplayer"})
				elseif v.name == nil then
					table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] ".."Unknown".."", idplayer = v.id, action = "actionplayer"})
				end
			end
			OpenMenu("liste joueurs")
		end)
	  elseif btn.action == "stafflist" then
		AdminMenu.Menu["liste joueurs"].b = {{name = "rechercher un id ou uuid", action = "searchplayer", idplayer = 0, ask = "→", askX = true}}
		ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
			for k,v in pairs(playerlist) do
				if v.group ~= "user" then
				    if v.name then
					    table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] "..v.name.."", idplayer = v.id, action = "actionplayer"})
				    elseif v.name == nil then
					    table.insert(AdminMenu.Menu["liste joueurs"].b, {name = v.addoncolor .. "["..v.id .. " | " .. v.uuid .."] ".."Unknown".."", idplayer = v.id, action = "actionplayer"})
				    end
			    end
			end
			OpenMenu("liste joueurs")
		end)
	  elseif btn.action == "staffaction" then
		CloseMenu()
		OpenAdminPersonalMenu()

	  elseif btn.action == "searchplayer" then
		local msg = KeyboardInput("ADMIN_FILTER", "ID ou UUID du joueur rechercher ?", "", 8)
		if not msg then return end
		if tonumber(msg) then
		  AdminMenu.Menu["liste joueurs"].b = {}
		 ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
		  for k,v in pairs(playerlist) do
		   if tonumber(v.id) == tonumber(msg) then
		   table.insert(AdminMenu.Menu["liste joueurs"].b, {name = "["..v.id.. " | " .. v.uuid .. "] "..v.name.."", idplayer = v.id, action = "actionplayer"})
		   end
		  end
		  OpenMenu("liste joueurs")
		 end)
		else 
		AdminMenu.Menu["liste joueurs"].b = {}
		 ESX.TriggerServerCallback("admin:GetActivePlayers", function(playerlist)
		  for k,v in pairs(playerlist) do
		   if v.uuid == msg then
		   table.insert(AdminMenu.Menu["liste joueurs"].b, {name = "["..v.id.. " | " .. v.uuid .. "] "..v.name.."", idplayer = v.id, action = "actionplayer"})
		   end
		  end
		  OpenMenu("liste joueurs")
		 end)
		end

	  elseif btn.action == "actionplayer" then
		SelectedPlayer = btn.idplayer
		AdminMenu.Menu["joueur"].b[1] = {name = btn.name, action = "null"}
		OpenMenu("joueur")

	  elseif btn.action == "message" then
		local msg = KeyboardInput("ADMIN_MSG", "Votre message ?", "", 100)
        if msg ~= nil then
        TriggerServerEvent("admin:SendMessageToPlayer", tonumber(SelectedPlayer), msg)
		end

	  elseif btn.action == "revive" then
		TriggerServerEvent("ambulance:revive", tonumber(SelectedPlayer), true)

	  elseif btn.action == "playertome" then
        TriggerServerEvent("admin:TeleportPlayerToMe", tonumber(SelectedPlayer), ESX.PlayerData.cache.coords)

	  elseif btn.action == "gotoplayer" then
		if noclipse == false then
		admin_no_clip()
		end
		TriggerServerEvent("admin:GoToPlayer", tonumber(SelectedPlayer))

	  elseif btn.action == "freeze" then
		if btn.slidenum == 1 then
		 TriggerServerEvent("admin:freeze", tonumber(SelectedPlayer), true)
		elseif btn.slidenum == 2 then
		 TriggerServerEvent("admin:freeze", tonumber(SelectedPlayer), false)
		end

	  elseif btn.action == "ban" then
		local msg = KeyboardInput("ADMIN_BAN", "Raison du ban ?", "", 100)
        if msg ~= nil then
		  if btn.slidenum == 1 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 1)
		  elseif btn.slidenum == 2 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 2)
		  elseif btn.slidenum == 3 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 3)
		  elseif btn.slidenum == 4 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 7)
		  elseif btn.slidenum == 5 then
			TriggerServerEvent("BanSql:ban", tonumber(SelectedPlayer), msg, 0)
		  end
		end

	  elseif btn.action == "kick" then
		local msg = KeyboardInput("ADMIN_KICK", "Raison du kick ?", "", 100)
        if msg ~= nil then
		TriggerServerEvent("admin:kick", tonumber(SelectedPlayer), msg)
		end
	  
	  elseif btn.action == "announce" then
		local msg = KeyboardInput("ADMIN_ANNOUNCE", "Votre annonce...", "", 100)
        if msg ~= nil then
			TriggerServerEvent('esx:adminannounce', '~y~Annonce', msg, 5)
		end



  elseif btn.action == "tx" then
    local playerId = PlayerId()
    local adminName = GetPlayerName(playerId)

    if adminName and adminName ~= "" then
        local msg = KeyboardInput("ADMIN_ANNOUNCE", "Votre annonce...", "", 100)

        if msg and msg ~= "" then
            TriggerEvent('txcl:showAnnouncement', msg, adminName)
        else
            print("Aucune annonce saisie.")
        end
    else
        print("Nom d'administrateur non valide.")
    end


	  elseif btn.action == "service" then
		TriggerServerEvent("admin:Service", false)
		IDActive = false
		InServiceAdmin = false
		CloseMenu()
		TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)
		openAdminServiceMenu("staff")
	  elseif btn.action == "givemenu" then
		OpenMenu("give")
	elseif btn.action == "setjob" then
		local job = KeyboardInput("ADMIN_SETJOB", "Le métier", "", 100)
        if job ~= nil then
			local grade = KeyboardInput("ADMIN_SETJOB_GRADE", "Le grade", "", 1)
            if tonumber(grade) ~= nil then
				
		TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 1)
			end
		end
	elseif btn.action == "setjob2" then
		local job = KeyboardInput("ADMIN_SETJOB2", "Le gang", "", 100)
        if job ~= nil then
			local grade = KeyboardInput("ADMIN_SETJOB2_GRADE", "Le grade", "", 1)
            if tonumber(grade) ~= nil then
				
		TriggerServerEvent("admin:setJob", tonumber(SelectedPlayer), job, grade, 2)
			end
		end
	elseif btn.action == "givemoney" then
		exports['putin-dialog']:showDialog(
			'unique_dialog_givemoney', 
			'Somme à se give', 
			'0', 
			8, 
			'recktification66k', 
			function(amount)
				local amountNumber = tonumber(amount)
				if amountNumber then
					if btn.slidenum == 1 then
						TriggerServerEvent('admin:give', 'money', 'cash', amountNumber)  
						CloseMenu()
					elseif btn.slidenum == 2 then 
						TriggerServerEvent('admin:give', 'money', 'black_money', amountNumber)
						CloseMenu()
					end
				else
					ESX.ShowNotification("Montant invalide.")
				end
			end, 
			function()
				ESX.ShowNotification("Vous avez annulé l'action")
			end, 
			false, 
			true
		)	
	elseif btn.action == "giveitem" then
		if btn.slidenum == 1 then
			-- Demande l'item
			exports['putin-dialog']:showDialog(
				'unique_dialog_item', 
				'Item à se Give', 
				'', 
				30, 
				'recktification66k', 
				function(item)
					if item and item ~= "" then
						-- Demande la quantité
						exports['putin-dialog']:showDialog(
							'unique_dialog_amount', 
							'Nombre d\'items', 
							'', 
							3, 
							'recktification66k', 
							function(amount)
								amount = tonumber(amount)
								if amount then
									TriggerServerEvent('admin:give', 'item', item, amount)
									CloseMenu()
								else
									ESX.ShowNotification("Montant invalide.")
								end
							end, 
							function()
								ESX.ShowNotification("Vous avez annulé l'action.")
							end, 
							false, 
							true
						)
					else
						ESX.ShowNotification("Item invalide.")
					end
				end, 
				function()
					ESX.ShowNotification("Vous avez annulé l'action.")
				end, 
				false, 
				true
			)
			
		elseif btn.slidenum == 2 then
			-- Demande l'arme
			exports['putin-dialog']:showDialog(
				'unique_dialog_weapon', 
				'Arme à se Give', 
				'', 
				30, 
				'recktification66k', 
				function(weapon)
					if weapon and weapon ~= "" then
						-- Demande les munitions
						exports['putin-dialog']:showDialog(
							'unique_dialog_ammo', 
							'Munitions', 
							'', 
							3, 
							'recktification66k', 
							function(amount)
								amount = tonumber(amount)
								if amount then
									TriggerServerEvent('admin:give', 'weapon', weapon, amount)
									CloseMenu()
								else
									ESX.ShowNotification("Montant invalide.")
								end
							end, 
							function()
								ESX.ShowNotification("Vous avez annulé l'action.")
							end, 
							false, 
							true
						)
					else
						ESX.ShowNotification("Arme invalide.")
					end
				end, 
				function()
					ESX.ShowNotification("Vous avez annulé l'action.")
				end, 
				false, 
				true
			)
		end	
		elseif btn.action == "reports" then
			CloseMenu()
			openAdminReportMenu()
		elseif btn.action == "register" then
			TriggerServerEvent("admin:MakePlayerRegister", tonumber(SelectedPlayer))
		elseif btn.action == "jail" then
			local time = 10
			  if btn.slidenum == 1 then
				time = 10
			  elseif btn.slidenum == 2 then
				time = 30
			  elseif btn.slidenum == 3 then
				time = 60
			  elseif btn.slidenum == 4 then
				time = 24 * 60
			  elseif btn.slidenum == 5 then
				time = 7 * 24 * 60
			  elseif btn.slidenum == 6 then
				time = 0
			  end
			  if btn.slidenum == 6 then
			  TriggerServerEvent('admin:JailPlayer', tonumber(SelectedPlayer), time, "")
			  else
				local reason = KeyboardInput("ADMIN_JAIL", "Raison du jail ?", "", 100)
				if reason ~= nil then
					TriggerServerEvent('admin:JailPlayer', tonumber(SelectedPlayer), time, reason)
				end
			  end
		elseif btn.action == "unjail" then
			TriggerServerEvent('admin:Unjail', tonumber(SelectedPlayer))
		elseif btn.action == "wipe" then
			local reason = KeyboardInput("ADMIN_WIPE", "Raison du wipe ?", "", 100)
			if reason ~= nil then
			    TriggerServerEvent("admin:WipeArme", tonumber(SelectedPlayer), reason)
			end
		end
    end
  },

  Menu = {
    ["menu staff"] = {
      b = {
		{name = "Mode Staff", action = "service", checkbox = InServiceAdmin},
		{name = "Liste des joueurs en ligne", action = "playerslist", ask = "→", askX = true},
		{name = "Liste des staffs en ligne", action = "stafflist", ask = "→", askX = true},
		{name = "Voir les reports", action = "reports", ask = "→", askX = true},
		{name = "Faire Une Annonce Tx", action = "tx", ask = "→", askX = true},
		{name = "Actions staff", action = "staffaction", ask = "→", askX = true}
      }
	},
	["liste joueurs"] = {
		b = {}
	},
	["give"] = {
		b = {
			{name = "Give Argent", action = "givemoney", slidemax = MoneyGiveOption},
		    {name = "Give Item", action = "giveitem", slidemax = ItemGiveOption},
		}
	},
	["joueur"] = {
      b = {
		{name = "NULL", action = "null"},
		{name = "Me téléporter au joueur", action = "gotoplayer", ask = "→", askX = true},
		{name = "Téléporter le joueur à moi", action = "playertome", ask = "→", askX = true},
		{name = "Réanimer", action = "revive", ask = "→", askX = true},
		{name = "Envoyer un message privé", action = "message", ask = "→", askX = true},
		{name = "Wipe armes", action = "wipe", ask = "→", askX = true}

      }
	},
	["actions anticheat"] = {
		b = {
			{name = "Bientôt", action = "nullg"}
		}
	}
  }

  }

if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "superadmin" then
	table.insert(AdminMenu.Menu["joueur"].b, {name = "Register", action = "register", ask = "→", askX = true})
	table.insert(AdminMenu.Menu["joueur"].b, {name = "Mettre un métier", action = "setjob", ask = "→", askX = true})
	table.insert(AdminMenu.Menu["joueur"].b, {name = "Mettre une organisation", action = "setjob2", ask = "→", askX = true})
end

table.insert(AdminMenu.Menu["joueur"].b, {name = "Freeze", action = "freeze", slidemax = FreezeOption})

--table.insert(AdminMenu.Menu["menu staff"].b, {name = "Actions Anticheat", action = "Tarekacactions", ask = "→", askX = true})

if ESX.PlayerData.group == "admin" then
table.insert(AdminMenu.Menu["menu staff"].b, {name = "Faire une annonce", action = "announce", ask = "→", askX = true})
end

if ESX.PlayerData.group == "admin" or ESX.PlayerData.group == "superadmin" then
	table.insert(AdminMenu.Menu["menu staff"].b, {name = "Options Give", action = "givemenu", ask = "→", askX = true})
end

table.insert(AdminMenu.Menu["joueur"].b, {name = "Jail", action = "jail", slidemax = JailOption})
table.insert(AdminMenu.Menu["joueur"].b, {name = "Kick", action = "kick", ask = "→", askX = true})
table.insert(AdminMenu.Menu["joueur"].b, {name = "Bannir", action = "ban", slidemax = BanOption})

CreateMenu(AdminMenu)
end

function OpenAdminPersonalMenu()
AdminPersonalMenu = {}

AdminPersonalMenu = {
    Base = { Title = "Staff", HeaderColor = {255, 0, 0} },
    Data = { currentMenu = "actions staff " },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
	  if btn.action == "noclip" then
		admin_no_clip()

	  elseif btn.action == "idname" then
		ShowNames()

	  elseif btn.action == "gotoplayer" then
		local msg = KeyboardInput("ADMIN_TP", "ID du joueur", "", 5)
        if tonumber(msg) ~= nil then
        if noclipse == false then
        admin_no_clip()
        end
        TriggerServerEvent("admin:GoToPlayer", tonumber(msg))
        end

	  elseif btn.action == "playertome" then
		local msg = KeyboardInput("ADMIN_TP", "ID du joueur", "", 5)
		if tonumber(msg) ~= nil then
		 TriggerServerEvent("admin:TeleportPlayerToMe", tonumber(msg), ESX.PlayerData.cache.coords)
		end

	  elseif btn.action == "reviveme" then
		TriggerServerEvent("ambulance:revive", GetPlayerServerId(PlayerId()), true)

	  elseif btn.action == "revive" then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent("ambulance:revive", GetPlayerServerId(closestPlayer), true)
		end

	  elseif btn.action == "repairveh" then
		admin_vehicle_repair()

	  elseif btn.action == "delveh" then
		local vehicle = GetClosestVehicle(ESX.PlayerData.cache.coords, 2.0, 0, 71)
		if vehicle then
			ESX.Game.DeleteVehicle(vehicle)
		end
	  elseif btn.action == "spawnveh" then
		ESX.Game.SpawnVehicle(btn.model, ESX.PlayerData.cache.coords, 0, function(vehicle)
			TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped,  vehicle, -1)
			local plate = "ADM "..math.random(100, 900)
			SetVehicleNumberPlateText(vehicle, plate)
			CloseMenu()
		end, "staff")
	elseif btn.action == "menuveh" then
		OpenMenu("spawn vehicule ")
	  elseif btn.action == "gunveh" then
		TriggerEvent("esx:delGunVeh")
		DelGunVeh = not DelGunVeh
      end
    end
  },

  Menu = {
    ["actions staff "] = {
      b = {
		{name = "Se revive", action = "reviveme", ask = "→", askX = true},
		{name = "Spawn un véhicule", action = "menuveh", ask = "→", askX = true},
		{name = "Réparer le véhicule", action = "repairveh", ask = "→", askX = true},
		{name = "Supprimer véhicule à proximité", action = "delveh", ask = "→", askX = true},
		{name = "Mettre/Enlever le noclip", action = "noclip", checkbox = noclipse},
		{name = "Afficher/Cacher les ID", action = "idname", checkbox = IDActive},
		{name = "Pistolet véhicules", action = "gunveh", checkbox = DelGunVeh},
		{name = "Pistolet joueurs", action = "gunveh", checkbox = DelGunVeh},
      }
	},
	["spawn vehicule "] = {
		b = {
			{name = "Sentinel", action = "spawnveh", model = "sentinel"},
			{name = "BF400", action = "spawnveh", model = "bf400"}
		}
	}
  }

  }

CreateMenu(AdminPersonalMenu)
end

function openAdminReportMenu()
AdminMenuReport = {}

AdminMenuReport = {
	Base = { Title = "reports", HeaderColor = {255, 0, 0} },
	Data = { currentMenu = "reports" },
	
	Events = {
	  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		if btn.action == "actionreport" then
		SelectedReport = btn
		AdminMenuReport.Menu["reportsaction"].b = {
		{name = "Report numéro "..btn.numreport.."", action = "null"},
		{name = "ID/UUID/Nom: "..btn.source.." | "..btn.uuid.." | "..btn.nameplayer.."", action = "null"},
		{name = "Message: "..btn.message, action = "null"},
		{name = "--------------------", action = "null"},
		{name = "Me téléporter au joueur", action = "gotoplayer", ask = "→", askX = true},
		{name = "Téléporter le joueur à moi", action = "playertome", ask = "→", askX = true},
		{name = "Réanimer le joueur", action = "revive", ask = "→", askX = true},
		{name = "Fermer le ticket", action = "closereport", ask = "→", askX = true}
		}
		TriggerServerEvent("admin:takingReport", btn.source)
		OpenMenu("reportsaction")
		elseif btn.action == "gotoplayer" then
	     if noclipse == false then
		   admin_no_clip()
		 end
		 TriggerServerEvent("admin:GoToPlayer", tonumber(SelectedReport.source))
		elseif btn.action == "playertome" then
		  if noclipse == false then
			admin_no_clip()
		  end
		  TriggerServerEvent("admin:TeleportPlayerToMe", SelectedReport.source, ESX.PlayerData.cache.coords)
		elseif btn.action == "revive" then
		  TriggerServerEvent("ambulance:revive", tonumber(SelectedReport.source), true)
		elseif btn.action == "closereport" then
		  TriggerServerEvent("admin:DeleteReport", SelectedReport.source)
		  CloseMenu()
	    end
	end
	},
	
	Menu = {
	["reports"] = {
	  b = {}
	},
	["reportsaction"] = {
	  b = {}
	},
  }	
}

ESX.TriggerServerCallback("admin:getReports", function(reports)
	for k,v in pairs(reports) do
		table.insert(AdminMenuReport.Menu["reports"].b, {name = "~r~["..v.source.."] "..v.name..": "..v.message.."~s~", message = v.message, source = v.source, uuid = v.uuid, nameplayer = v.name, numreport = v.num, action = "actionreport"})
	end
	CreateMenu(AdminMenuReport)
end)
end

RegisterNetEvent("admin:toggleNoclip")
AddEventHandler("admin:toggleNoclip", function()
	if ESX.PlayerData.group ~= "user" then
	admin_no_clip()
	end
end)

AddEventHandler("admin:delVeh", function(NetID)
for vehicle in EnumerateVehicles() do
  if DoesEntityExist(vehicle) then
   if NetworkGetNetworkIdFromEntity(vehicle) == NetID then
	NetworkRequestControlOfEntity(vehicle)
  	local timeout = 1000
  	while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
      Citizen.Wait(100)
      timeout = timeout - 100
  	end
  	SetEntityAsMissionEntity(vehicle, true, true)
  	local timeout = 2000
  	while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
      Citizen.Wait(100)
      timeout = timeout - 100
  	end
	DeleteEntity(vehicle)
   end
  end
end
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(5)
	  if frozen then
		FreezeEntityPosition(ESX.PlayerData.cache.playerped, frozen)
		if ESX.PlayerData.cache.invehicle then
		FreezeEntityPosition(ESX.PlayerData.cache.vehicle, frozen)
		end 
	  else
	  Citizen.Wait(1000)
	end
  end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if InServiceAdmin then
            OnlinePlayers = GetOnlinePlayers()
        end
    end
end)]]

function GetOnlinePlayers()
    local clientPlayers = false;
    ESX.TriggerServerCallback('esx:retrievePlayers', function(players)
        clientPlayers = players
    end)

    while not clientPlayers do
        Citizen.Wait(5)
    end
    return clientPlayers
end

function RetrievePlayerDataByID(source)
    local player = {}
    for i, v in pairs(OnlinePlayers) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

function ShowNames()
    IDActive = not IDActive 
    if IDActive then
        Citizen.CreateThread(function()
            while IDActive do
				for _,v in pairs(GetActivePlayers()) do
				 local PlayerID = GetPlayerServerId(v)
				 local player = RetrievePlayerDataByID(PlayerID)
				 if player and player.job and player.job2 and player.uuid then
                    local otherPed = GetPlayerPed(v)
                    if #(ESX.PlayerData.cache.coords - GetEntityCoords(otherPed, false)) < 100.0 then
						gamerTags[v] = CreateFakeMpGamerTag(otherPed, " ("..PlayerID.. ' | ' .. player.uuid ..") - "..GetPlayerName(v).." [" .. player.job .. ' - ' .. player.job2 .. "]", false, false, "", 0)
						SetMpGamerTagName(gamerTags[v]," ("..PlayerID.. ' | ' .. player.uuid .. ") - "..GetPlayerName(v).." [" .. player.job .. ' - ' .. player.job2 .. "]")   
                        SetMpGamerTagVisibility(gamerTags[v], 2, true) -- HealtArmour
					
						if player.color then
						SetMpGamerTagColour(gamerTags[v], 0, player.color)
						else
						SetMpGamerTagColour(gamerTags[v], 0, 225)
						end

						SetMpGamerTagAlpha(gamerTags[v], 4, 255) -- Vocal
                		SetMpGamerTagAlpha(gamerTags[v], 2, 255) -- HealtArmour
                    else
                        RemoveMpGamerTag(gamerTags[v])
                        gamerTags[v] = nil
					end
				end
                end
                Wait(500)
            end

            for _, v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
                gamerTags[v] = nil
            end
        end)
    end
end





function OpenPlayerMenu(playerId)
    local playerName = GetPlayerName(playerId) 
    local playerData = RetrievePlayerDataByID(playerId) 

    local playerMenu = {
        Base = { Title = "Menu Joueur", HeaderColor = {255, 0, 0} },
        Data = { currentMenu = "menu joueur" },

        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "revive" then
                    TriggerServerEvent("ambulance:revive", playerId, true)
                elseif btn.action == "teleport" then
                    TriggerServerEvent("admin:TeleportPlayerToMe", playerId, ESX.PlayerData.cache.coords)
                elseif btn.action == "freeze" then
                    TriggerServerEvent("admin:freeze", playerId, true)
                end
                CloseMenu()
            end
        },

        Menu = {
            ["menu joueur"] = {
                b = {
                    {name = "R�animer", action = "revive"},
                    {name = "T�l�porter � moi", action = "teleport"},
                    {name = "Geler le joueur", action = "freeze"},
                    -- Ajoutez d'autres options ici
                }
            }
        }
    }

    CreateMenu(playerMenu)
end















-- FONCTION NOCLIP 
local noclip = false
local noclip_speed = 1.5

function admin_no_clip()
  noclip = not noclip
  noclipse = not noclipse
  if noclip then 
	SetEntityInvincible(ESX.PlayerData.cache.playerped, true)
    SetEntityVisible(ESX.PlayerData.cache.playerped, false, false)
	Citizen.CreateThread(function()
		while noclip do
		  Citizen.Wait(5)
			local x,y,z = table.unpack(GetEntityCoords(ESX.PlayerData.cache.playerped))
			local heading = GetEntityHeading(ESX.PlayerData.cache.playerped)
			local dx,dy,dz = getCamDirection(heading)
	  
			SetEntityVelocity(ESX.PlayerData.cache.playerped, 0.0001, 0.0001, 0.0001)
	  
			if IsControlPressed(0,32) then -- MOVE UP
			  x = x+noclip_speed*dx
			  y = y+noclip_speed*dy
			  z = z+noclip_speed*dz
			end
	  
			if IsControlPressed(0,269) then -- MOVE DOWN
			  x = x-noclip_speed*dx
			  y = y-noclip_speed*dy
			  z = z-noclip_speed*dz
			end

			if IsControlPressed(0,34) then -- MOVE LEFT
				dx,dy,dz = getCamDirection(heading + 90)
				x = x+noclip_speed*dx
				y = y+noclip_speed*dy
				z = z+noclip_speed*dz
			end

			if IsControlPressed(0,9) then -- MOVE RIGHT
				dx,dy,dz = getCamDirection(heading + 90)
				x = x-noclip_speed*dx
				y = y-noclip_speed*dy
				z = z-noclip_speed*dz
			end

			if IsControlPressed(0, 334) then
				if (noclip_speed - 0.1 >= 0.1) then
					noclip_speed = noclip_speed - 0.1
				end
			end
			if IsControlPressed(0, 335) then
				if (noclip_speed + 0.1 >= 0.1) then
					noclip_speed = noclip_speed + 0.1
				end
			end
	  
			SetEntityCoordsNoOffset(ESX.PlayerData.cache.playerped,x,y,z,true,true,true)
		end
	  end)
  else 
	SetEntityInvincible(ESX.PlayerData.cache.playerped, false)
    SetEntityVisible(ESX.PlayerData.cache.playerped, true, false)
  end
end

function getCamDirection(theheading)
	local heading = GetGameplayCamRelativeHeading() + theheading
	local pitch = GetGameplayCamRelativePitch()
  
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
  
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
	  x = x/len
	  y = y/len
	  z = z/len
	end
  
	return x,y,z
  end
  

function isNoclip()
  return noclip
end

-- FIN NOCLIP

-- Réparer vehicule
function admin_vehicle_repair()
SetVehicleFixed(ESX.PlayerData.cache.vehicle)
SetVehicleDirtLevel(ESX.PlayerData.cache.vehicle, 0.0)
end
-- FIN Réparer vehicule

AddEventHandler("admin:GoToPlayerCli", function(src)
TriggerServerEvent("admin:GoPlayer", src, ESX.PlayerData.cache.coords)
end)

AddEventHandler("admin:GoToPlayerCli2", function(coords)
SetEntityCoords(ESX.PlayerData.cache.playerped, coords.x, coords.y, coords.z)
end)

AddEventHandler("admin:requestSpectate", function(playerId)
	spectatePlayer(GetPlayerPed(playerId), playerId, GetPlayerName(playerId))
end)

AddEventHandler("admin:FreezePlayer", function(toggle)
	frozen = toggle
	FreezeEntityPosition(ESX.PlayerData.cache.playerped, frozen)
	if ESX.PlayerData.cache.invehicle then
		FreezeEntityPosition(ESX.PlayerData.cache.vehicle, frozen)
	end 
end)

RegisterCommand("report", function(source, args, rawCommand)
	if #args < 1 then
		ESX.ShowNotification("~r~Utilisation de la commande invalide.~s~", "error")
		return
	end

	local MessageFinal = ""

	for k,v in pairs(args) do
	 MessageFinal = MessageFinal..v.." "
	end

	if not AntiSpamReport then
     TriggerServerEvent("admin:sendReport", MessageFinal, GetPlayerName(PlayerId()))
	 ESX.ShowNotification("Votre report à bien été envoyé ! 🔍", "success")
     AntiSpamReport = true
     Citizen.SetTimeout(1000, function()
      AntiSpamReport = false
     end)
    else
      ESX.ShowNotification("Vous devez attendre un peu avant de refaire un report.", "info")
    end
end)

RegisterNetEvent('admin:teleport')
AddEventHandler('admin:teleport', function(x, y, z)
	SetEntityCoords(ESX.PlayerData.cache.playerped, x, y, z)
end)

RegisterNetEvent('admin:receiveReportNotification')
AddEventHandler('admin:receiveReportNotification', function()
	if ESX.PlayerData.group ~= "user" and InServiceAdmin then
		ESX.ShowNotification('Un Nouveau report vous attend !', "info")
	end
end)