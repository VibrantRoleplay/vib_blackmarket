RegisterNetEvent('blackmarket:Menu', function(v)
	local headerMenu = {}

    local tableData = v

    for item, price in pairs(v.args.ItemsForSale) do

        headerMenu[#headerMenu + 1] = {
            title = "Purchase "..exports.ox_inventory:Items(item).label,
            image = "nui://ox_inventory/web/images/"..item..".png",
            description = "My price today for this is $"..price,
            icon = 'fa-solid fa-dollar',
            event = "blackmarket:BuyInput",
            args = {
                item = item,
                price = price
            },
        }
    end

    lib.registerContext({
        id = 'sales_menu',
        title = tableData.label,
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