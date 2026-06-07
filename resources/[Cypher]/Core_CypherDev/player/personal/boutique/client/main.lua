local weaponTintList = {
"WEAPON_PISTOL",
"WEAPON_PISTOL50",
"WEAPON_APPISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_COMPACTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_MICROSMG",
"WEAPON_SMG",
}

local WeaponTintIndexes = {
	["gold"] = 2,
	["blue"] = 5,
	["pink"] = 3,
	["orange"] = 6,
	["green"] = 1,
	["platine"] = 7
}

local AvantagesRanks = {
	["vip"] = {
		{name = "L'aide de l'état est multipliée par 1.5"},
		{name = "Accès à des armes exclusives dans l'ammu-nation et le marché noir"},
		{name = "Le /afk vous rapporte 1500$ toutes les 10 minutes au lieu de 1000$"},
		{name = "Les prix de revente des drogues est multiplié par 1.25"},
		{name = "Vous pouvez appliquer des skins d'armes avec le menu VIP f11"},
		{name = "Vous ne perdez pas vos armes lorsque vous mourrez (seulement si vous attendez de respawn à l'hopital)"}
	},
	["diamond"] = {
		{name = "L'aide de l'état est multipliée par 2"},
		{name = "Accès à des armes exclusives dans l'ammu-nation et le marché noir"},
		{name = "Le /afk vous rapporte 2500$ toutes les 10 minutes au lieu de 1000$"},
		{name = "Les prix de revente des drogues est multiplié par 1.5"},
		{name = "Vous pouvez appliquer des skins d'armes avec le menu VIP f11"},
		{name = "Vous ne perdez pas vos armes lorsque vous mourrez (seulement si vous attendez de respawn à l'hopital)"}
	}
}

-- Perm Weapons Sync
RegisterCommand("syncperm", function()
	TriggerEvent('esx:restorePermLoadout')
end)

function openWeaponSkinMenu()
	local WeaSkinMenu = {
		Base = { Title = "Weapon Skin",HeaderColor = {255, 255, 255} },
		Data = { currentMenu = "skins" },
	
		Events = {
		  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
		  if btn.action == "setweaskin" then
			if btn.value then
				nothing, weapon = GetCurrentPedWeapon(ESX.PlayerData.cache.playerped, true)
				TintWeapon(weapon, WeaponTintIndexes[btn.value])
			end
		  end
		end
	  },
	
	  Menu = {
		["skins"] = {
		  b = {
			{name = "Skin Or", action = "setweaskin", value = "gold"},
			{name = "Skin Rose", action = "setweaskin", value = "pink"},
			{name = "Skin Orange", action = "setweaskin", value = "orange"},
			{name = "Skin Vert", action = "setweaskin", value = "green"},
			{name = "Skin Platine", action = "setweaskin", value = "platine"},
			{name = "Skin Bleu", action = "setweaskin", value = "blue"},
		  }
		},
	  }
	}
	
	
	CreateMenu(WeaSkinMenu)
end

function TintWeapon(model, tint)
	for _, TintNum in pairs(weaponTintList) do
		if model == GetHashKey(TintNum) then
			SetPedWeaponTintIndex(ESX.PlayerData.cache.playerped, GetHashKey(TintNum), tint)
		end
	end
end

-- Store Menu


