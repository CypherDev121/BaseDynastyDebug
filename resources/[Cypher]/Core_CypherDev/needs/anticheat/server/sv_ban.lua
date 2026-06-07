AnticheatBanList = {}
AddEventHandler('playerConnecting', function(playerName,setKickReason,c)
    local identifier,discord,playerip  = "nn/aa","nn/aa","nn/aa","nn/aa"
    local found = false

    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            identifier = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end
    end

    if #AnticheatBanList < 1 then
        Citizen.Wait(1000)
    end

    for k, v in pairs(AnticheatBanList) do
        if 
            tostring(v.identifier) == tostring(identifier)
            or tostring(v.discord) == tostring(discord)
        then
            found = true
            break            
        end
    end
    if found then
        setKickReason(ACConfig.Name .. ": Vous avez été ban pour cheat")
        CancelEvent()
    else
        c.defer()
        c.presentCard({
            ["type"] = "AdaptiveCard",
            ["minHeight"] = "100px",
            ["body"] = {
              {
                type = "Container",
                items = {
                  {
                    type = "Image",
                    url = "https://media.discordapp.net/attachments/869710911529680937/965297429203267594/NyseraRP.png?width=414&height=468",
                    size = "medium",
                    horizontalAlignment = "center",
                    style = "person"
                  },
                  {
                    type = "TextBlock",
                    horizontalAlignment = "center",
                    text = "Bienvenue"
                  }
                }
              }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.2"
        })
        SetTimeout(2500, function()
            c.done()
        end)
    end
end)

function RequestPlayerBan(source)
    local identifier,discord,playerip  = "n/a","n/a","n/a"

    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            identifier = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end
    end
    AnticheatBan(identifier, discord, GetPlayerName(source))
    DropPlayer(source, "Vous vous êtes fais ban par " .. ACConfig.Name)
end

RegisterCommand("refreshbanlist", function(source) 
    if source == 0 then
    loadAnticheatBanList()
    end
end)

function AnticheatBan(identifier, discord,  playernme)
    local timeat     = os.time()
    local added      = os.date()

    table.insert(AnticheatBanList, {
        identifier = identifier,
        discord    = discord
    })
    MySQL.Async.execute('INSERT INTO anticheat_bans (identifier,discord,playername,timeat) VALUES (@identifier,@discord,@playername,@timeat)', {
        ['@identifier']       = identifier,
        ['@discord']          = discord,
        ['@playername']       = playername,
        ['@timeat']           = timeat
    }, function()
    end)
end

function loadAnticheatBanList()
    MySQL.Async.fetchAll('SELECT * FROM anticheat_bans', {}, function (data)
         AnticheatBanList = {}

        for i=1, #data, 1 do
            table.insert(AnticheatBanList, {
                identifier = data[i].identifier,
                discord    = data[i].discord,
                playerip   = data[i].playerip
            })
        end
        print('^3Loaded Anticheat Banlist^0')
    end)
end
