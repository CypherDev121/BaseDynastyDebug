--RegisterCommand("anim", function()
--    StartCreatorEndCinematic()
--end)

function DestroyAllProps()
	for _, v in pairs(PlayerProps) do
		DeleteEntity(v)
	end

	PlayerHasProp = false
end

function StartCreatorEndCinematic()
    DoScreenFadeOut(1000)
    local blockControls = true
    pPed = ESX.PlayerData.cache.playerped
    DisplayRadar(false)
    TriggerEvent('esx:displayHud', false)
    TriggerEvent('esx:ToggleCinematic')
    PlayUrl("cin_music", "https://www.youtube.com/watch?v=F1Vx-9TUyzA", 0.2, false)

    Citizen.CreateThread(function()
        while blockControls do
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 4, true)
            DisableControlAction(1, 6, true)
            DisableControlAction(1, 270, true)
            DisableControlAction(1, 271, true)
            DisableControlAction(1, 272, true)
            DisableControlAction(1, 273, true)
            DisableControlAction(1, 282, true)
            DisableControlAction(1, 283, true)
            DisableControlAction(1, 284, true)
            DisableControlAction(1, 285, true)
            DisableControlAction(1, 286, true)
            DisableControlAction(1, 290, true)
            DisableControlAction(1, 291, true)
            Wait(5)
            for v in EnumeratePeds() do
                if v ~= pPed then
                    SetEntityAlpha(v, 0, 0)
                    SetEntityNoCollisionEntity(pPed, v, false)
                    NetworkConcealPlayer(NetworkGetPlayerIndexFromPed(v), true, 1)
                end
            end
        end
        for v in EnumeratePeds() do
            if v ~= pPed then
                ResetEntityAlpha(v)
                SetEntityNoCollisionEntity(v, pPed, true)
                NetworkConcealPlayer(NetworkGetPlayerIndexFromPed(v), false, 1)
            end
        end
    end)
    TriggerEvent('esx:toggleLogo')
    while not IsScreenFadedOut() do Wait(3000) end
    Wait(2000)
    NetworkOverrideClockTime(18, 00, 0)
    SetOverrideWeather("EXTRASUNNY")
    SetEntityCoordsNoOffset(pPed, 300.4, 200.13, 103.35, 0.0, 0.0, 0.0)
    SetEntityHeading(pPed, 160.57)

    -- Default
    local cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local cam1 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    

    local pos = GetOffsetFromEntityInWorldCoords(pPed, 1.0, 1.0, 1.5)
    local posLook = GetOffsetFromEntityInWorldCoords(pPed, 0.0, 0.0, 1.7)

    SetCamActive(cam1, 1)
    SetCamCoord(cam1, pos.x, pos.y, pos.z)
    SetCamFov(cam1, 75.0)
    PointCamAtCoord(cam1, posLook.x, posLook.y, posLook.z)

    RenderScriptCams(1, 1, 0, 0, 0)
    TaskStartScenarioInPlace(pPed, "CODE_HUMAN_CROSS_ROAD_WAIT", -1, 0)
    DoScreenFadeIn(1500)
    TriggerEvent('esx:toggleLogo')

    -- Cam 2
    local pos = GetOffsetFromEntityInWorldCoords(pPed, -1.0, 1.0, 1.5)
    local posLook = GetOffsetFromEntityInWorldCoords(pPed, 0.0, 0.0, 1.7)

    SetCamActive(cam2, 1)
    SetCamCoord(cam2, pos.x, pos.y, pos.z)
    SetCamFov(cam2, 20.0)
    PointCamAtCoord(cam2, posLook.x, posLook.y, posLook.z)
    SetCamActiveWithInterp(cam2, cam1, 12000, 1, 1)
    Wait(11500)


    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(1) end

    --[[local pos = vector3(289.61, 192.79, 80.16)
    SetCamCoord(cam2, pos.x, pos.y, pos.z)
    PointCamAtEntity(cam2, pPed, 1.0, 1.0, 1.0, 0)
    SetCamFov(cam2, 15.0)
    
    Wait(7000)]]
    ClearPedTasks(pPed)
    TaskGoToCoordAnyMeans(pPed, 292.73, 179.46, 103.28, 1.0, 0, 0, 786603, 0)
    DoScreenFadeIn(500)

    local pos = vector3(294.03, 149.44, 113.05)
    SetCamCoord(cam2, pos.x, pos.y, pos.z)
    PointCamAtEntity(cam2, pPed, 1.0, 1.0, 1.0, 0)
    SetCamFov(cam2, 35.0)

    RenderScriptCams(0, 1, 12000, 0, 0)
    Wait(11000)
    blockControls = false
    TriggerEvent('esx:displayHud', true)
    DisplayRadar(true)
    local vol = 1.0
    while vol > 0.0 do
        vol = getVolume("cin_music") - 0.02
        setVolume("cin_music", vol)
        Wait(500)
    end
    Destroy("cin_music")
    ClearPedTasks(ESX.PlayerData.cache.playerped)
    TriggerEvent('esx:StopAnims')
    TriggerEvent('esx:ToggleCinematic')
    ESX.ShowNotification("Bienvenue à vous sur " .. ESXConfig.ServerName .. " !")
    ESX.ShowNotification("N'oubliez pas le /afk qui vous permet de gagner de l'argent en étant afk !")
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = ESX.PlayerData.cache.playerped
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
