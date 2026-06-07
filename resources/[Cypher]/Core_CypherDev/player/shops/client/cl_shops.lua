local HasActuallyOpenedShops = false

local inValidation = false

local MenuOpen = false

local hasPPA = false

local LastSkin = {}

ShopsLocations = {
    {coords = {x = 72.254,    y = -1399.102, z = 28.376}, type = "clothes"},
    {coords = {x = -703.776,  y = -152.258,  z = 36.415}, type = "clothes"},
    {coords = {x = -167.863,  y = -298.969,  z = 38.733}, type = "clothes"},
    {coords = {x = 428.694,   y = -800.106,  z = 28.491}, type = "clothes"},
    {coords = {x = 4488.96,   y = -4452.14,  z = 3.37}, type = "clothes"}, --cayo
    {coords = {x = -829.413,  y = -1073.710, z = 10.328}, type = "clothes"},
    {coords = {x = -1447.797, y = -242.461,  z = 48.820}, type = "clothes"},
    {coords = {x = 11.632,    y = 6514.224,  z = 30.877}, type = "clothes"},
    {coords = {x = 123.646,   y = -219.440,  z = 53.557}, type = "clothes"},
    {coords = {x = 1696.291,  y = 4829.312,  z = 41.063}, type = "clothes"},
    {coords = {x = 618.093,   y = 2759.629,  z = 41.088}, type = "clothes"},
    {coords = {x = 1190.550,  y = 2713.441,  z = 37.222}, type = "clothes"},
    {coords = {x = -1193.429, y = -772.262,  z = 16.324}, type = "clothes"},
    {coords = {x = -3172.496, y = 1048.133,  z = 19.863}, type = "clothes"},
    {coords = {x = -1108.441, y = 2708.923,  z = 18.107}, type = "clothes"},
    {coords = {x = -1338.129, y = -1278.200, z = 3.872},  type = "accessories"},
    {coords = {x = -814.308,  y = -183.823,  z = 36.568}, type = "barber"},
	{coords = {x = 136.826,   y = -1708.373, z = 28.291}, type = "barber"},
	{coords = {x = -1282.604, y = -1116.757, z = 5.990},  type = "barber"},
	{coords = {x = 1931.513,  y = 3729.671,  z = 31.844}, type = "barber"},
	{coords = {x = 1212.840,  y = -472.921,  z = 65.208}, type = "barber"},
	{coords = {x = -32.885,   y = -152.319,  z = 56.076}, type = "barber"},
	{coords = {x = -278.077,  y = 6228.463,  z = 30.695}, type = "barber"},
    {coords = {x = 1208.7307,    y = -3114.8918,   z = 4.5677}, type = "blackweashop"},
    {coords = {x = 248.1,     y = -46.5,     z = 68.9},   type = "accweashop"},
    {coords = {x = -664.6,    y = -940.2,    z = 20.8 },  type = "accweashop"},
    {coords = {x = 812.5,     y = -2152.1,   z = 28.6 },  type = "accweashop"},
    {coords = {x = 1694.9,    y = 3755.3,    z = 33.7 },  type = "accweashop"},
    {coords = {x = -328.6,    y = 6078.6,    z = 30.4 },  type = "accweashop"},
    {coords = {x = 18.2,      y = -1110.5,   z = 28.8 },  type = "accweashop"},
    {coords = {x = 2570.3,    y = 298.8,     z = 107.7 }, type = "accweashop"},
    {coords = {x = -1116.3,   y = 2693.3,    z = 17.5 },  type = "accweashop"},
    {coords = {x = 844.7,     y = -1028.8,   z = 27.2 },  type = "accweashop"},
}

