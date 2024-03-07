RegisterNetEvent('blackmarket:SellingMenu', function(data)
    PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}
    
    local standardItems = data.args.StandardItems
    local rareItems = data.args.RareItems
    local canSellRare = lib.callback.await("blackmarket:server:CheckRareItem", false)

    if canSellRare then
        for _, itemData in pairs(rareItems) do
            local hasItem = exports.ox_inventory:Search("count", itemData.item) > 0

            if hasItem then
                sellableItemDescription = "I'll buy all your "..exports.ox_inventory:Items(itemData.item).label.." for $"..itemData.price.." each"
            else
                sellableItemDescription = "If you had any "..exports.ox_inventory:Items(itemData.item).label.." I'd buy them for $"..itemData.price.." each"
            end

            headerMenu[#headerMenu + 1] = {
                title = "Sell "..exports.ox_inventory:Items(itemData.item).label,
                description = sellableItemDescription,
                serverEvent = "blackmarket:server:SellItems",
                args = {
                    item = itemData.item,
                    price = itemData.price,
                },
                image = "nui://ox_inventory/web/images/"..itemData.item..".png",
                icon = 'fa-solid fa-dollar',
                iconColor = "green",
                readOnly = not hasItem,
            }
        end
    end
    
    for _, itemData in pairs(standardItems) do
        local hasItem = exports.ox_inventory:Search("count", itemData.item) > 0

        if hasItem then
            sellableItemDescription = "I'll buy all your "..exports.ox_inventory:Items(itemData.item).label.." for $"..itemData.price.." each"
        else
            sellableItemDescription = "If you had any "..exports.ox_inventory:Items(itemData.item).label.." I'd buy them for $"..itemData.price.." each"
        end

        headerMenu[#headerMenu + 1] = {
            title = "Sell "..exports.ox_inventory:Items(itemData.item).label,
            description = sellableItemDescription,
            serverEvent = "blackmarket:server:SellItems",
            args = {
                item = itemData.item,
                price = itemData.price,
            },
            icon = "nui://ox_inventory/web/images/"..itemData.item..".png",
            readOnly = not hasItem,
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = data.label,
        options = headerMenu
    })

    lib.showContext('sales_menu')
end)