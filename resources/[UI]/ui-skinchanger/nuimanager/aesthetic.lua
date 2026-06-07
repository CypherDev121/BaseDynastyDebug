local aesthetic = {
    beard = {},
    eyebrows = {},
    hair = {
        ['male'] = {},
        ['female'] = {}
    },
    lipstick = {},
    makeup = {},
}

for i = 0, GetNumHeadOverlayValues(1) do
    local label = GetLabelText('CC_BEARD_' .. i)
    if label == "NULL" then
        label = "Barbe #" .. i
    end
    table.insert(aesthetic.beard, label)
end

for i = 0, GetNumHeadOverlayValues(2) do
    local label = GetLabelText('CC_EYEBRW_' .. i)
    if label == "NULL" then
        label = "Sourcil #" .. i
    end
    table.insert(aesthetic.eyebrows, label)
end

for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 2) do
    local label = GetLabelText('CC_M_HS_' .. i)
    if label == "NULL" then
        label = "Coiffure #" .. i
    end
    table.insert(aesthetic.hair['male'], label)
end

for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 3) do
    local label = GetLabelText('CC_F_HS_' .. i)
    if label == "NULL" then
        label = "Coiffure #" .. i
    end
    table.insert(aesthetic.hair['female'], label)
end

for i = 0, GetPedHeadOverlayNum(8) do
    local label = GetLabelText('CC_LIPSTICK_' .. i)
    if label == "NULL" then
        label = "Rouge à lèvres #" .. i
    end
    table.insert(aesthetic.lipstick, label)
end

for i = 0, GetNumHeadOverlayValues(4) do
    local label = GetLabelText('CC_MKUP_' .. i)
    if label == "NULL" then
        label = "Maquillage #" .. i
    end
    table.insert(aesthetic.makeup, label)
end

function generateItems(key)
    local items, sexe = {}, GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') and 'female' or 'male'
    if key == 'hair' then
        for i = 1, #aesthetic[key][sexe] do
            table.insert(items, {
                label = aesthetic[key][sexe][i],
                price = 0,
                id = i - 1,
            })
        end
    elseif key == 'heritage' then
        return {}
    else
        for i = 1, #aesthetic[key] do
            table.insert(items, {
                label = aesthetic[key][i],
                price = 0,
                id = i - 1,
            })
        end
    end
    return items
end