local ElementsList = {
    ["clothes"] = {
        {name = "T-shirt", partid =  8, zoomOffset = 0.75, camOffset = 0.15, partname = "tshirt", color = true, size = false},
        {name = "Torse", partid =  11, zoomOffset = 0.75, camOffset = 0.15, partname = "torso", color = true, size = false},
        {name = "Bras", partid =  3, zoomOffset = 0.75, camOffset = 0.15, partname = "arms", color = false, size = false},
        {name = "Pantalon", partid =  4, zoomOffset = 0.8, camOffset = -0.5, partname = "pants", color = true, size = false},
        {name = "Chaussures", partid =  6, zoomOffset = 0.8, camOffset = -0.8, partname = "shoes", color = true, size = false},
        {name = "Sac à dos", partid =  5, zoomOffset = 0.75, camOffset = 0.15, partname = "bags", color = true, size = false},
        {name = "Chaîne", partid =  7, zoomOffset = 0.75, camOffset = 0.15, partname = "chain", color = true, size = false},
        {name = "Gilet pare balle", partid =  9, zoomOffset = 0.75, camOffset = 0.15, partname = "bproof", color = true, size = false},
        {name = "Calques", partid =  10, zoomOffset = 0.75, camOffset = 0.15, partname = "decals", color = true, size = false}
    },
    ["accessories"] = {
        {name = "Masque", zoomOffset = 0.6, camOffset = 0.65, partname = "mask", color = true, size = false},
        {name = "Chapeau", zoomOffset = 0.6, camOffset = 0.65, partname = "helmet", color = true, size = false},
        {name = "Lunettes", zoomOffset = 0.6, camOffset = 0.65, partname = "glasses", color = true, size = false}
    },
    ["barber"] = {
        {name = "Coupe", zoomOffset = 0.4, camOffset = 0.65, partname = "hair", color = true, size = false},
        {name = "Barbe", zoomOffset = 0.4, camOffset = 0.65, partname = "beard", color = true, size = true}
    },
    ["247"] = {
        {name = "Pain ~g~25$", action = "buy", itemname = "bread", itemtype = "item", slidemax = 10},
		{name = "Eau ~g~25$", action = "buy", itemname = "water", itemtype = "item", slidemax = 10},
		{name = "Téléphone ~g~1500$", action = "buy", itemname = "phone", itemtype = "item", slidemax = 5}
    },
    ["weashop"] = {
        {name = "Batte de baseball ~g~20.000$~s~", action = "buy", itemname = "WEAPON_BAT", itemtype = "weapon"},
        {name = "Pistolet SNS ~g~175.000$~s~", action = "buy", itemname = "WEAPON_SNSPISTOL", itemtype = "weapon"},
        {name = "Pistolet Vintage ~g~250.000$~s~", action = "buy", itemname = "WEAPON_VINTAGEPISTOL", itemtype = "weapon"},
        {name = "Pistolet Calibre 50 ~g~350.000$~s~", action = "buy", itemname = "WEAPON_PISTOL50", itemtype = "weapon"},
        {name = "SMG ~g~1.000.000$~s~", action = "buy", itemname = "WEAPON_SMG", itemtype = "weapon"},
        {name = "[VIP] ADP De Combat ~g~1.500.000$~s~", action = "buy", itemname = "WEAPON_COMBATPDW", itemtype = "weapon", vip = true},
    },
    ["blackweashop"] = {
        {name = "Couteau Papillon ~r~100.000$~s~",  action = "buy", itemname = "WEAPON_SWITCHBLADE", itemtype = "weapon"},
        {name = "Machette ~r~20.000$~s~",  action = "buy", itemname = "WEAPON_MACHETE", itemtype = "weapon"},
        {name = "Pistolet Perforant ~r~500.000$~s~", action = "buy", itemname = "WEAPON_APPISTOL", itemtype = "weapon"},
        {name = "Micro SMG ~r~600.000$~s~", action = "buy", itemname = "WEAPON_MICROSMG", itemtype = "weapon"}, 
        {name = "AK47 compact ~r~1.000.000$~s~", action = "buy", itemname = "WEAPON_COMPACTRIFLE", itemtype = "weapon"},
        {name = "Ak47 ~r~1.500.000$~s~",  action = "buy", itemname = "WEAPON_ASSAULTRIFLE", itemtype = "weapon"},
        {name = "M4 ~r~2.500.000$~s~",  action = "buy", itemname = "WEAPON_CARBINERIFLE", itemtype = "weapon"},
        {name = "Balayeuse Gusenberg ~r~3.000.000$~s~", action = "buy", itemname = "WEAPON_GUSENBERG", itemtype = "weapon"},
        {name = "MG ~r~10.000.000$~s~",  action = "buy", itemname = "WEAPON_MG", itemtype = "weapon"},
        {name = "[VIP] Ak47 MK2 ~r~4.000.000$~s~",  action = "buy", itemname = "WEAPON_ASSAULTRIFLE_MK2", itemtype = "weapon", vip = true},
        {name = "[VIP] M4 MK2 ~r~5.000.000$~s~",  action = "buy", itemname = "WEAPON_CARBINERIFLE_MK2", itemtype = "weapon", vip = true},
        {name = "[VIP] MG MK2 ~r~15.000.000$~s~",  action = "buy", itemname = "WEAPON_COMBATMG_MK2", itemtype = "weapon", vip = true},
    },
    ["accweashop"] = {
        {name = "Chargeur ~g~1000$", action = "buy", itemname = "clip", itemtype = "item", slidemax = 10},
        {name = "Silencieux ~g~5000$", action = "buy", itemname = "silencieux", itemtype = "item", slidemax = 10},
        {name = "Skin de luxe ~g~7500$", action = "buy", itemname = "yusuf", itemtype = "item", slidemax = 10},
        {name = "Poignée ~g~7500$", action = "buy", itemname = "grip", itemtype = "item", slidemax = 10},
        {name = "Lampe ~g~10000$", action = "buy", itemname = "flashlight", itemtype = "item", slidemax = 10}
    }
}

