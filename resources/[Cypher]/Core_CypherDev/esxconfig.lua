Config = {}

Config.Accounts = {
	bank = "banque",
	black_money = "argent sale",
	money = "espèces"
}

Config.StartingAccountMoney = {money = 0, bank = 0}

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: society
Config.EnableHud            = true -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            = 150   -- the max inventory weight without backpack
Config.PaycheckInterval     = 10 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug          = false
Config.Licenses             = {
	["weapon"] = {name = "Permis de port d'arme", type = "weapon"},
	["car"] = {name = "Permis de conduire", type = "car"}
}

ESXConfig = {}

ESXConfig.ServerName = "NyseraRP"
ESXConfig.ShopURL = "tebex.NyseraRP.pro"
ESXConfig.DiscordURL = "discord.gg/NyseraRP"
ESXConfig.ConnectURL = "https://cf.NyseraRP.pro"
ESXConfig.RichPresenceID = 00000000000
ESXConfig.DefaultColorCode = '~b~'
ESXConfig.StorePointsName = 'DynaCoins'
ESXConfig.DevMode = false
ESXConfig.Developers = {
	["d967b2887918abcf8cf22a832446a82504ec0359"] = true,
}

ESXConfig.Pmenu = {
    Couleur = {
        r = 16,
        g = 16,
        b = 16,
        o = 200
    }
}

ESXConfig.Ambulance = {
    CentralLosSantos = {
        Blip = {
            coords = vector3(-677.3461, 308.9629, 83.08404),
            sprite = 61,
            scale = 1.2,
            color = 2
        },
        AmbulanceActions = {
            vector3(-681.517, 329.1706, 83.08317)
        },
        Pharmacies = {
            vector3(-676.2057, 333.6342, 83.08315)
        },
        Vehicles = {
            {
                Spawner = vector3(-671.8825, 335.4448, 78.11838),
                Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
                SpawnPoints = {
                    { coords = vector3(-668.3279, 350.3305, 78.11839), heading = 173.55532836914, radius = 4.0 },
                    { coords = vector3(-668.3279, 350.3305, 78.11839), heading = 173.55532836914, radius = 4.0 }
                }
            }
        },
        Helicopters = {
            {
                Spawner = vector3(-680.9655, 320.5713, 140.1482),
                Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
                SpawnPoints = {
                    { coords = vector3(-687.1061, 320.9795, 140.1482), heading = 169.86526489258, radius = 10.0 }
                }
            }
        }
    }
}

ESXConfig.Gouvernement = {
    GouvActions = {
        Pos = vector3(-544.48, -199.28, 46.55),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    },
    Armory = {
        Pos = vector3(-572.38, -202.62, 41.7),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    },
    VehicleSpawner = {
        Pos = vector3(-513.12, -262.75, 34.43),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    },
    VehicleDeleter = {
        Pos = vector3(-523.73, -267.35, 34.3),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    },
    HelicopterSpawner = {
        Pos = vector3(-549.85, -242.95, 35.82),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    },
    HelicopterDeleter = {
        Pos = vector3(-542.35, -251.64, 36.58),
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu."
    }
}

ESXConfig.Joalerie = {
    Vente = {
        Prix = {250, 500},
        ItemSell = {1, 5}
    },
    JoalActions = {
        Pos = vector3(228.1, 766.1, 203.7),
        Name = "Point d'action",
        Type = 0,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu."
    },
    JewelFarm = {
        Pos = vector3(-1023.8, 693.2, 160.2),
        Name = "Récolte de bijoux",
        AddItem = {1, 3},
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des bijoux."
    },
    SellFarm = {
        Pos = vector3(-619.5, -228.9, 37.0),
        Name = "Vente des bijoux",
        Type = 1,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour vendre vos bijoux."
    },
    VehicleSpawner = {
        Pos = vector3(218.5, 756.8, 203.7),
        Name = "Garage véhicule",
        Type = 0,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule."
    },
    VehicleSpawnPoint = {
        Pos = vector3(200.9, 781.9, 205.0),
        Name = "Spawn point",
        Type = -1
    },
    VehicleDeleter = {
        Pos = vector3(207.8, 767.7, 204.3),
        Name = "Ranger son véhicule",
        Type = 0,
        Text = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule."
    }
}

