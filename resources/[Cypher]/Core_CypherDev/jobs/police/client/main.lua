local isNearPolice = false
local nearPolice = nil
local isPolice = false
local AleardyStartedPolice = false
local AleardyStartedNearPolice = false
local PoliceMenuOpen = ""
local playerInService = false
local PoliceFines = {
	{name = "Vol de voiture", price = 10000},
	{name = "Conduite sans permis", price = 5000},
	{name = "Délit de fuite", price = 20000},
	{name = "Excès de vitesse", price = 5000},
	{name = "Vente de drogue", price = 25000},
	{name = "Possession de drogue", price = 25000},
	{name = "Tir sur civil", price = 50000},
	{name = "Tir sur agent", price = 80000},
	{name = "Outrage à agent", price = 5000},
	{name = "Braquage", price = 50000}
}
local renfortBlips = {}
local JailOption = {"10 minutes", "15 minutes", "20 minutes", "30 minutes", "Sortir"}

local PoliceVehicles = {
    [GetHashKey('policeb')] = true,
    [GetHashKey('police3')] = true,
    [GetHashKey('ghispo2')] = true, 
    [GetHashKey('insurgent2')] = true,
    [GetHashKey('riot')] = true,
    [GetHashKey('polmav')] = true,
    [GetHashKey('buzzard2')] = true
}

local BlipsData = {
    ["south"] = {
        sprite = 60,
        scale = 1.2,
        color = 29,
        display = 4,
        asShortRange = true
    }
}

function StartPolice()
    while not ESX.PlayerData.PassJoin do
        Wait(5)
    end
    if AleardyStartedPolice then 
        return
    end
    isPolice = true
    AleardyStartedPolice = true
    Citizen.CreateThread(function()
        while isPolice do
            if ESXConfig.Police.PoliceStations[ESX.PlayerData.job.name] then
				for key, value in pairs(ESXConfig.Police.PoliceStations[ESX.PlayerData.job.name].zones) do 
					if #(ESX.PlayerData.cache.coords - value) < 10 then
						isNearPolice = true
						nearPolice = ESXConfig.Police.PoliceStations[ESX.PlayerData.job.name]
						Found = true
					end
				end
            else
                isPolice = false
                isNearPolice = false
                nearPolice = nil
                break
            end
            if isNearPolice and not AleardyStartedNearPolice then
                StartNearPolice()
            end
            Wait(2500)
        end
        isPolice = false
        isNearPolice = false
        nearPolice = nil
        AleardyStartedPolice = false
    end)
end

function StartNearPolice()
    if AleardyStartedNearPolice then
        return
    end
    AleardyStartedNearPolice = true
    Citizen.CreateThread(function()
        while isNearPolice do
            if ESXConfig.Police.PoliceStations[ESX.PlayerData.job.name] then
				for key, value in pairs(ESXConfig.Police.PoliceStations[ESX.PlayerData.job.name].zones) do 
                    local draw = true
                    if key == "boss" and ESX.PlayerData.job.grade_name ~= "boss" then
                        draw = false
                    end
                    if draw then
                    DrawMarker(1, value, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 50, 50, 204, 200, false, true, 2, false, false, false, false)
                    end
                if #(ESX.PlayerData.cache.coords - value) < 2 and PoliceMenuOpen == "" and draw then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au menu.")
                    if IsControlJustReleased(1, 38) then  
                        local success = false
						if key == "boss" and ESX.PlayerData.job.grade_name == "boss" then      
                            success = true
                            OpenBossMenu('police', 1)
						elseif key == "cloakrooms" then
                            success = true
							OpenCloakroomMenuPolice()
                        elseif key == "armory" then
                            success = true
                            OpenArmoryMenuPolice()
                        elseif key == "cars" or key == "helicopters" then
                            OpenVehicleSpawnerPolice(key)
						end
                        if success then
                            PoliceMenuOpen = key              
                        end
                    end
                elseif #(ESX.PlayerData.cache.coords - value) >= 2 and PoliceMenuOpen == key then
                    PoliceMenuOpen = ""
                    CloseMenu()
                end
			    end
            end
            Wait(5)
        end
        AleardyStartedNearPolice = false
    end)
