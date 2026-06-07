Citizen.CreateThread(function()
	while not ESX.PlayerData.PassJoin do
		Wait(0)
	end
	while true do
		Citizen.Wait(0) -- prevent crashing
		DisablePlayerVehicleRewards(PlayerId())

		-- These natives have to be called every frame.
		SetPedDensityMultiplierThisFrame(0.2) -- set npc/ai peds density to 0
		SetRandomVehicleDensityMultiplierThisFrame(0.2) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
		SetScenarioPedDensityMultiplierThisFrame(0, 0) -- set random npc/ai peds or scenario peds to 0
		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
		SetRandomBoats(true) -- Stop random boats from spawning in the water.
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
		local x,y,z = table.unpack(ESX.PlayerData.cache.coords)
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        SetParkedVehicleDensityMultiplierThisFrame(0.2)
        SetVehicleDensityMultiplierThisFrame(0.2)
	end
end)