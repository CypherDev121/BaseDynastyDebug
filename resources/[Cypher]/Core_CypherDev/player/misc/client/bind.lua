local handsUp = false

-- HandsUP
RegisterCommand("+handsUp", function()
if not ESX.PlayerData.IsDead then
  local ped = ESX.PlayerData.cache.playerped
  if handsup then
    if DoesEntityExist(ped) then
      Citizen.CreateThread(function()
      RequestAnimDict("random@mugging3")
      while not HasAnimDictLoaded("random@mugging3") do
        Citizen.Wait(100)
      end

      if handsup then
        handsup = false
        ClearPedSecondaryTask(ped)
      end
      end)
    end
  else
    if DoesEntityExist(ped) then
      Citizen.CreateThread(function()
      RequestAnimDict("random@mugging3")
      while not HasAnimDictLoaded("random@mugging3") do
        Citizen.Wait(100)
      end

      if not handsup then
        handsup = true
        TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
      end
      end)
    end
  end
end
end, false)

-- Ragdoll
RegisterCommand("+ragdoll", function()
if not ESX.PlayerData.IsDead then
local myPed = ESX.PlayerData.cache.playerped
SetPedToRagdoll(myPed, 5000, 5000, 0, 0, 0, 0)
ResetPedRagdollTimer(myPed)
end
end, false)

local handsup = false
local crouched = false


RegisterCommand("+crouch", function()
  DisableControlAction(1, 36, true)
	DisableControlAction(2, 36, true)
    local ped = ESX.PlayerData.cache.playerped
    if not ESX.PlayerData.IsDead and not IsPauseMenuActive() then 
    RequestAnimSet( "move_ped_crouched" )

    while (not HasAnimSetLoaded( "move_ped_crouched" )) do 
        Citizen.Wait(100)
    end 

    if (crouched == true )then 
        ResetPedMovementClipset( ped, 0 )
        crouched = false 
    elseif (crouched == false) then
        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
        crouched = true 
    end 
end
end)

RegisterCommand("+crossarms", function()
    local ped = ESX.PlayerData.cache.playerped
    if not ESX.PlayerData.IsDead and not IsPauseMenuActive() then 
    if not handsup then
        TaskPlayAnim(ESX.PlayerData.cache.playerped, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(ESX.PlayerData.cache.playerped)
    end
end
end)

-- Menu perso
RegisterCommand("+menuperso", function()
  if not ESX.PlayerData.IsDead then
  OpenPersonalMenu()
  end
end, false)

-- Menu Illegal
RegisterCommand("+menuillegal", function()
  if not ESX.PlayerData.IsDead then
    OpenGangActionsMenu()
  end
end, false)

RegisterKeyMapping("+menuanim", "Menu animations", "keyboard", "f3")
RegisterKeyMapping("+menuperso", "Menu personnel", "keyboard", "f5")
RegisterKeyMapping("+menuillegal", "Menu Illegal", "keyboard", "f7")
RegisterKeyMapping("+handsUp", "Lever les mains", "keyboard", "i")
RegisterKeyMapping("+ragdoll", "Tomber par terre", "keyboard", "numpad5")
RegisterKeyMapping("+stopanim", "Arreter animation", "keyboard", "x")
RegisterKeyMapping("+crouch", "S'accroupir", "keyboard", "lcontrol")
RegisterKeyMapping("+crossarms", "Croiser les bras", "keyboard", "b")
RegisterKeyMapping("+vipmenu", "Vip Menu", "keyboard", "f11")
