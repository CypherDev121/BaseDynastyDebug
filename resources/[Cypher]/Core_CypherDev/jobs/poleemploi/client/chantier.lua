Chantier = vector3(-509.94, -1001.59, 22.55)

local AuTravailleChantier = false
local Heading = 85.79

local ASCII = {}
						local NumberCharset = {}
						local Charset = {}
						
						for i = 48, 57 do table.insert(ASCII, string.char(i)) end
						for i = 65, 90 do table.insert(ASCII, string.char(i)) end
						for i = 97, 122 do table.insert(ASCII, string.char(i)) end
						
						for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
						
						for i = 65, 90 do table.insert(Charset, string.char(i)) end
						for i = 97, 122 do table.insert(Charset, string.char(i)) end
												
						function security(length)
							if length > 0 then
								return security(length - 1) .. Charset[math.random(1, #Charset)]
							end
						
							return ""
						end

local workzone = {
    {
        pos = vector3(-487.0, -986.95, 28.13),
        Heading = 273.2,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-483.987, -986.7827, 28.13171),
        Heading = 90.383460998535,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-482.7948, -995.856, 28.13281),
        Heading = 95.914886474609,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-492.5294, -1005.513, 28.13171),
        Heading = 99.648864746094,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-449.08, -998.68, 22.96),
        Heading = 268.47,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-464.5076, -1000.148, 22.71595),
        Heading = 3.7162296772003,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-465.889, -998.6741, 22.69423),
        Heading = 270.44155883789,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-464.4124, -997.1024, 22.71765),
        Heading = 184.32759094238,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-447.649, -997.1122, 22.98477),
        Heading = 181.08190917969,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-446.2953, -998.5501, 22.00837),
        Heading = 100.51464080811,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-447.7392, -1000.15, 22.98311),
        Heading = 359.67852783203,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-452.71, -1005.6, 22.94),
        Heading = 293.07,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    {
        pos = vector3(-447.183, -1002.664, 22.992),
        Heading = 125.80912780762,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    {
        pos = vector3(-449.1005, -1006.923, 22.96139),
        Heading = 24.118503570557,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
}

local WorkerChillPos = {
    ped1 = {
        pos = vector3(-517.21, -1010.1, 22.45),
        Heading = 52.55,
    },
    ped2 = {
        pos = vector3(-519.15, -1008.78, 22.37),
        Heading = 228.22,
    },
    ped3 = {
        pos = vector3(-511.11, -1006.96, 22.55),
        Heading = 353.89,
    },
    ped4 = {
        pos = vector3(-510.7, -1004.62, 22.55),
        Heading = 168.35,
    },
}

local WorkerWorkingPos = {
    ped1 = {
        pos = vector3(-482.87, -985.45, 28.13),
        Heading = 90.93,
        scenario = "WORLD_HUMAN_WELDING",
    },
    ped2 = {
        pos = vector3(-494.18, -984.56, 28.13),
        Heading = 181.04,
        scenario = "WORLD_HUMAN_WELDING",
    },
    ped3 = {
        pos = vector3(-462.95, -998.48, 22.74),
        Heading = 90.48,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    ped4 = {
        pos = vector3(-447.86, -1015.17, 22.99),
        Heading = 176.85,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    ped5 = {
        pos = vector3(-450.17, -1002.06, 23.11),
        Heading = 191.62,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    ped6 = {
        pos = vector3(-447.62, -1005.67, 23.03),
        Heading = 52.82,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
}

Citizen.CreateThread(function()
Citizen.Wait(1000)
RequestModel("s_m_y_construct_01")
local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), Chantier, Heading, 0, 0)
DecorSetInt(ped, "Yay", 5431)
FreezeEntityPosition(ped, 1)
TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
SetEntityInvincible(ped, true)
SetEntityAsMissionEntity(ped, 1, 1)
SetBlockingOfNonTemporaryEvents(ped, 1)

for _,v in pairs(WorkerChillPos) do
  local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), v.pos, v.Heading, 0, 0)
  DecorSetInt(ped, "Yay", 5431)
  FreezeEntityPosition(ped, 1)
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
  SetEntityInvincible(ped, true)
  SetEntityAsMissionEntity(ped, 1, 1)
  SetBlockingOfNonTemporaryEvents(ped, 1)
end

for _,v in pairs(WorkerWorkingPos) do
  local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), v.pos, v.Heading, 0, 0)
  DecorSetInt(ped, "Yay", 5431)
  FreezeEntityPosition(ped, 1)
  TaskStartScenarioInPlace(ped, v.scenario, 0, true)
  SetEntityInvincible(ped, true)
  SetEntityAsMissionEntity(ped, 1, 1)
  SetBlockingOfNonTemporaryEvents(ped, 1)
