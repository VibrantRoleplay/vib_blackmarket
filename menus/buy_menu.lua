RegisterNetEvent('blackmarket:BuyMenu', function(v)
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)

    for _, itemData in pairs(v.args.ItemsForSale) do

        if moneyAmount > itemData.price then
            buyItemDescription = "Our "..exports.ox_inventory:Items(itemData.item).label.." cost $"..itemData.price.. " today"
        else
            buyItemDescription = "You don't have enough money to buy any "..exports.ox_inventory:Items(itemData.item).label
        end

        headerMenu[#headerMenu + 1] = {
            title = "Purchase "..exports.ox_inventory:Items(itemData.item).label,
            description = buyItemDescription,
            icon = "nui://ox_inventory/web/images/"..itemData.item..".png",
            event = "blackmarket:BuyInput",
            readOnly = itemData.price > moneyAmount,
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
            icon = "fa-solid fa-dollar",
            iconColor = "green",
        },
    })
    if not input or #input < 1 then
        return
    end

    TriggerServerEvent("blackmarket:server:BuyStock", input[1], args)
end)