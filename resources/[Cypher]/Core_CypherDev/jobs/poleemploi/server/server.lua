JobsZones = {
    ["chantier"] = vector3(-509.94, -1001.59, 22.55)
}

RegisterServerEvent('freejobs:pay')
AddEventHandler('freejobs:pay', function(job, sec1, sec2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = 0
    if job == 'chantier' then
        amount = 150
    else
        DropPlayer(source, "C'est pas bien de trigger")
        return
    end
    if sec1:len() == 12 and sec2:len() == 15 then
        if CheckJobsCoords(source, job) then
        xPlayer.addMoney(amount)
        end
    else
        DropPlayer(source, "C'est pas bien de trigger")
    end
end)

function CheckJobsCoords(source, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local coords = JobsZones[zone]
	local playerped = GetPlayerPed(source)
	local playercoords = GetEntityCoords(playerped)

	if xPlayer then
		if #(playercoords - coords) < 100 then
			return true
		else
			TriggerEvent("CypherAC:sendLog", source, "Jobs Auto-Farm attempt")
			TriggerEvent("CypherAC:requestPlayerBan", source)
		end
	else
		DropPlayer(source, "Désynchronisation ou stop resource")
	end

	return false
	
end