local BlipsData = {
    ["clothes"] = {
        sprite = 73,
        display = 4,
        scale = 0.8,
        color = 60,
        text = "Magasin de vêtements",
        asShortRange = true
    },
    ["accessories"] = {
        sprite = 362,
        display = 4,
        scale = 0.8,
        color = 3,
        text = "Magasin d'accessoires",
        asShortRange = true
    },
    ["barber"] = {
        sprite = 71,
        display = 4,
        scale = 0.8,
        color = 51,
        text = "Barbier",
        asShortRange = true
    },
    ["247"] = {
        sprite = 52,
        display = 4,
        scale = 0.8,
        color = 2,
        text = "Magasin 24/7",
        asShortRange = true
    },
    ["weashop"] = {
        sprite = 110,
        display = 4,
        scale = 0.8,
        color = 49,
        text = "Armurerie",
        asShortRange = true
    }
}

function OpenShopsMenu(type)
    if type == "weashop" and not hasPPA then
        CheckWeaponLicense() 
        return
    end
    MenuOpen = true
    TriggerEvent("caruiskinchanger:getSkin", function(skin)
        LastSkin = skin
    end)
    local title = "shop"
    if type == "clothes" then
        title = "Vêtements"
    elseif type == "accessories" then
        title = "Accessoires"
    elseif type == "barber" then
        title = "Barbier"
    elseif type == "247" then
        title = "24/7"
    else
        title = "Armurerie"
    end
    ShopsMenu = { 
        Base = { Title = title, HeaderColor = {130, 109, 68} },
        Data = { currentMenu = "magasin" },
    Events = { 
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result) 
            if btn.action == "theshop" then
                ShopsMenu.Menu[title].b = {
                    {name = "Valider et passer au paiement", nooffset = true, action = "startvalidation", ask = "~g~1000$", askX = true},
                    {name = "", nooffset = true, action = "null"}
                }  
                CreateSkinCam()
                HasActuallyOpenedShops = true
                for k, v in pairs(ElementsList[type]) do 
                    if v.color then
                        table.insert(ShopsMenu.Menu[title].b, {name = v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = GetNumberOfPedDrawableVariations(ESX.PlayerData.cache.playerped, v.partid), partname = v.partname .. '_1'})
                        if v.partname ~= "hair" then
                            if v.size then
                                table.insert(ShopsMenu.Menu[title].b, {name = "Taille " .. v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = 100, partname = v.partname .. '_2'})
                                table.insert(ShopsMenu.Menu[title].b, {name = "Couleur " .. v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = 100, partname = v.partname .. '_3'})
                            else
                                table.insert(ShopsMenu.Menu[title].b, {name = "Couleur " .. v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = 100, partname = v.partname .. '_2'})
                            end
                        else
                        table.insert(ShopsMenu.Menu[title].b, {name = "Couleur " .. v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = 100, partname = v.partname .. '_color_1'})
                        end
                       
                    else
                        table.insert(ShopsMenu.Menu[title].b, {name = v.name, zoomOffset = v.zoomOffset, camOffset = v.camOffset, slidenum = 0, slidemax = GetNumberOfPedDrawableVariations(ESX.PlayerData.cache.playerped, v.partid), partname = v.partname})
                    end
                end
                TriggerEvent("caruiskinchanger:getSkin", function(skin)
                    local skinvalues = {}
                    for k, v in pairs(skin) do 
                        skinvalues[k] = v + 1
                    end
                    for k, v in pairs(ShopsMenu.Menu[title].b) do
                        if v.partname and skinvalues[v.partname] then
                            v.slidenum = skinvalues[v.partname]
                        end
                    end
                    OpenMenu(title)
                end)
            elseif btn.action == "preset" then
                ESX.TriggerServerCallback("shops:getPlayerDressing", function(dressing)
                    ShopsMenu.Menu["presets"].b = {}
                    for i=1, #dressing, 1 do
                        ShopsMenu.Menu["presets"].b[i] = {name = dressing[i], action = "outfitAction", outfitName = i, slidemax = {"Mettre", "Supprimer"}}
                    end
                    OpenMenu("presets")
                end)
            elseif btn.action == "startvalidation" then
                inValidation = true
                OpenMenu("validation")
            elseif btn.action == "yes" then
                local nameClothes = KeyboardInput("CLOTHES_NAME", "Nom de votre tenue ?", "", 100)
                if nameClothes ~= nil then
                    ESX.TriggerServerCallback("shops:checkMoney", function(hasEnoughMoney)
                        TriggerEvent("caruiskinchanger:getSkin", function(skin)
                        TriggerServerEvent("shops:saveOutfit", nameClothes, skin)
                        ESX.ShowNotification("Votre tenue à bien été sauvegardé dans la garde robe. Merci de votre visite !")
                        end)
                        SaveSkin()
                        CloseMenu()
                        ClearPedTasks(ESX.PlayerData.cache.playerped)
                        DeleteSkinCam()
                    end)
                end
            elseif btn.action == "no" then
            ESX.TriggerServerCallback("shops:checkMoney", function(hasEnoughMoney)
                if hasEnoughMoney then
                  ESX.ShowNotification("Merci de votre achat.\nA bientôt !")
                  HasPayed = true
                  SaveSkin()
                  inValidation = false
                  ClearPedTasks(ESX.PlayerData.cache.playerped)
                  DeleteSkinCam()
                  CloseMenu()
                else
                  ESX.ShowNotification("Vous n'avez pas assez d'argent.")
                  HasPayed = false
                  TriggerEvent("caruiskinchanger:loadSkin", ESX.PlayerData.skin)
                end
            end)
            elseif btn.action == "buy" then
                if type == "247" or type == "accweashop" then
                local amount = btn.slidenum - 1
                if amount > 0 then
                    TriggerServerEvent("shops:buyItem", btn.itemname, btn.itemtype, amount)
                    CloseMenu()
                else
                    ESX.ShowNotification("Veuillez choisir un nombre au dessus de 0")
                end
                elseif type == "weashop" or type == "blackweashop" then
                    if btn.itemtype == "weapon" then
                        TriggerServerEvent("shops:buyItem", btn.itemname, btn.itemtype, 0)
                    end
                end
            elseif btn.action == "outfitAction" then
                if btn.slidenum == 1 then
                  TriggerEvent("caruiskinchanger:getSkin", function(skin)
                   ESX.TriggerServerCallback("shops:getPlayerOutfit", function(clothes)
                    TriggerEvent("caruiskinchanger:loadClothes", skin, clothes)
                    Citizen.Wait(500)
                    SaveSkin()
                    ESX.ShowNotification("Vous avez bien récupéré la tenue de votre garde robe. Merci de votre visite !")
                   end, btn.outfitName)
                  end)
                elseif btn.slidenum == 2 then
                  TriggerServerEvent("shops:deleteOutfit", btn.outfitName)
                  ESX.ShowNotification("Cette tenue a bien été supprimé de votre garde robe.")
                  CloseMenu()
              end
            end
      end,
      onButtonSelected = function(currentaMenu, k, j, btn, self)
        if btn.nooffset then return end
          if btn.zoomOffset and btn.camOffset then
            TriggerEvent("skin:ChangeOffset", btn.zoomOffset, btn.camOffset)
          elseif HasActuallyOpenedShops and not inValidation then
            HasActuallyOpenedShops = false
            ClearPedTasks(ESX.PlayerData.cache.playerped)
            DeleteSkinCam()
            if not HasPayed then
            TriggerEvent("caruiskinchanger:loadSkin", LastSkin)
            end
          end 
          
      end,
      onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
        if btn.partname then
            if string.find(btn.partname, "_1") then
                local namewithout = btn.partname:gsub("%_1", "")
                for k, v in pairs(ShopsMenu.Menu[title].b) do
                    if v.partname == namewithout .. "_2" or v.partname == namewithout .. "_3" then
                        UpdateSlideNumShops(title, k)
                    end
                end
            end
            TriggerEvent("caruiskinchanger:change", btn.partname, btn.slidenum - 1)
        end
      end,
      onExited = function()
        ClearPedTasks(ESX.PlayerData.cache.playerped)
        DeleteSkinCam()
        MenuOpen = false
      end
    },      
    Menu = {
      ["magasin"] = {
          b = {
          }
      },
      [title] = {
          b = {
          }
      },
      ["presets"] = {
          b = {
              {name = "bientôt les enfants :)", action = "null"}
          }
      },
      ["validation"] = {
        b = {
          {name = "Voulez-vous sauvegarder votre preset ?", action = "null"},
          {name = "Non", action = "no"},
          {name = "Oui", action = "yes"},
        }
      }
    }  
}   

