PoliceStations = {
    ["police"] = {
        label = "~b~[Services Public]~s~ | Commissariat Vespucci",
        type = "south",
        zones = {
            ["boss"] = vector3(462.3, -985.1, 29.7),
            ["cloakrooms"] = vector3(462.0, -996.5, 29.6),
            ["cars"] = vector3(451.6, -1019.2, 27.4),
            ["helicopters"] = vector3(449.2, -981.29, 42.69),
            ["armory"] = vector3(485.7, -996.9, 29.6)
        }
    }
}

PoliceUniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 45,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 24,     ['bags_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0

		},
		female = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0,
			['torso_1'] = 63,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 37,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 22,     ['bags_2'] = 3,
			['helmet_1'] = 23,  ['helmet_2'] = 0,
			['glasses_1'] = 11, ['glasses_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 86,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 45,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 24,     ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0,
			['torso_1'] = 64,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 37,   ['shoes_2'] = 0,
			['chain_1'] = 19,    ['chain_2'] = 0,
			['bags_1'] = 22,     ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = -1, ['glasses_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 67,   ['pants_2'] = 0,
			['shoes_1'] = 73,   ['shoes_2'] = 0,
			['chain_1'] = 61,    ['chain_2'] = 0,
			['bags_1'] = 42,    ['bags_2'] = 1,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 12,     ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 117,  ['tshirt_2'] = 0,
			['torso_1'] = 90,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 37,   ['shoes_2'] = 0,
			['chain_1'] = 37,    ['chain_2'] = 0,
			['bags_1'] = 37,     ['bags_2'] = 1,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = -1, ['glasses_2'] = 0
		}
	},
	lieutenant_wear = { 
		male = {
			['tshirt_1'] = 96,  ['tshirt_2'] = 0,
			['torso_1'] = 104,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 74,   ['shoes_2'] = 0,
			['chain_1'] = 61,    ['chain_2'] = 0,
			['bags_1'] = 42,     ['bags_2'] = 2,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 117,  ['tshirt_2'] = 0,
			['torso_1'] = 90,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 37,   ['shoes_2'] = 0,
			['bags_1'] = 37,     ['bags_2'] = 1,
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 42,  ['bproof_2'] = 0
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}

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

function CheckIsPolice(job)
    if PoliceStations[job] then
        return true
    else
        return false
    end
end