StoreMenu = {
	Base = { Title = "Boutique", HeaderColor = {255, 0, 0}, Blocked = false},
	Data = { currentMenu = "boutique" },
  
	Events = {
	  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if btn.action == 'weapons' then
            StoreMenu.Menu["Armes"].b = {}
            for _,item in ipairs(StoreConfig.Weapons) do
				if item.Type == 'normal' then
					
                table.insert(StoreMenu.Menu["Armes"].b, {name = ESX.GetWeaponLabel(item.NameWeapon), item = item.NameWeapon, weatype = item.Type, type = 'weapon', action = 'buyitem', sprite = item.Preview, ask = item.Point .. ' ~b~' .. ESXConfig.StorePointsName, askX = true})
				elseif item.Type == 'perm' then
				table.insert(StoreMenu.Menu["Armes"].b, {name = '~r~[PERM] ' .. ESX.GetWeaponLabel(item.NameWeapon), item = item.NameWeapon, weatype = item.Type, type = 'weapon', action = 'buyitem', sprite = item.Preview, ask = item.Point .. ' ~b~' .. ESXConfig.StorePointsName, askX = true})
			end
			end
            OpenMenu("Armes")
        elseif btn.action == 'vehicles' then
			CloseMenu()
			StartBoutiquePreview()
        elseif btn.action == 'showpacks' then
            OpenMenu("pack")
		elseif btn.action == 'previewpack' then
            StoreMenu.Menu["preview pack"].b = {}
			table.insert(StoreMenu.Menu["preview pack"].b, {name = '~y~Acheter Le Pack', item = btn.item, weatype = '', type = 'pack', action = 'buyitem', ask = btn.prix .. ' ~b~' .. ESXConfig.StorePointsName, askX = true})
            for _,item in ipairs(StoreConfig.Packs[btn.item].loots) do
                table.insert(StoreMenu.Menu["preview pack"].b, {name = item.name, item = item.item, type = 'pack', action = 'null'})
            end
            OpenMenu("preview pack")
        elseif btn.action == 'info' then
            StoreMenu.Menu["Informations"].b = {}
            table.insert(StoreMenu.Menu["Informations"].b, {name = 'UUID : ~r~' .. ESX.PlayerData.uuid, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = 'Grade : ~b~' .. ESX.PlayerData.rank, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = ESXConfig.StorePointsName .. ' : ~y~' .. ESX.PlayerData.storepoints, action = 'null'})
            table.insert(StoreMenu.Menu["Informations"].b, {name = "Contact : " .. ESXConfig.DiscordURL, action = "null"})
            
            OpenMenu("Informations")
        elseif btn.action == 'buyitem' then
            TriggerServerEvent('store:buyItem', btn.type, btn.item, btn.weatype)
            CloseMenu()
			SendNUIMessage({
				action = 'hidePreviewImage'
			})
		elseif btn.action == 'buyrank' then
            TriggerServerEvent('store:buyItem', btn.type, btn.item, btn.weatype)
            CloseMenu()
			SendNUIMessage({
				action = 'hidePreviewImage'
			})
		elseif btn.action == 'caisses' then
			CloseMenu()
			StartCaisseMenu()
			SendNUIMessage({
				action = 'hidePreviewImage'
			})
		elseif btn.action == "ranks" then
			OpenMenu("Grades")
		elseif btn.action == "previewrank" then
			if AvantagesRanks[btn.item] then
				StoreMenu.Menu["preview grade"].b = {}
				table.insert(StoreMenu.Menu["preview grade"].b, {name = "Acheter le grade " .. string.upper(btn.item) .. " (1 mois) : " .. btn.ask, action = "buyitem", item = btn.item, type = "rank"})
			    for k, v in pairs(AvantagesRanks[btn.item]) do 
					table.insert(StoreMenu.Menu["preview grade"].b, {name = v.name, action = "null"})
				end
				OpenMenu("preview grade")
			end
        end
	end,
	onButtonSelected = function(currentaMenu, k, j, btn, self)
		if btn.sprite then
			SendNUIMessage({
				action = 'showPreviewImage',
				image = btn.sprite
			})
		else
			SendNUIMessage({
				action = 'hidePreviewImage'
			})
		end 
	end
  },
  
  Menu = {
	["boutique"] = {
	  b = {
	  }
	},
    ["Armes"] = {
        b = {
        }
    },
    ["Vehicules"] = {
        b = {
        }
    },
	["Grades"] = {
        b = {
			{name = "Grade ~y~VIP~s~ (1 Mois)", action = "buyrank", item = "vip", type = "rank", ask = '1.000' .. ' ~b~' .. ESXConfig.StorePointsName, askX = true},
			{name = "Grade ~b~DIAMOND~s~ (1 Mois)", action = "buyrank", item = "diamond", type = "rank", ask = '2.000' .. ' ~b~' .. ESXConfig.StorePointsName, askX = true}
        }
    },
    ["pack"] = {
        b = {
			{name = '~r~' .. 'Pack Illegal', item = 'illegal', type = 'pack', prix = 3000, action = 'previewpack', ask = '3.000' .. ' ~b~' .. ESXConfig.StorePointsName, askX = true},
			{name = '~g~' .. 'Pack legal', item = 'legal', type = 'pack', prix = 2500, action = 'previewpack', ask = '2.500' .. ' ~b~' .. ESXConfig.StorePointsName, askX = true}
        }
    },
	["preview pack"] = {
        b = {
			
        }
    },
	["preview grade"] = {
        b = {
			
        }
    },
    ["Informations"] = {
        b = {
        }
    },
  }
}

function OpenStoreMenu()
	StoreMenu.Menu["boutique"].b = {}
	
    -- Ajout d'une ligne de séparation
	table.insert(StoreMenu.Menu["boutique"].b, {name = '                         Votre UUID: ~b~' .. ESX.PlayerData.uuid, action = 'null'})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "                         Vos " .. ESXConfig.StorePointsName .. " : ~y~" .. ESX.PlayerData.storepoints, action = "null"})

	table.insert(StoreMenu.Menu["boutique"].b, {name = "                         achetez des " .. ESXConfig.StorePointsName .. "", action = "null"})



    -- Ajout de la catégorie Armes
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Véhicules", action = "vehicles", ask = "→", askX = true})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Grades VIP", action = "ranks", ask = "→", askX = true})
    table.insert(StoreMenu.Menu["boutique"].b, {name = "Packs", action = "showpacks", ask = "→", askX = true})
	table.insert(StoreMenu.Menu["boutique"].b, {name = "Armes", action = "weapons", ask = "→", askX = true, selected = true})
    table.insert(StoreMenu.Menu["boutique"].b, {name = "Autres", action = "info", ask = "→", askX = true})

    CreateMenu(StoreMenu)
 end

RegisterCommand("+store", function()
    OpenStoreMenu()
end)

RegisterKeyMapping("+store", "Boutique", "keyboard", "f1")