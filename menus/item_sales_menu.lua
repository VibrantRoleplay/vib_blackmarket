RegisterNetEvent('blackmarket:SellingMenu', function(args)
	local headerMenu = {}
    local standardItems = args.args.StandardItems
    local rareItems = args.args.RareItems
    local canSellRare = lib.callback.await("blackmarket:server:CheckRareItem", false)

    if canSellRare then
        for k, v in pairs(rareItems) do
            local hasItem = exports.ox_inventory:Search("count", k) > 0
    
            headerMenu[#headerMenu + 1] = {
                title = "Sell "..exports.ox_inventory:Items(k).label,
                image = "nui://ox_inventory/web/images/"..k..".png",
                description = "I'll buy all your "..exports.ox_inventory:Items(k).label.." for $"..v.." each",
                icon = 'fa-solid fa-dollar',
                serverEvent = "blackmarket:server:SellItems",
                disabled = not hasItem,
                args = {
                    item = k,
                    price = v,
                },
            }
        end
    end
    for k, v in pairs(standardItems) do
        local hasItem = exports.ox_inventory:Search("count", k) > 0

        headerMenu[#headerMenu + 1] = {
            title = "Sell "..exports.ox_inventory:Items(k).label,
            image = "nui://ox_inventory/web/images/"..k..".png",
            description = "I'll buy all your "..exports.ox_inventory:Items(k).label.." for $"..v.." each",
            icon = 'fa-solid fa-dollar',
            serverEvent = "blackmarket:server:SellItems",
            disabled = not hasItem,
            args = {
                item = k,
                price = v,
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