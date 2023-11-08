RegisterNetEvent('blackmarket:Menu', function(v)
	local headerMenu = {}

    for _, itemData in pairs(v.args.ItemsForSale) do

        headerMenu[#headerMenu + 1] = {
            title = "Purchase "..exports.ox_inventory:Items(itemData.item).label,
            image = "nui://ox_inventory/web/images/"..itemData.item..".png",
            description = "My price today for this is $"..itemData.price,
            icon = 'fa-solid fa-dollar',
            event = "blackmarket:BuyInput",
            args = {
                item = itemData.item,
                price = itemData.price
            },
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = v.label,
        options = headerMenu
    })

    lib.showContext('sales_menu')
end)

RegisterNetEvent("blackmarket:BuyInput", function(args)
    local options = {}

	local input = lib.inputDialog('Item Sales', {
        {
            type = "number",
            label = "How many do you want?",
            options = options,
            description = "Stock for sale",
            required = true,
            icon = "fa-solid fa-bullet",
        },
    })
    if not input or #input < 1 then
        return
    end

    TriggerServerEvent("blackmarket:server:BuyStock", input[1], args)
end)