ESXConfig.Bennys = {
    Zone = {
        BennysActions = {
            Pos = vector3(-206.7, -1341.7, 33.8),
            Size = { x = 1.5, y = 1.5, z = 1.0 },
            Color = { r = 204, g = 204, b = 0 },
            Type = 1,
            Text = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
        }
    },

    Blips = {
        LsCustoms = {
            Name = "[Entreprise] | Benny's",
            Sprite = 72,
            Colour = 4,
            Locations = {
                vector3(-211.0, -1324.1, 30.8)
            }
        }
    },

    MecanoListe = {
        ["bennys"] = {
            type = "cosmetics",
            label = "[Entreprise] | Benny's",
            zones = {
                ["actions"] = vector3(-41.8494, -1064.283, 28.39651),
                ["lscustom"] = vector3(-33.95087, -1054.528, 28.39649)
            }
        },
        ["mechanic"] = {
            type = "upgrades",
            label = "[Entreprise] | LSCustom",
            zones = {
                ["actions"] = vector3(-336.3573, -131.6194, 39.00969),
                ["lscustom"] = vector3(-333.0797, -132.7566, 39.00972)
            }
        }
    }
}

ESXConfig.Police = {
    PoliceStations = {
        ["police"] = {
            label = "~b~[Services Public]~s~ | Commissariat Mission Row",
            type = "south",
            zones = {
                ["boss"] = vector3(436.0112, -999.0717, 35.68366),
                ["cloakrooms"] = vector3(465.0967, -998.5455, 30.72281),
                ["cars"] = vector3(455.3233, -979.1391, 25.70975),
                ["helicopters"] = vector3(449.4608, -981.3274, 43.69131),
                ["armory"] = vector3(455.0286, -996.509, 30.71071)
            }
        }
    },

    PoliceUniforms = {
        recruit_wear = {
            male = {
                ['tshirt_1'] = 36, ['tshirt_2'] = 0,
                ['torso_1'] = 85, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 34, ['pants_2'] = 0,
                ['shoes_1'] = 45, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['bags_1'] = 24, ['bags_2'] = 0,
                ['helmet_1'] = 50, ['helmet_2'] = 0,
                ['glasses_1'] = 0, ['glasses_2'] = 0
            },
            female = {
                ['tshirt_1'] = 56, ['tshirt_2'] = 0,
                ['torso_1'] = 63, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 28, ['pants_2'] = 0,
                ['shoes_1'] = 37, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['bags_1'] = 22, ['bags_2'] = 3,
                ['helmet_1'] = 23, ['helmet_2'] = 0,
                ['glasses_1'] = 11, ['glasses_2'] = 0
            }
        },
        officer_wear = {
            male = {
                ['tshirt_1'] = 36, ['tshirt_2'] = 0,
                ['torso_1'] = 86, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 1,
                ['pants_1'] = 34, ['pants_2'] = 0,
                ['shoes_1'] = 45, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['bags_1'] = 24, ['bags_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = 0, ['glasses_2'] = 0
            },
            female = {
                ['tshirt_1'] = 56, ['tshirt_2'] = 0,
                ['torso_1'] = 64, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 28, ['pants_2'] = 0,
                ['shoes_1'] = 37, ['shoes_2'] = 0,
                ['chain_1'] = 19, ['chain_2'] = 0,
                ['bags_1'] = 22, ['bags_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = -1, ['glasses_2'] = 0
            }
        },
        sergeant_wear = {
            male = {
                ['tshirt_1'] = 36, ['tshirt_2'] = 0,
                ['torso_1'] = 97, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 67, ['pants_2'] = 0,
                ['shoes_1'] = 73, ['shoes_2'] = 0,
                ['chain_1'] = 61, ['chain_2'] = 0,
                ['bags_1'] = 42, ['bags_2'] = 1,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = 0, ['glasses_2'] = 0,
                ['mask_1'] = 12, ['mask_2'] = 0
            },
            female = {
                ['tshirt_1'] = 117, ['tshirt_2'] = 0,
                ['torso_1'] = 90, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 28, ['pants_2'] = 0,
                ['shoes_1'] = 37, ['shoes_2'] = 0,
                ['chain_1'] = 37, ['chain_2'] = 0,
                ['bags_1'] = 37, ['bags_2'] = 1,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = -1, ['glasses_2'] = 0
            }
        },
        lieutenant_wear = {
            male = {
                ['tshirt_1'] = 96, ['tshirt_2'] = 0,
                ['torso_1'] = 104, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 1,
                ['pants_1'] = 34, ['pants_2'] = 0,
                ['shoes_1'] = 74, ['shoes_2'] = 0,
                ['chain_1'] = 61, ['chain_2'] = 0,
                ['bags_1'] = 42, ['bags_2'] = 2,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = 0, ['glasses_2'] = 0
            },
            female = {
                ['tshirt_1'] = 117, ['tshirt_2'] = 0,
                ['torso_1'] = 90, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 14,
                ['pants_1'] = 28, ['pants_2'] = 0,
                ['shoes_1'] = 37, ['shoes_2'] = 0,
                ['bags_1'] = 37, ['bags_2'] = 1,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['glasses_1'] = -1, ['glasses_2'] = 0
            }
        },
        bullet_wear = {
            male = {
                ['bproof_1'] = 7, ['bproof_2'] = 0
            },
            female = {
                ['bproof_1'] = 42, ['bproof_2'] = 0
            }
        },
        gilet_wear = {
            male = {
                ['tshirt_1'] = 59, ['tshirt_2'] = 1
            },
            female = {
                ['tshirt_1'] = 36, ['tshirt_2'] = 1
            }
        }
    },

    PoliceWeapons = {
        ["recruit"] = {
            { weapon = 'WEAPON_NIGHTSTICK', price = 2000 },
            { weapon = 'WEAPON_STUNGUN', price = 5000 },
            { weapon = 'WEAPON_FLASHLIGHT', price = 1000 }
        },
        ["officer"] = {
            { weapon = 'WEAPON_PISTOL', price = 5000 },
            { weapon = 'WEAPON_NIGHTSTICK', price = 2000 },
            { weapon = 'WEAPON_STUNGUN', price = 5000 },
            { weapon = 'WEAPON_FLASHLIGHT', price = 1000 }
        },
        ["sergeant"] = {
            { weapon = 'WEAPON_PISTOL', price = 5000 },
            { weapon = 'WEAPON_NIGHTSTICK', price = 2000 },
            { weapon = 'WEAPON_STUNGUN', price = 5000 },
            { weapon = 'WEAPON_FLASHLIGHT', price = 1000 },
            { weapon = 'WEAPON_ADVANCEDRIFLE', price = 15000 }
        },
        ["lieutenant"] = {
            { weapon = 'WEAPON_PISTOL', price = 5000 },
            { weapon = 'WEAPON_NIGHTSTICK', price = 2000 },
            { weapon = 'WEAPON_STUNGUN', price = 5000 },
            { weapon = 'WEAPON_FLASHLIGHT', price = 1000 },
            { weapon = 'WEAPON_PUMPSHOTGUN', price = 12000 },
            { weapon = 'WEAPON_ADVANCEDRIFLE', price = 15000 }
        },
        ["boss"] = {
            { weapon = 'WEAPON_PISTOL', price = 5000 },
            { weapon = 'WEAPON_NIGHTSTICK', price = 2000 },
            { weapon = 'WEAPON_STUNGUN', price = 5000 },
            { weapon = 'WEAPON_FLASHLIGHT', price = 1000 },
            { weapon = 'WEAPON_PUMPSHOTGUN', price = 12000 },
            { weapon = 'WEAPON_ADVANCEDRIFLE', price = 15000 },
            { weapon = 'WEAPON_SNIPERRIFLE', price = 20000 }
        }
    }
}

ESXConfig.AgentImmobilier = {
    DrawDistance = 10.0,
    MarkerColor  = { r = 120, g = 120, b = 240 },

    Zones = {
        OfficeEnter = {
            Pos   = { x = -199.151, y = -575.000, z = 39.489 },
            Size  = { x = 1.5, y = 1.5, z = 1.0 },
            Type  = 1
        },

        OfficeExit = {
            Pos   = { x = -141.226, y = -614.166, z = 167.820 },
            Size  = { x = 1.5, y = 1.5, z = 1.0 },
            Type  = 1
        },

        OfficeInside = {
            Pos   = { x = -140.969, y = -616.785, z = 167.820 },
            Size  = { x = 1.5, y = 1.5, z = 1.0 },
            Type  = -1
        },

        OfficeOutside = {
            Pos   = { x = -202.238, y = -578.193, z = 39.500 },
            Size  = { x = 1.5, y = 1.5, z = 1.0 },
            Type  = -1
        },

        OfficeActions = {
            Pos   = { x = -124.786, y = -641.486, z = 167.820 },
            Size  = { x = 1.5, y = 1.5, z = 1.0 },
            Type  = -1
        }
    }
}