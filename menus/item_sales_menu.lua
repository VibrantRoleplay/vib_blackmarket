RegisterNetEvent('blackmarket:SellingMenu', function(args)
	local headerMenu = {}
    local standardItems = args.args.StandardItems
    local rareItems = args.args.RareItems
    local canSellRare = lib.callback.await("blackmarket:server:CheckRareItem", false)

    if canSellRare then
        for item, price in pairs(rareItems) do
            local hasItem = exports.ox_inventory:Search("count", item) > 0
    
            headerMenu[#headerMenu + 1] = {
                title = "Sell "..exports.ox_inventory:Items(item).label,
                image = "nui://ox_inventory/web/images/"..item..".png",
                description = "I'll buy all your "..exports.ox_inventory:Items(item).label.." for $"..price.." each",
                icon = 'fa-solid fa-dollar',
                serverEvent = "blackmarket:server:SellItems",
                disabled = not hasItem,
                args = {
                    item = item,
                    price = price,
                },
            }
        end
    end
    for item, price in pairs(standardItems) do
        local hasItem = exports.ox_inventory:Search("count", item) > 0

        headerMenu[#headerMenu + 1] = {
            title = "Sell "..exports.ox_inventory:Items(item).label,
            image = "nui://ox_inventory/web/images/"..item..".png",
            description = "I'll buy all your "..exports.ox_inventory:Items(item).label.." for $"..price.." each",
            icon = 'fa-solid fa-dollar',
            serverEvent = "blackmarket:server:SellItems",
            disabled = not hasItem,
            args = {
                item = item,
                price = price,
            },
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = args.label,
        options = headerMenu
    })

    lib.showContext('sales_menu')
end)