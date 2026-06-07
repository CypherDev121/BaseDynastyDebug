ACConfig = {}

ACConfig.Name = "CypherAC"

ACConfig.Version = "1.0.0"

ACConfig.Prefix = "^3[^1" .. ACConfig.Name .."^3] ^0"

ACConfig.Enable = true

ACConfig.WhiteListedResources = {
    ['Cypher'] = true,
}

ACConfig.ServerType = {
    ESX = true,
    Framework = true,
    Other = false
}