end
end)

function StartTravailleChantier()
  if AuTravailleChantier then 
    return
  end
  AuTravailleChantier = true
  while AuTravailleChantier do
    ESX.ShowNotification("Un travaille t'as été attribué, dirige toi sur place !")
    Citizen.Wait(5)
    local random = math.random(1, #workzone)
    local count = 1
    for k,v in pairs(workzone) do
      count = count + 1
      if count == random and AuTravailleChantier then
        local EnAction = false
        local blip = AddBlipForCoord(v.pos)
        SetBlipSprite(blip, 402)
        SetBlipColour(blip, 5)
        SetBlipScale(blip, 0.65)
        while not EnAction and AuTravailleChantier do
          Citizen.Wait(5)
          local pPed = ESX.PlayerData.cache.playerped
          local pCoords = GetEntityCoords(pPed)
          local dstToMarker = GetDistanceBetweenCoords(v.pos, pCoords, true)
          DrawMarker(32, v.pos.x, v.pos.y, v.pos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
          if dstToMarker <= 3.0 and AuTravailleChantier then

            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour travailler.")
            if IsControlJustPressed(1, 51) and dstToMarker <= 3.0 then
              RemoveBlip(blip)
              EnAction = true
              SetEntityCoords(pPed, v.pos, 0.0, 0.0, 0.0, 0)
              SetEntityHeading(pPed, v.Heading)
              TaskStartScenarioInPlace(pPed, v.scenario, 0, true)
              TriggerServerEvent("freejobs:pay", "chantier", security(12), security(15))
              Citizen.Wait(10000)
              ClearPedTasksImmediately(ESX.PlayerData.cache.playerped)
              break
            end
          end
        end
        if DoesBlipExist(blip) then
          RemoveBlip(blip)
        end
      end
    end
  end
end

function OpenMenuChefChantier()
  local ChantierMenu = {
    Base = { Title = "Chantier", HeaderColor = {116, 50, 140} },
    Data = { currentMenu = "chantier" },

    Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)
      if btn.action == "StartJob" then
        ESX.ShowNotification("Alors comme ça tu veux bosser sur le chantier hein ? Très bien ! Commence maintenant.")
        TriggerEvent("getSkin", function(skin)
        local clothesSkin = {
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['tshirt_1'] = 59, ['tshirt_2'] = 0,
          ['torso_1'] = 56, ['torso_2'] = 0,
          ['arms'] = 30,
          ['pants_1'] = 31, ['pants_2'] = 0,
          ['shoes_1'] = 25, ['shoes_2'] = 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['bproof_1'] = 0, ['bproof_2'] = 0,
          ['helmet_1'] = 0, ['helmet_2'] = 0,
        }
        TriggerEvent("loadClothes", skin, clothesSkin)
        CloseMenu()
        StartTravailleChantier()
        end)
      elseif btn.action == "StopJob" then
        AuTravailleChantier = false
        ESX.ShowNotification("Haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, reviens quand tu veux.")
        TriggerEvent("esx:restoreLoadout")
        ESX.TriggerServerCallback('skin:getPlayerSkin', function(skin)
					TriggerEvent('loadSkin', skin)
				end)
        CloseMenu()
      end
    end
  },

  Menu = {
    ["chantier"] = {
      b = {}
    },
  }
}

if not AuTravailleChantier then
table.insert(ChantierMenu.Menu["chantier"].b, {name = "Demander à travailler", action = "StartJob", ask = "→", askX = true})
else
table.insert(ChantierMenu.Menu["chantier"].b, {name = "Arreter de travailler", action = "StopJob", ask = "→", askX = true})
end

CreateMenu(ChantierMenu)
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, Chantier, true)
  if distance <= 3.0 then
    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler avec la personne.")
    if IsControlJustReleased(1, 51) and distance <= 3.0 then
      OpenMenuChefChantier()
    end
  else
    Citizen.Wait(1000)
  end
end
end)

Citizen.CreateThread(function()
  local blip = AddBlipForCoord(Chantier)

  SetBlipSprite (blip, 317)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.9)
  SetBlipColour (blip, 5)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName("Chantier")
  EndTextCommandSetBlipName(blip)
end)