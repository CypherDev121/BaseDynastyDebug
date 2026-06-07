Config = {}

Config.Zones = {
    yacht = {
        name = "Zone Yacht",
        center = vector3(-2072.463, -1021.597, 6.00584),
        radius = 60.0,
        spawns = {
            vector3(-2043.0, -1031.0, 11.0)
        },
        exitCoords = vector3(215.76, -810.12, 30.73),
        image = "https://r2.fivemanage.com/CpHIJPGYR3vZJHAW0bRMV/images/imaddge.png",
        weaponRestriction = "pistol",
        allowedWeapons = {"WEAPON_PISTOL", "WEAPON_COMBATPISTOL"},
        respawnTime = 3,
        invincibilityTime = 3
    },
    military = {
        name = "Base Militaire",
        center = vector3(2402.116, 3108.057, 48.15588),
        radius = 150.0,
        spawns = {
            vector3(2402.116, 3108.057, 48.15588),
            vector3(2402.116, 3148.057, 48.15588)
        },
        image = "https://r2.fivemanage.com/CpHIJPGYR3vZJHAW0bRMV/images/imadddge.png",
        weaponRestriction = "all",
        allowedWeapons = {},
        instance = 3,
        respawnTime = 5,
        invincibilityTime = 3,
        exitCoords = vector3(215.76, -810.12, 30.73),
        blipSettings = {
            sprite = 110,
            color = 1,
            scale = 1.0,
            shortRange = true
        }
    },
    port = {
        name = "Ferme",
        center = vector3(2449.91, 4974.62, 46.83),
        radius = 150.0,
        spawns = {
            vector3(2508.76, 4974.53, 44.54),
            vector3(2437.54, 4932.77, 44.96)
        },
        image = "https://r2.fivemanage.com/JUl5BqHNYe3dpZlF4eJZv/images/image(2).png",
        weaponRestriction = "melee",
        allowedWeapons = {"WEAPON_KNIFE", "WEAPON_BAT", "WEAPON_CROWBAR"},
        respawnTime = 4,
        invincibilityTime = 2,
        exitCoords = vector3(215.76, -810.12, 30.73),
        blipSettings = {
            sprite = 110,
            color = 1,
            scale = 1.0,
            shortRange = true
        }
    }
}



Config.Settings = {
    defaultRespawnTime = 5,
    defaultInvincibilityTime = 3,
    killFeedDuration = 5000,
    leaderboardUpdateInterval = 5000,
    zoneCheckInterval = 1000,
    scoreMultiplier = 1,
    minPlayersForPoints = 2,
    leaveZoneTime = 5, -- Temps en secondes avant d'être expulsé de la zone
    hitmarker = {
        enabled = true,
        sound = true,
        displayTime = 1000,
        fadeSpeed = 2,
        headshot = {
            sound = "TENNIS_MATCH_POINT",
            soundSet = "HUD_AWARDS",
            scale = 0.85,
            color = {255, 0, 0}
        },
        normal = {
            sound = "TENNIS_POINT_WON",
            soundSet = "HUD_AWARDS",
            scale = 0.65,
            color = {255, 255, 255}
        }
    }
}

Config.Messages = {
    enterZone = "Vous êtes entré dans une zone gunfight",
    exitZone = "Vous avez quitté la zone gunfight",
    alreadyInZone = "Vous êtes déjà dans une zone gunfight",
    notEnoughPlayers = "Pas assez de joueurs pour gagner des points !",
    deathMessage = "Mort en combat",
    respawnMessage = "Vous avez été réanimé[e] 💉",
    moneyReward = "Vous venez de tuer un joueur en zone de non droit, vous recevez ~r~%s$~s~ ",
    leaveZoneWarning = "⚠️ Retournez dans la zone ! %d secondes restantes"
}

Config.Rewards = {
    kill = 100,
    headshot = 50,
    Reward = 4000,
    streak = {
        [3] = 1,
        [5] = 2,
        [10] = 5
    }
}

return Config