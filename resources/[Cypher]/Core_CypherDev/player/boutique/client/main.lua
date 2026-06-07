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
    ["Informations"] = {
        b = {
        }
    },
    ["preview grade"] = {
        b = {
        }
    },
  }
}

function OpenStoreMenu()
	StoreMenu.Menu["boutique"].b = {}
	
    -- Ajout d'une ligne de séparation
	table.insert(StoreMenu.Menu["boutique"].b, {name = '                         Votre UUID: ~b~' .. ESX.PlayerData.uuid, action = 'null'})
    table.insert(StoreMenu.Menu["boutique"].b, {name = '                         Points: ~y~' .. ESX.PlayerData.storepoints .. ' ~b~' .. ESXConfig.StorePointsName, action = 'null'})
        
    -- Autres boutons du menu
    table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Armes', action = 'weapons'})
    table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Véhicules', action = 'vehicles'})
    table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Grades VIP', action = 'ranks'})
    table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Packs', action = 'showpacks'})
    table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Caisses', action = 'caisses'})
	table.insert(StoreMenu.Menu["boutique"].b, {name = '~b~→ ~w~Mes Informations', action = 'info'})
    
    CreateMenu(StoreMenu)
 end

 function StartCaisseMenu()
    local CaisseMenu = {
        Base = { Title = "Caisses", HeaderColor = {255, 0, 0} },
        Data = { currentMenu = "caisses" },
        
        Events = {
            onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
                if btn.action == "buycaisse" then
                    TriggerServerEvent('store:openCaisse', btn.item)
                    CloseMenu()
                elseif btn.action == "previewcaisse" then
                    OpenMenu("preview_" .. btn.item)
                end
            end,
            onButtonSelected = function(self, _, btn)
                if btn and btn.sprite then
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
            ["caisses"] = {
                b = {
                    {name = "~b~→ ~w~Caisse Standard", desc = "Une caisse contenant des récompenses basiques", action = "previewcaisse", item = "caisse_standard", sprite = "caisse_standard"},
                    {name = "~p~→ ~w~Caisse Premium", desc = "Une caisse contenant des récompenses exceptionnelles", action = "previewcaisse", item = "caisse_premium", sprite = "caisse_premium"},
                }
            },
            ["preview_caisse_standard"] = {
                b = {
                    {name = "~g~Acheter la caisse~w~ (1000 " .. ESXConfig.StorePointsName .. ")", desc = "Cliquez pour acheter cette caisse", action = "buycaisse", item = "caisse_standard"},
                    {name = "~y~═══ Récompenses Possibles ═══", desc = "Voici ce que vous pouvez obtenir", action = "null"},
                    {name = "~b~• ~w~Pistolet", rightlabel = "~g~15%", desc = "Arme de poing standard avec 100 munitions", action = "null"},
                    {name = "~b~• ~w~SMG", rightlabel = "~g~10%", desc = "Arme automatique compacte avec 100 munitions", action = "null"},
                    {name = "~b~• ~w~50,000$", rightlabel = "~g~30%", desc = "Argent propre directement dans votre poche", action = "null"},
                    {name = "~b~• ~w~25,000$ (argent sale)", rightlabel = "~g~20%", desc = "Argent sale à blanchir", action = "null"},
                    {name = "~b~• ~w~T20", rightlabel = "~y~5%", desc = "Supercar exclusive", action = "null"},
                    {name = "~b~• ~w~500 Points Boutique", rightlabel = "~g~20%", desc = "Points à dépenser dans la boutique", action = "null"}
                }
            },
            ["preview_caisse_premium"] = {
                b = {
                    {name = "~g~Acheter la caisse~w~ (2000 " .. ESXConfig.StorePointsName .. ")", desc = "Cliquez pour acheter cette caisse", action = "buycaisse", item = "caisse_premium"},
                    {name = "~p~═══ Récompenses Possibles ═══", desc = "Voici ce que vous pouvez obtenir", action = "null"},
                    {name = "~b~• ~w~Carabine", rightlabel = "~g~15%", desc = "Fusil d'assaut puissant avec 200 munitions", action = "null"},
                    {name = "~b~• ~w~Pistolet AP", rightlabel = "~g~20%", desc = "Pistolet automatique avec 200 munitions", action = "null"},
                    {name = "~b~• ~w~100,000$", rightlabel = "~g~25%", desc = "Argent propre directement dans votre poche", action = "null"},
                    {name = "~b~• ~w~50,000$ (argent sale)", rightlabel = "~g~20%", desc = "Argent sale à blanchir", action = "null"},
                    {name = "~b~• ~w~Zentorno", rightlabel = "~y~10%", desc = "Supercar exclusive", action = "null"},
                    {name = "~b~• ~w~1000 Points Boutique", rightlabel = "~y~10%", desc = "Points à dépenser dans la boutique", action = "null"}
                }
            }
        }
    }
    
    CreateMenu(CaisseMenu)
end

-- Event pour mettre à jour les points
RegisterNetEvent('store:updatePoints')
AddEventHandler('store:updatePoints', function(newPoints)
    ESX.PlayerData.storepoints = newPoints
    if StoreMenu.Menu["boutique"].b then
        -- Mettre à jour l'affichage des points dans le menu
        for k,v in pairs(StoreMenu.Menu["boutique"].b) do
            if string.find(v.name, ESXConfig.StorePointsName) then
                v.name = '                         Points: ~y~' .. newPoints .. ' ~b~' .. ESXConfig.StorePointsName
                break
            end
        end
    end
end)

RegisterCommand("+store", function()
    OpenStoreMenu()
end)

RegisterKeyMapping("+store", "Boutique", "keyboard", "f1")