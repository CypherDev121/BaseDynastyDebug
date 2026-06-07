local DrawDistance = 5.0

InGangMenu = false
local AlreadyMarker = false
local AlreadyStartGang = false

Gangs = {
    ['ballas'] = {
        type = 'gang',
        color = {118, 75, 127},
        ['zones'] = {
            ['cars'] = { coords = vector3(87.4, -1969.3, 19.8) },
            ['boss'] = { coords = vector3(85.5, -1959.2, 20.1) },
            --['datastore'] = { coords = vector3(106.9, -1975.1, 19.9) }
        }
    },
    ['families'] = {
        type = 'gang',
        color = {108, 168, 93},
        ['zones'] = {
            ['cars'] = { coords = vector3(-159.4, -1582.2, 33.7) },
            ['boss'] = { coords = vector3(-137.1, -1609.9, 34.0) },
            --['datastore'] = { coords = vector3(-141.0, -1606.1, 34.0) }
        }
    },
    ['vagos'] = {
        type = 'gang',
        color = {235, 227, 56},
        ['zones'] = {
            ['cars'] = { coords = vector3(323.6, -2027.4, 19.8) },
            ['boss'] = { coords = vector3(364.8, -2064.8, 20.7) },
            --['datastore'] = { coords = vector3(352.1, -2035.4, 21.3) }
        }
    },
    ['loszetas'] = {
        type = 'cartel',
        color = {30, 30, 30},
        ['zones'] = {
            ['cars'] = { coords = vector3(1363.44, 1139.77, 112.76) },
            ['boss'] = { coords = vector3(1392.8, 1159.5, 113.33) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['blackmafia'] = {
        type = 'mafia',
        color = {30, 30, 30},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1549.18, 884.3, 180.3) },
            ['boss'] = { coords = vector3(-1546.31, 865.09, 181.43) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['whites'] = {
        type = 'mafia',
        color = {255, 255, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(-125.78, 1002.92, 234.73) },
            ['boss'] = { coords = vector3(-113.99, 985.76, 234.73) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['crips'] = {
        type = 'gang',
        color = {100, 100, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1124.8, -1608.11, 3.4) },
            ['boss'] = { coords = vector3(-1082.8, -1630.7, 3.7) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['bloods'] = {
        type = 'gang',
        color = {204, 47, 47},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1562.74, -388.71, 40.98) },
            ['boss'] = { coords = vector3(-1575.3, -410.2, 47.2) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['marabunta'] = {
        type = 'gang',
        color = {75, 106, 156},
        ['zones'] = {
            ['cars'] = { coords = vector3(1445.8, -1486.6, 62.6) },
            ['boss'] = { coords = vector3(1422.09, -1505.24, 59.92) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
    ['moneywasher'] = {
        type = 'cartel',
        color = {255, 255, 255},
        ['zones'] = {
            ['cars'] = { coords = vector3(-1791.88, 458.02, 127.31) },
            ['boss'] = { coords = vector3(-1804.95, 436.91, 127.71) },
            --['datastore'] = { coords = vector3(1402.69, 1153.82, 113.33) }
        }
    },
}

GangsBlips = {
    ["ballas"] = {coords = vector3(83.0, -1924.4, 19.8), name = "Ballas Gang", color = 7, color2 = 7, sprite = 378, radius = 100.0},
    ["families"] = {coords = vector3(-139.3, -1563.896, 34.3), name = "Families Gang", color = 2, color2 = 2, sprite = 378, radius = 100.0},
    ["vagos"] = {coords = vector3(310.5, -2020.1, 20.3), name = "Vagos Gang", color = 5, color2 = 5, sprite = 378, radius = 100.0},
    ["loszetas"] = {coords = vector3(1370.2, 1146.8, 112.7), name = "Cartel Los Zetas", color = 40, color2 = 40, sprite = 378, radius = 100.0},
    ["blackmafia"] = {coords = vector3(-1533.6, 876.0, 181.6), name = "Mafia Black Mafia", color = 40, color2 = 40, sprite = 378, radius = 100.0},
    ["whites"] = {coords = vector3(-113.99, 985.76, 300.0), name = "Mafia Whites", color = 4, color2 = 4, sprite = 378, radius = 100.0},
    ["crips"] = {coords = vector3(-1105.6, -1624.7, 4.4), name = "Crips Gang", color = 38, color2 = 38, sprite = 378, radius = 100.0},
    ["bloods"] = {coords = vector3(-1550.63, -405.27, 41.99), name = "Bloods Gang", color = 1, color2 = 1, sprite = 378, radius = 100.0},
    ["marabunta"] = {coords = vector3(1426.47, -1513.62, 60.55), name = "Marabunta Gang", color = 63, color2 = 63, sprite = 378, radius = 100.0},
    ["moneywasher"] = {coords = vector3(-1791.88, 458.02, 127.31), name = "Blanchisseur", color = 4, color2 = 4, sprite = 378, radius = 100.0},
}

GangVehicles = {
    ['gang'] = {
        {label = "Primo Custom",model = 'primo2'},
        {label = "Chino",model = 'chino'},
        {label = "Buffalo",model = 'buffalo'},
        {label = "Sanchez",model = 'sanchez2'}
    },
    ['mafia'] = {
        {label = "Baller",model = 'baller2'},
        {label = "Cognoscenti 55",model = 'cog55'},
        {label = "Washington",model = 'washington'},
        {label = "Manchez Scout",model = 'manchez2'}
    },
    ['cartel'] = {
        {label = "Baller",model = 'baller2'},
        {label = "Schafter V12",model = 'schafter4'},
        {label = "Granger",model = 'granger'},
        {label = "Manchez Scout",model = 'manchez2'}
    }
}

local HelpMessages = {
    ['cars'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu véhicules",
    ['boss'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu patron",
    ['datastore'] = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre"
}

Citizen.CreateThread(function()
	for k,zone in pairs(GangsBlips) do
        local blip = AddBlipForRadius(zone.coords, zone.radius)
        SetBlipHighDetail(blip, true)
          SetBlipColour(blip, zone.color2)
          SetBlipAlpha (blip, 128)
          blip = AddBlipForCoord(zone.coords)
          SetBlipHighDetail(blip, true)
          SetBlipSprite (blip, zone.sprite)
          SetBlipScale  (blip, 1.0)
          SetBlipColour (blip, zone.color)
          SetBlipAsShortRange(blip, true)
      
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(zone.name)
          EndTextCommandSetBlipName(blip)
  end
end)

function StartGangSystem()
    if AlreadyStartGang then
        return
    end
    AlreadyStartGang = true
    Citizen.CreateThread(function()
        while Gangs[ESX.PlayerData.job2.name] do
            Citizen.Wait(5)
            local sleep = true
            local inMarker = false
            local a = ESX.PlayerData.job2.name
            local b = Gangs[ESX.PlayerData.job2.name]
                for i, j in pairs(b["zones"]) do
                    if not Gangs[ESX.PlayerData.job2.name] then return end
                    local distance = GetDistanceBetweenCoords(ESX.PlayerData.cache.coords, j.coords.x, j.coords.y, j.coords.z, true)
                    if (distance < DrawDistance) then
                        sleep = false
                        local gangcolor = Gangs[ESX.PlayerData.job2.name].color
                        DrawMarker(1, j.coords.x, j.coords.y, j.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, gangcolor[1], gangcolor[2], gangcolor[3], 200, false, true, 2, false, false, false, false)
                    end
                    if (distance < 2.0) then
                        inMarker = true
                        AlreadyMarker = true
                        if not InGangMenu then
                            ESX.ShowHelpNotification(HelpMessages[i])
                            if IsControlJustReleased(0, 38) then
                                ManageGangAction(i)
                            end
                        end
                    end
                end
            if AlreadyMarker and not inMarker then
                InGangMenu = false
                AlreadyMarker = false
                CloseMenu()
            end
            if sleep then
                Citizen.Wait(2000)
            end
        end
        AlreadyStartGang = false
    end)
end