end

function OpenVehicleSpawnerPolice(type)
	PoliceVehicleMenu = {
		Base = { Title = "Garage", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "garage lspd" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == "garage" then
				PoliceVehicleMenu.Menu["garage"].b = {}
				if type == 'cars' then
				
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Voiture de patrouille', model = 'police3', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Buffalo', model = 'polbuffalop', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Scout', model = 'polscoutp', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Gauntlet', model = 'polgauntletp', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'LandStalker', model = 'polstalkerp', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Torrence', model = 'poltorencep', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'CaraCara', model = 'polcarap', action = "spawnveh"})

					if ESX.PlayerData.job.grade_name ~= "recruit" and ESX.PlayerData.job.grade_name ~= "officer" and ESX.PlayerData.job.grade_name ~= "sergeant" then
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'VIR', model = 'ghispo2', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Vehicule Swat', model = 'inaugural2', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Bus', model = 'coach2', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Insurgent', model = 'insurgent2', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Riot', model = 'swatinsur', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Felon', model = 'bcpd10', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Buffalo STX Banalisé ', model = 'bufsxtrafpol', action = "spawnveh"})
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Scout Banalisé', model = 'nscouttrafpol', action = "spawnveh"})
					end
					table.insert(PoliceVehicleMenu.Menu["garage"].b, {name = 'Moto', model = 'polbikeb', action = "spawnveh"})
				end
				OpenMenu('garage')
			elseif btn.action == "spawnveh" then
				ESX.Game.SpawnVehicle(btn.model, ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading, function(vehicle)
					local plate = 'POLI'..math.random(100, 900)
					plate = string.gsub(plate, " ", "")
					SetVehicleNumberPlateText(vehicle, plate)
					TaskWarpPedIntoVehicle(ESX.PlayerData.cache.playerped, vehicle, -1)
					TriggerServerEvent("vehiclelock:preterkey", plate)
					ESX.ShowNotification('Votre véhicule a été sorti.')
					CloseMenu()
				end, "job")
			elseif btn.action == "delveh" then	
				if PoliceVehicles[GetEntityModel(ESX.PlayerData.cache.vehicle)] then
				    ESX.Game.DeleteVehicle(ESX.PlayerData.cache.vehicle)
				    ESX.ShowNotification('Le véhicule à bien été rangé.')
				    CloseMenu()
                else
                    ESX.ShowNotification('Vous ne pouvez pas ranger ce véhicule.')
				end 
			end
		end,
        onExited = function()
            PoliceMenuOpen = ""
        end
	  },
	
	  Menu = {
		["garage lspd"] = { b = {} },
		["garage"] = { b = {} }
	 }
	}
	if ESX.PlayerData.cache.invehicle then
		table.insert(PoliceVehicleMenu.Menu["garage lspd"].b, {name = 'Ranger le véhicule', action = 'delveh'})
	  else
		table.insert(PoliceVehicleMenu.Menu["garage lspd"].b, {name = 'Sortir un véhicule', action = 'garage'})
	  end
	CreateMenu(PoliceVehicleMenu)
end

function OpenCloakroomMenuPolice()
	PoliceCloakroomMenu = {
		Base = { Title = "Vestiaire", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "vestiaire" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == 'wear' then
				cleanPlayer(ESX.PlayerData.cache.playerped)
				if btn.value == 'citizen_wear' then
					TriggerServerEvent("player:serviceOff")
					TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin)
				else
					TriggerServerEvent("player:serviceOn")
					if btn.value ~= "boss_wear" then
			        setUniformPolice(btn.value, ESX.PlayerData.cache.playerped)
					end
				end
			end
		end,
        onExited = function()
            PoliceMenuOpen = ""
        end
	  },
	
	  Menu = {
		["vestiaire"] = {
			b = {
				{ name = 'Tenue civil', action = "wear", value = 'citizen_wear' },
				{ name = 'Gilet pare-balles', action = "wear", value = 'bullet_wear' }
			}
		}
	 }
	}

	if ESX.PlayerData.job.grade_name == 'recruit' then
		table.insert(PoliceCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'recruit_wear'})
	elseif ESX.PlayerData.job.grade_name == 'officer' then
		table.insert(PoliceCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'officer_wear'})
	elseif ESX.PlayerData.job.grade_name == 'sergeant' then
		table.insert(PoliceCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'sergeant_wear'})
	elseif ESX.PlayerData.job.grade_name == 'lieutenant' then
		table.insert(PoliceCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = 'lieutenant_wear'})
	elseif ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(PoliceCloakroomMenu.Menu["vestiaire"].b, {name = 'Tenue policier', action = "wear", value = "boss_wear"})
	end
	
	CreateMenu(PoliceCloakroomMenu)
