function verifyName(name)
	-- Don"t allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return "⚠️ Votre nom de joueur est trop court ou trop long."
	end
	
	-- Don"t allow special characters (doesn"t always work)
	local count = 0

	for i in name:gmatch("[abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]") do
		count = count + 1
	end

	if count ~= nameLength then
		return "⚠️ Votre nom contient des accents (é,è... veuillez les supprimer."
	end
	
	-- Does the player carry a first and last name?
	-- 
	-- Example:
	-- Allowed:     "Bob Joe"
	-- Not allowed: "Bob"
	-- Not allowed: "Bob joe"
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, "%S+") do

		if string.match(word, "%u") then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return "⚠️ Votre nom contient plus de deux espaces."
	end
	
	if spacesWithUpper ~= spacesInName then
		return "⚠️ Votre nom et prénom doivent commencer par une lettre majuscule."
	end

	return ""
end

function checkIdentity()
    for k, v in pairs(CreatorData.Identity) do
        if v == "" or v == 0 then
            ESX.ShowNotification("⚠️ Veuillez remplir tous les champs.")
            return false
        end
        return true
    end
  end