local delGunActive = false
local WhiteGunActive = false
local delGunVehActive = false

local function RequestControlAndDeleteVeh(entity)
  local NetID = NetworkGetNetworkIdFromEntity(entity)
  if NetID ~= nil and NetID ~= 0 then
  TriggerServerEvent("admin:delVeh", NetID)
  end
end

AddEventHandler("esx:delGunVeh", function()
  delGunVehActive = not delGunVehActive
  if delGunVehActive then
    GiveWeaponToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", 255, false, true)
		SetPedInfiniteAmmo(ESX.PlayerData.cache.playerped, true, "weapon_snspistol_mk2")
		GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE")
		GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_SUPP_02")
		GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_SNSPISTOL_MK2_CLIP_02")
		GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_RAIL_02")
		GiveWeaponComponentToPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2", "COMPONENT_AT_PI_FLSH_03")
  else
		SetPedInfiniteAmmo(ESX.PlayerData.cache.playerped, false, "weapon_snspistol_mk2")
		RemoveWeaponFromPed(ESX.PlayerData.cache.playerped, "weapon_snspistol_mk2")
	end
end)

Citizen.CreateThread(function()
local result2, entity2
 while true do
  Citizen.Wait(5)
  if delGunVehActive then
    if IsControlJustReleased(0, 24) then
      result2, entity2 = GetEntityPlayerIsFreeAimingAt(PlayerId())
      if not IsEntityAPed(entity2) then

        if not RequestControlAndDeleteVeh(entity2) then
          SetEntityAlpha(entity2, 100)
          DetachEntity(entity2, true, true)
          SetEntityCoords(entity2, -309.8, -3245.0, -24.5, 0.0, 0.0, 0.0, 0)
        end
      end
    end
  else
    Citizen.Wait(1000)
  end
 end
end)