if type ~= "247" and type ~= "weashop" and type ~= "blackweashop" and type ~= "accweashop" then
    if type == "clothes" then
        table.insert(ShopsMenu.Menu["magasin"].b, {name = "Mes presets", action = "preset", ask = "→", askX = true})
    end
table.insert(ShopsMenu.Menu["magasin"].b, {name = title, action = "theshop", ask = "→", askX = true})
else
ShopsMenu.Menu["magasin"].b = ElementsList[type]
end

CreateMenu(ShopsMenu)
end

function UpdateSlideNumShops(title, key)
    ShopsMenu.Menu[title].b[key].slidenum = 1
    UpdateSlide(ShopsMenu.Menu[title].b[key].name)
    TriggerEvent("caruiskinchanger:change", ShopsMenu.Menu[title].b[key].partname, ShopsMenu.Menu[title].b[key].slidenum - 1)
end

function SaveSkin()
    TriggerEvent("caruiskinchanger:getSkin", function(skin)
        ESX.PlayerData.skin = skin
        TriggerServerEvent("skin:save", skin)
        ESX.SavePlayer()
    end)
end

function CheckWeaponLicense()
    ESX.TriggerServerCallback("shops:CheckWeaponLicense", function(hasWeaponLicense)
        if hasWeaponLicense then
            OpenShopsMenu('weashop')
            hasPPA = true
        else
            OpenWeaponLicenseMenu()
        end
    end)
