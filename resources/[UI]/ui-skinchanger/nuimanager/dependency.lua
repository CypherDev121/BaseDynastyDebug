ESX = exports['Core_CypherDev']:getSharedObject()


variationsHandler = {
    ['heritage'] = {
        variationsCount = 0,
        variationsList = {},
    },
    ['beard'] = {
        variationsCount = 1,
        variationsList = {
            size = {
                type = "range",
                suffix = "_2",
                label = "Taille"
            },
            primary = {
                type = "range",
                suffix = "_3",
                label = "Couleur primaire"
            }
        },
    },
    ['hair'] = {
        variationsCount = 2,
        variationsList = {
            primary = {
                type = "range",
                suffix = "_color_1",
                label = "Couleur primaire"
            },
            secondary = {
                type = "range",
                suffix = "_color_2",
                label = "Couleur secondaire"
            }
        },
    },
    ['makeup'] = {
        variationsCount = 3,
        variationsList = {
            size = {
                type = "range",
                suffix = "_2",
                label = "Taille"
            },
            primary = {
                type = "range",
                suffix = "_3",
                label = "Couleur primaire"
            },
            secondary = {
                type = "range",
                suffix = "_4",
                label = "Couleur secondaire"
            }
        },
    },
    ['lipstick'] = {
        variationsCount = 3,
        variationsList = {
            size = {
                type = "range",
                suffix = "_2",
                label = "Taille"
            },
            primary = {
                type = "range",
                suffix = "_3",
                label = "Couleur primaire"
            }
        },
    }
}

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "Core_CypherDev" then
        ESX = exports['Core_CypherDev']:getSharedObject()
    end
end)