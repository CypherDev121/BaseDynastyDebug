ACConfig = {}

ACConfig.Name = "TarekAC"

ACConfig.Version = "1.0.0"

ACConfig.Prefix = "^3[^1" .. ACConfig.Name .."^3] ^0"

ACConfig.Enable = true

ACConfig.WhiteListedResources = {
    ['Tarek'] = true,
}

ACConfig.ServerType = {
    ESX = true,
    Framework = true,
    Other = false
}