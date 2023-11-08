RegisterNetEvent('blackmarket:SellingMenu', function(data)
	local headerMenu = {}
    
    local standardItems = data.args.StandardItems
    local rareItems = data.args.RareItems
    local canSellRare = lib.callback.await("blackmarket:server:CheckRareItem", false)

    if canSellRare then
        for _, itemData in pairs(rareItems) do
            local hasItem = exports.ox_inventory:Search("count", itemData.item) > 0
    
            headerMenu[#headerMenu + 1] = {
                title = "Sell "..exports.ox_inventory:Items(itemData.item).label,
                image = "nui://ox_inventory/web/images/"..itemData.item..".png",
                description = "I'll buy all your "..exports.ox_inventory:Items(itemData.item).label.." for $"..itemData.price.." each",
                icon = 'fa-solid fa-dollar',
                serverEvent = "blackmarket:server:SellItems",
                disabled = not hasItem,
                args = {
                    item = itemData.item,
                    price = itemData.price,
                },
            }
        end
    end
    for _, itemData in pairs(standardItems) do
        local hasItem = exports.ox_inventory:Search("count", itemData.item) > 0

        headerMenu[#headerMenu + 1] = {
            title = "Sell "..exports.ox_inventory:Items(itemData.item).label,
            image = "nui://ox_inventory/web/images/"..itemData.item..".png",
            description = "I'll buy all your "..exports.ox_inventory:Items(itemData.item).label.." for $"..itemData.price.." each",
            icon = 'fa-solid fa-dollar',
            serverEvent = "blackmarket:server:SellItems",
            disabled = not hasItem,
            args = {
                item = itemData.item,
                price = itemData.price,
            },
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = data.label,
        options = headerMenu
    })

    lib.showContext('sales_menu')
end)