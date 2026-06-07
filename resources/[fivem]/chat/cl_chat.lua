local isRDR = not TerraingridActivate and true or false

local chatInputActive = false
local chatInputActivating = false
local chatLoaded = false
local group = "user"

AddEventHandler("setGroupStaff", function(groupe)
group = groupe
end)

RegisterNetEvent("chatMessage")
RegisterNetEvent("chat:addMessage")
RegisterNetEvent("chat:clear")

-- internal events
RegisterNetEvent("__cfx_internal:serverPrint")
RegisterNetEvent("_chat:messageEntered")

--deprecated, use chat:addMessage
AddEventHandler("chatMessage", function(author, color, text)
  --[[local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = "ON_MESSAGE",
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })]]
end)

-- addMessage
local addMessage = function(message)
  if type(message) == "string" then
    message = {
      args = { message }
    }
  end

  SendNUIMessage({
    type = "ON_MESSAGE",
    message = message
  })
end

exports("addMessage", addMessage)
--AddEventHandler("chat:addMessage", addMessage)

AddEventHandler("chat:clear", function(name)
  SendNUIMessage({
    type = "ON_CLEAR"
  })
end)

RegisterNUICallback("chatResult", function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == "/" then
      ExecuteCommand(data.message:sub(2))
    end
  end

  cb("ok")
end)

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == "started" then
      local numThemes = GetNumResourceMetadata(resource, "chat_theme")

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, "chat_theme")
        local themeData = json.decode(GetResourceMetadata(resource, "chat_theme_extra") or "null")

        if themeName and themeData then
          themeData.baseUrl = "nui://" .. resource .. "/"
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = "ON_UPDATE_THEMES",
    themes = themes
  })
end

AddEventHandler("onClientResourceStart", function(resName)
  Wait(500)
  refreshThemes()
end)

AddEventHandler("onClientResourceStop", function(resName)
  Wait(500)
  refreshThemes()
end)

RegisterNUICallback("loaded", function(data, cb)
  refreshThemes()
  chatLoaded = true
  cb("ok")
end)

local CHAT_HIDE_STATES = {
  SHOW_WHEN_ACTIVE = 0,
  ALWAYS_SHOW = 1,
  ALWAYS_HIDE = 2
}

local chatHideState = CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
local isFirstHide = true

Citizen.CreateThread(function()
Citizen.Wait(10000)
if not isRDR then
 if group == "mod" or group == "superadmin" then
  if RegisterKeyMapping then
    RegisterKeyMapping("toggleChat", "Statut du chat", "keyboard", "numpad3")
  end
 end
end
end)

RegisterCommand("toggleChat", function()
  if UpdateOnscreenKeyboard() == 0 then return end
  if chatHideState == CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE then
    chatHideState = CHAT_HIDE_STATES.ALWAYS_SHOW
  elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_SHOW then
    chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
  elseif chatHideState == CHAT_HIDE_STATES.ALWAYS_HIDE then
    chatHideState = CHAT_HIDE_STATES.SHOW_WHEN_ACTIVE
  end
  isFirstHide = false
end, false)

local lastChatHideState = -1
local origChatHideState = -1

RegisterCommand("+chat", function()
  if not chatInputActive then
      chatInputActive = true
      chatInputActivating = true

      SendNUIMessage({
        type = "ON_OPEN"
      })
  end
end)

RegisterKeyMapping("+chat", "Open/close chat", "keyboard", "t")

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  while true do
    Wait(5)

    if chatInputActivating then
        SetNuiFocus(true)

        chatInputActivating = false
    end

    if chatLoaded then
      local forceHide = IsScreenFadedOut() or IsPauseMenuActive()

      if forceHide then
        origChatHideState = chatHideState
        chatHideState = CHAT_HIDE_STATES.ALWAYS_HIDE
      elseif origChatHideState ~= -1 then
        chatHideState = origChatHideState
        origChatHideState = -1
      end

      if chatHideState ~= lastChatHideState then
        lastChatHideState = chatHideState

        SendNUIMessage({
          type = "ON_SCREEN_STATE_CHANGE",
          hideState = chatHideState,
          fromUserInteraction = not forceHide and not isFirstHide
        })

        isFirstHide = false
      end
    end
  end
end)

RegisterCommand("clear", function()
  SendNUIMessage({
    type = "ON_CLEAR"
  })
end)