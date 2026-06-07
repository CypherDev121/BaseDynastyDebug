CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false
local PlayerSpawned = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    if not PauseVSync then
    CurrentWeather = NewWeather
    blackout = newblackout
    if lastWeather ~= CurrentWeather then
        lastWeather = CurrentWeather
        SetWeatherTypeOverTime(CurrentWeather, 15.0)
        Citizen.Wait(15000)
    end
    SetBlackout(blackout)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(lastWeather)
    SetWeatherTypeNow(lastWeather)
    SetWeatherTypeNowPersist(lastWeather)
    if lastWeather == 'XMAS' then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

RegisterNetEvent("esx:passjoin")
AddEventHandler("esx:passjoin", function()
	PlayerSpawned = true
    TriggerServerEvent('vSync:requestSync')
    Citizen.CreateThread(function()
        local hour = 0
        local minute = 0
        while true do
            Citizen.Wait(100)
            if not PauseVSync then
            local newBaseTime = baseTime
            if GetGameTimer() - 500  > timer then
                newBaseTime = newBaseTime + 0.25
                timer = GetGameTimer()
            end
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime			
            end
            baseTime = newBaseTime
            hour = math.floor(((baseTime+timeOffset)/60)%24)
            minute = math.floor((baseTime+timeOffset)%60)
            NetworkOverrideClockTime(hour, minute, 0)
            else
            Wait(1000)
            end
        end
    end)
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)