end

function setUniformPolice(job, playerPed)
	TriggerEvent('caruiskinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if ESXConfig.Police.PoliceUniforms[job].male ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, ESXConfig.Police.PoliceUniforms[job].male)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if ESXConfig.Police.PoliceUniforms[job].female ~= nil then
				TriggerEvent('caruiskinchanger:loadClothes', skin, ESXConfig.Police.PoliceUniforms[job].female)
			else
				ESX.ShowNotification('Il n\'y a pas d\'uniforme à votre taille...')
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenArmoryMenuPolice(station)
	PoliceArmoryMenu = {
		Base = { Title = "Armurerie", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "armurerie" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.action == 'coffre' then
				CloseMenu()
				Wait(100)
		        TriggerEvent('coffre:OpenMenu', 1)
			elseif btn.action == 'buy_weapons' then
				CloseMenu()
				Wait(100)
				OpenBuyWeaponsMenu()
			end
		end
	  },
	
	  Menu = {
		["armurerie"] = {
			b = {
				{ name = 'Gérer ses armes', action = 'buy_weapons' },
				{ name = 'Coffre', action = 'coffre' }
			}
		}
	 }
	}
	
	CreateMenu(PoliceArmoryMenu)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = ESX.PlayerData.cache.playerped

	BuyWeaponsMenu = {
		Base = { Title = "Armes", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "achat armes" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
			if btn.hasWeapon then ESX.ShowNotification('Vous possédez déjà cette arme !') return end
			ESX.TriggerServerCallback('policejob:buyWeapon', function(bought)
				if bought then
					CloseMenu()
					Wait(100)
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification('Vous ne pouvez pas acheter cette arme')
				end
			end, btn.weaponname, 1)
		end
	  },
	
	  Menu = {
		["achat armes"] = {
			b = {
				
			}
		}
	 }
	}
	for k,v in ipairs(ESXConfig.Police.PoliceWeapons[ESX.PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local label = {}

		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if hasWeapon then
			label = weapon.label .. ' ~r~' .. 'Acquis'
		else
			label = weapon.label
		end

		table.insert(BuyWeaponsMenu.Menu["achat armes"].b, {
			name = label,
			weaponLabel = weapon.label,
			weaponname = weapon.name,
			components = components,
			prix = v.price,
			hasWeapon = hasWeapon
		})
	end
	
	CreateMenu(BuyWeaponsMenu)
end

function OpenPoliceActionsMenu()
	PoliceMenu = {
		Base = { Title = "Police", HeaderColor = {169, 187, 232} },
		Data = { currentMenu = "police" },
	
		Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		if btn.action == "cit_interaction" then
			OpenMenu("police citoyen")
			return
		elseif btn.action == "annoncedejosh" then
			local customannounce = KeyboardInput("Votre annonce :", "", "", 999)
			TriggerServerEvent('josh:policejob:annonce', customannounce)
			return
		elseif btn.action == "car_interaction" then
			local playerPed = ESX.PlayerData.cache.playerped
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
			  OpenMenu("police vehicule")
			end
			return
		end
	
		if btn.action == "info_veh" then
			--
			return
		elseif btn.action == "openvehicle" then
			local playerPed = ESX.PlayerData.cache.playerped
			local coords = GetEntityCoords(playerPed)
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.Wait(10000)
				ClearPedTasksImmediately(playerPed)
	
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ESX.ShowNotification('Véhicule deverouiller.')
			end
			return
		elseif btn.action == "delvehicle" then
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
			  ESX.Game.DeleteVehicle(vehicle)
			end
			return
		elseif btn.action == "askrenforts" then
			OpenMenu("renforts")
			return
		  elseif btn.action == "renforts" then
			TriggerServerEvent("policejob:askForHelp", btn.thetype)
			return
		  elseif btn.action == "vehicleinfos" then
			local vehicle = ESX.Game.GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
				TriggerServerEvent("policejob:RequestVehicleInfos", GetVehicleNumberPlateText(vehicle))
			end
			return
		elseif btn.action == "camera_interact" then
			OpenMenu("camera interact")
		elseif btn.action == "camera1" then
			TriggerEvent('cctv:camera', 25) 
		elseif btn.action == "camera2" then
			TriggerEvent('cctv:camera', 26) 
		elseif btn.action == "camera3" then
			TriggerEvent('cctv:camera', 27)
		elseif btn.action == "camera4" then
			TriggerEvent('cctv:camera', 1) 
		elseif btn.action == "camera5" then
			TriggerEvent('cctv:camera', 2)
		elseif btn.action == "camera6" then
			TriggerEvent('cctv:camera', 3) 
		elseif btn.action == "camera7" then
			TriggerEvent('cctv:camera', 4) 
		elseif btn.action == "camera8" then
			TriggerEvent('cctv:camera', 5) 
		elseif btn.action == "camera9" then
			TriggerEvent('cctv:camera', 6) 
		end
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 1.0 then
	
		  if btn.action == "carteiden" then
			CloseMenu()
			Wait(10)
			OpenIdentityCardMenu(closestPlayer)
	
		  elseif btn.action == "search" then
			if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 3) or IsEntityDead(GetPlayerPed(closestPlayer)) then
			CloseMenu()
			StartBodySearch(GetPlayerServerId(closestPlayer))
			else
			ESX.ShowNotification("Impossible de fouiller une personne qui n'a pas les mains levées.")
			end
	
		  elseif btn.action == "handcuff" then
			local target, distance = ESX.Game.GetClosestPlayer()
			playerheading = ESX.PlayerData.cache.heading
			playerlocation = GetEntityForwardVector(ESX.PlayerData.cache.playerped)
			playerCoords = ESX.PlayerData.cache.coords
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('handcuff:on', target_id)
	
		  elseif btn.action == "unhandcuff" then
			local target, distance = ESX.Game.GetClosestPlayer()
			playerheading = ESX.PlayerData.cache.heading
			playerlocation = GetEntityForwardVector(ESX.PlayerData.cache.playerped)
			playerCoords = ESX.PlayerData.cache.coords
			local target_id = GetPlayerServerId(target)
			TriggerServerEvent('handcuff:off', target_id)
		  elseif btn.action == "drag" then
			TriggerServerEvent('handcuff:drag', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "in_vehicle" then
			TriggerServerEvent('handcuff:CypherVehicle', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "out_vehicle" then
			TriggerServerEvent('handcuff:OutVehicle', GetPlayerServerId(closestPlayer))
	
		  elseif btn.action == "facture" then
			PoliceMenu.Menu["amendes"].b = {{name = "Amende Personalisée", action = "customfinecitizen", ask = "→", askX = true}}
			for k, v in ipairs(PoliceFines) do
				table.insert(PoliceMenu.Menu["amendes"].b, {name = v.name, action = "finecitizen", fineprice = v.price, ask = "→", askX = true})
			end
			OpenMenu("amendes")
	
		  elseif btn.action == "finecitizen" then
			TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'police', 'Amende: '..btn.name..'', btn.fineprice, true)
			ESX.ShowNotification("Amende envoyé avec succès.")
			CloseMenu()
		  elseif btn.action == "customfinecitizen" then
			local name = KeyboardInput("POLICE_FINENAME", "Raison de l'amende", "", 9)
			if name then
			local amount = KeyboardInput("POLICE_FINEPRICE", "Somme de l'amende", "", 6)
			if amount and tonumber(amount) then
			TriggerServerEvent('billing:sendBill', GetPlayerServerId(closestPlayer), 'police', 'Amende: '..name..'', tonumber(amount), true)
			ESX.ShowNotification("Amende envoyé avec succès.")
			end
			end
			CloseMenu()
		  elseif btn.action == "openmen" then
			OpenMenu("police menotte")
		  elseif btn.action == "menuprison" then
			OpenMenu("prisons")
		  elseif btn.action == "prison" then
		if btn.station ~= "out" then
			local amount = KeyboardInput("POLICE_DURATIONJAIL", "Temps en prison (minutes)", "", 2)
			if tonumber(amount) and tonumber(amount) <= 20  then
				TriggerServerEvent("policejob:jailPlayer", GetPlayerServerId(closestPlayer), btn.station, tonumber(amount))
			end
		else
			TriggerServerEvent("policejob:jailPlayer", GetPlayerServerId(closestPlayer), "out", 0)
		end
		  end
		else
			ESX.ShowNotification("Personne à proximité.")
		end
	
		end
	  },
	
	  Menu = {
		["police"] = {
			b = {
			  {name = "Citoyen", action = "cit_interaction", ask = "→", askX = true},
			  {name = "Vehicule", action = "car_interaction", ask = "→", askX = true},
			  {name = "Demande de renforts", action = "askrenforts", ask = "→", askX = true},
			  {name = "Caméra de la ville", action = "camera_interact", ask = "→", askX = true},
			}
		  },
		["police citoyen"] = {
		  b = {
			{name = "Carte d'identité", action = "carteiden", ask = "→", askX = true},
			{name = "Menu menottes", action = "openmen", ask = "→", askX = true},
			{name = "Mettre une amende", action = "facture", ask = "→", askX = true},
			{name = "Mettre en prison", action = "menuprison", ask = "→", askX = true}
		  }
		},
		["camera interact"] = {
			b = {
			  {name = "Caméra 1 (Ballas)", action = "camera1", ask = "→", askX = true},
			  {name = "Caméra 2 (Families)", action = "camera2", ask = "→", askX = true},
			  {name = "Caméra 3 (Vagos)", action = "camera3", ask = "→", askX = true},
			  {name = "Caméra 4 (Superette Unicorn)", action = "camera4", ask = "→", askX = true},
			  {name = "Caméra 5 (Superette Ballas)", action = "camera5", ask = "→", askX = true},
			  {name = "Caméra 6 (Superette BurgerShot)", action = "camera7", ask = "→", askX = true},
			  {name = "Caméra 7 (Superette Taxi)", action = "camera8", ask = "→", askX = true},
			  {name = "Caméra 8 (Superette Vinewood)", action = "camera9", ask = "→", askX = true}
			}
		  },
		["amendes"] = {
			b = {	
		  }
		},
		["police menotte"] = {
			b = {
			  {name = "Fouiller", action = "search", ask = "→", askX = true},
			  {name = "Menotter", action = "handcuff", ask = "→", askX = true},
			  {name = "Demenotter", action = "unhandcuff", ask = "→", askX = true},
			  {name = "Escorter", action = "drag", ask = "→", askX = true},
			  {name = "Mettre dans véhicule", action = "in_vehicle", ask = "→", askX = true},
			  {name = "Sortir du véhicule", action = "out_vehicle", ask = "→", askX = true}
			}
		},
		["police vehicule"] = {
		 b = {
		  {name = "Ouvrir le véhicule", action = "openvehicle", ask = "→", askX = true},
		  {name = "Informations sur le véhicule", action = "vehicleinfos", ask = "→", askX = true},
		  {name = "Mettre le véhicule en fourrière", action = "delvehicle", ask = "→", askX = true}
		 }
		},
		["renforts"] = {
			b = {
			 {name = "Légère", action = "renforts", thetype = "lite", ask = "→", askX = true},
			 {name = "Moyenne", action = "renforts", thetype = "normal", ask = "→", askX = true},
			 {name = "Forte", action = "renforts", thetype = "high", ask = "→", askX = true}
			}
		},
		["prisons"] = {
			b = {
			 {name = "Station 1", action = "prison", station = "policestation1", ask = "→", askX = true},
			 {name = "Station 2", action = "prison", station = "policestation2", ask = "→", askX = true},
			 {name = "Station 3", action = "prison", station = "policestation3", ask = "→", askX = true},
			 {name = "Fédérale", action = "prison", station = "federal", ask = "→", askX = true},
			 {name = "Sortir de prison", action = "prison", station = "out", ask = "→", askX = true}
			}
		}
	 }
	}
	if ESX.PlayerData.job.grade_name == 'boss' then
	table.insert(PoliceMenu.Menu["police"].b, {name = "Faire une annonce", action = "annoncedejosh", ask = "→", askX = true})
	end
	CreateMenu(PoliceMenu)
	end

	RegisterNetEvent("policejob:receiveHelpBlip")
	AddEventHandler("policejob:receiveHelpBlip", function(blipid, coords, name, _thetype)
		if not renfortBlips[blipid] then
			local color = 3
			if _thetype == "normal" then
				color = 33
			elseif _thetype == "high" then
				color = 1
			end
		local blip = AddBlipForCoord(coords.x, coords.y, 1000.0)
		SetBlipSprite(blip , 161)
		SetBlipScale(blip , 2.0)
		SetBlipColour(blip, color)
		PulseBlip(blip)
		local blip2 = AddBlipForCoord(coords.x, coords.y, 1000.0)
		SetBlipSprite(blip2 , 685)
		SetBlipScale(blip2 , 0.7)
		SetBlipColour(blip2, color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(name)
		EndTextCommandSetBlipName(blip2)
		renfortBlips[blipid] = {blip, blip2}
		end
	end)

	RegisterNetEvent("policejob:removeHelpBlip")
	AddEventHandler("policejob:removeHelpBlip", function(blipid)
		if renfortBlips[blipid] then
			for k, v in pairs(renfortBlips[blipid]) do
				RemoveBlip(v)
			end
		renfortBlips[blipid] = nil
		end
	end)

	function OpenIdentityCardMenu(player)
		ESX.TriggerServerCallback('policejob:getOtherPlayerData', function(data)
		
				local elements    = {}
				local nameLabel   = ('Nom: %s'):format(data.name)
				local jobLabel    = nil
				local sexLabel    = nil
				local dobLabel    = nil
				local heightLabel = nil
			
				if data.grade ~= nil and  data.grade ~= '' then
					jobLabel = ('Métier: %s'):format(data.job .. ' - ' .. data.grade)
				else
					jobLabel = ('Métier: %s'):format(data.job)
				end
					nameLabel = ('Nom: %s'):format(data.firstname .. ' ' .. data.lastname)
			
					if data.sex ~= nil then
						if string.lower(data.sex) == 'm' then
							sexLabel = "Sexe: Homme"
						else
							sexLabel = "Sexe: Femme"
						end
					else
						sexLabel = "Sexe: Inconnu"
					end
			
					if data.dob ~= nil then
						dobLabel = ('DOB: %s'):format(data.dob)
					else
						dobLabel = "DOB: Inconnu"
					end
			
					if data.height ~= nil then
						heightLabel = ('Taille: %s'):format(data.height)
					else
						heightLabel = 'Taille: Inconnu'
					end
		
		
				CitizenIDMenu = {
					Base = { Title = "Identité", HeaderColor = {169, 187, 232} },
					Data = { currentMenu = "identite" },
				
					Events = {
					onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
					end
				  },
				
				  Menu = {
					["identite"] = {
						b = {
							{name = nameLabel, value = nil},
							{name = jobLabel,  value = nil},
							{name = sexLabel, value = nil},
							{name = dobLabel, value = nil},
							{name = heightLabel, value = nil}
						}
					}
				 }
				}
				
				CreateMenu(CitizenIDMenu)
			
			end, GetPlayerServerId(player))
		end
		

Citizen.CreateThread(function()
	for a, b in pairs(ESXConfig.Police.PoliceStations) do  
		local blip = AddBlipForCoord(b.zones["boss"])
        local blipdata = BlipsData[b.type]
        if not blipdata then print("Police Blips Error : " .. j.type) return end
		SetBlipSprite (blip, blipdata.sprite)
		SetBlipDisplay(blip, blipdata.display)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, blipdata.color)
		SetBlipAsShortRange(blip, blipdata.asShortRange)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(b.label)
		EndTextCommandSetBlipName(blip)
	end
end)