end

function OpenWeaponLicenseMenu()
    WeaponLicenseMenu = {
      Base = { Title = "Armurerie", HeaderColor = {130, 109, 68} },
      Data = { currentMenu = "ppa" },
  
      Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
        if btn.action == "buylicense" then
          TriggerServerEvent("shops:BuyWeaponLicense")
          CloseMenu()
        end
      end
    },
  
    Menu = {
      ["ppa"] = {
        b = {
          {name = "Acheter le PPA ~g~50.000$~s~", action = "buylicense", ask = "→", askX = true},
        }
      },
    }
  
  }
  
  CreateMenu(WeaponLicenseMenu)
end

local HasAlreadyEnteredMarker = false

-- Draw Marker / Control Listener
Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
   
     local isInMarker = false
     local letSleep = true
   
     for k,v in pairs(ShopsLocations) do
       if (GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.coords.x, v.coords.y, v.coords.z, true) < 10) then
         letSleep = false
         DrawMarker(1, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 200, false, true, 2, false, false, false, false)
       end
   
       if (GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, v.coords.x, v.coords.y, v.coords.z, true) < 1.5) then
         HasAlreadyEnteredMarker = true
         isInMarker = true
         
         if not MenuOpen then
         ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le magasin.")
         end
         if (IsControlJustPressed(1, 38)) then
           OpenShopsMenu(v.type)
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

Citizen.CreateThread(function()
	for k, v in pairs(ShopsLocations) do
        if v.type == "blackweashop" or v.type == "accweashop" then return end
		local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        local blipdata = BlipsData[v.type]
        if not blipdata then print("Shops Blips Error : " .. v.type) return end
		SetBlipSprite (blip, blipdata.sprite)
		SetBlipDisplay(blip, blipdata.display)
		SetBlipScale  (blip, blipdata.scale)
		SetBlipColour (blip, blipdata.color)
		SetBlipAsShortRange(blip, blipdata.asShortRange)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blipdata.text)
		EndTextCommandSetBlipName(blip)
	end
end)
