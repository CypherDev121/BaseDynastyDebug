StoreConfig = {}

StoreConfig.Weapons = {
    {
        NameWeapon = "weapon_assaultrifle",
        Point = "5000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/880306428617834537/894683253452177428/AssaultRifle-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_heavysniper",
        Point = "10000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556872943525939/HeavySniper-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_marksmanpistol",
        Point = "3500",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556893789204481/MarksmanPistol-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_combatpdw",
        Point = "4000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556842824224868/CombatPDW-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_pumpshotgun",
        Point = "7500",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556923585540116/PumpShotgun-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_microsmg",
        Point = "3000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556842824224868/CombatPDW-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_assaultsmg",
        Point = "4500",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556826055376926/AssaultSMG-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_specialcarbine",
        Point = "6000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556937007317012/SpecialCarbine-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_bullpuprifle",
        Point = "6000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556834813116456/BullpupRifle-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_gusenberg",
        Point = "7000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556863086891108/GusenbergSweeper-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_compactrifle",
        Point = "4500",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556852131381328/CompactRifle-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_appistol",
        Point = "4000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556958377287681/APPistol-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_advancedrifle",
        Point = "5000",
        Type = "perm",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556948218699817/AdvancedRifle-GTAV-removebg-preview.png"
    },
    {
        NameWeapon = "weapon_pistol50", 
        Point = "1000",
        Type = "normal",
        Preview = "https://media.discordapp.net/attachments/885216644538961972/897556914689421382/Pistol.50-GTAV-removebg-preview.png"
    }
}

StoreConfig.Packs = {
    ["illegal"] = {
        name = "Pack Illegal",
        price = 3000,
        type = "illegal",
        loots = {
            {name = "~r~500.000$", type = "money", item = "black_money", amount = 500000},
            {name = "~r~Micro SMG", type = "weapon", item = "weapon_microsmg", amount = 250},
            {name = "~r~Mercedes-Benz GT63 AMG", type = "vehicle", item = "rmodgt63", amount = 1}
        }
    },
    ["legal"] = {
        name = "Pack legal",
        price = 2500,
        type = "legal",
        loots = {
            {name = "~g~300.000$", type = "money", item = "money", amount = 300000},
            {name = "~g~BMW X5M", type = "vehicle", item = "20x5m", amount = 1}
        }
    }
}

StoreConfig.RoueDrops = {
    ["epic"] = {
        [1] = {name = "Mercedes-Benz GT 63S AMG", type = "vehicle", item = "rmodgt63", amount = 1, native = false},
        [2] = {name = "200.000$", type = "account", item = "money", amount = 200000},
        [3] = {name = "yz450f", type = "vehicle", item = "yzfsm", amount = 1, native = false}
    }, 
    ["rare"] = {
        [1] = {name = "100.000$", type = "account", item = "money", amount = 100000},
        [2] = {name = "50.000$", type = "account", item = "money", amount = 50000},
        [3] = {name = "25.000$", type = "account", item = "money", amount = 25000}
    },
    ["common"] = {
        [1] = {name = "10.000$", type = "account", item = "money", amount = 10000},
        [2] = {name = "15.000$", type = "account", item = "money", amount = 15000},
        [3] = {name = "20.000$", type = "account", item = "money", amount = 20000}
    }
}

StoreConfig.Vehicles = {
    {name = "Bugatti Bolide", data = {
        Point = "5000",
        NameVehicle = "rmodbolide" },
    },
    {name = "Lamborghini huracan performante", data = {
        Point = "4500",
        NameVehicle = "18performante" },
    },
    {name = "Bugatti La voiture noire", data = {
        Point = "4500",
        NameVehicle = "rmodbugatti" },
    },
    {name = "Lamborghini Veneno", data = {
        Point = "4500",
        NameVehicle = "veneno" },
    },
    {name = "Lamborghini Urus 2018", data = {
        Point = "4000",
        NameVehicle = "urus" },
    },
    {name = "Porsche 911 Turbo S", data = {
        Point = "4000",
        NameVehicle = "pts21" },
    },
    {name = "Brabus 700", data = {
        Point = "3500",
        NameVehicle = "bg700w" },
    },
    {name = "Audi RS6", data = {
        Point = "3500",
        NameVehicle = "rmodrs6" },
    },    
    {name = "BMW M8", data = {
        Point = "3500",
        NameVehicle = "bmwm8" },
    },
    {name = "BMW I8", data = {
        Point = "3500",
        NameVehicle = "rmodmi8lb" },
    },
    {name = "Audi RS7 R", data = {
        Point = "3500",
        NameVehicle = "rs7r" },
    },
    {name = "BMW X5M", data = {
        Point = "3000",
        NameVehicle = "20x5m" },
    },
    {name = "Mercedes-Benz GT63 AMG", data = {
        Point = "3000",
        NameVehicle = "rmodgt63" },
    },
    {name = "Mercedes-Benz A45 AMG", data = {
        Point = "2500",
        NameVehicle = "a45" },
    },
    {name = "Audi RS3", data = {
        Point = "2500",
        NameVehicle = "rs318" },
    },
    {name = "Tmax", data = {
        Point = "1500",
        NameVehicle = "TmaxDX" },
    },
    {name = "XADV", data = {
        Point = "1500",
        NameVehicle = "xadv" },
    },
    {name = "Kawasaki KX450F", data = {
        Point = "1000",
        NameVehicle = "kx450f" },
    }

}

AddonVehicles = {
    ['18performante'] = 836213613,
    ['20x5m'] = -658586604,
    ['a45'] = -910466076,
    ['bg700w'] = -1217170464,
    ['bmwm8'] = -1404319008,
    ['kx450f'] = 333512375,
    ['pts21'] = 1694479740,
    ['rmodbolide'] = -1381125554,
    ['rmodbugatti'] = -101696514,
    ['rmodgt63'] = 980885719,
    ['rmodmi8lb'] = -1476696782,
    ['rmodrs6'] = 422090481,
    ['rs7r'] = 1260387191,
    ['rs318'] = 216350205,
    ['tmaxDX'] = -392138597,
    ['urus'] = -520214134,
    ['veneno'] = -42051018,
    ['xadv'] = 1393595816,
}