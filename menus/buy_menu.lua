RegisterNetEvent('blackmarket:BuyMenu', function(v)
    PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)

    for _, itemData in pairs(v.args.ItemsForSale) do
        if moneyAmount > itemData.Price then
            buyItemDescription = "Our "..exports.ox_inventory:Items(itemData.Item).label.." cost $"..itemData.Price.. " today"
        else
            buyItemDescription = "You don't have enough money to buy any "..exports.ox_inventory:Items(itemData.Item).label
        end

        headerMenu[#headerMenu + 1] = {
            title = "Purchase "..exports.ox_inventory:Items(itemData.Item).label,
            description = buyItemDescription..'\n\nWe only have '..itemData.AvailableStock..' left in stock',
            event = "blackmarket:BuyInput",
            args = {
                item = itemData.Item,
                price = itemData.Price,
                stock = itemData.AvailableStock
            },
            icon = "nui://ox_inventory/web/images/"..itemData.Item..".png",
            readOnly = itemData.Price > moneyAmount,
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
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)

	local input = lib.inputDialog('Item Sales', {
        {
            type = "slider",
            label = "How many do you want?",
            options = options,
            required = true,
            icon = "nui://ox_inventory/web/images/"..args.item..".png",
            min = 1,
            max = math.floor((moneyAmount / args.price)),
        },
    })
    if input == nil then
        return
    end

    TriggerServerEvent("blackmarket:server:BuyStock", input[1], args)
end)