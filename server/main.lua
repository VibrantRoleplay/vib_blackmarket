QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

----------
--Events--
----------

RegisterNetEvent('blackmarket:server:UpdateMarkets', function(index, data)
    for k, v in pairs(data.ItemsForSale) do
        Context.MarketInfo[v.Item] = {
            item = v.Item,
            price = v.Price,
            stock = v.AvailableStock,
        }
    end
end)

lib.callback.register('blackmarket:server:GetStockInfo', function(source, stock)
    return Context.MarketInfo[stock]
end)

RegisterNetEvent("blackmarket:server:BuyStock", function(input, args)
    local cost = (args.price * input)

    if exports.ox_inventory:CanCarryItem(source, args.item, input) then
        if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, cost) then
            exports.ox_inventory:AddItem(source, args.item, input)

            Context.MarketInfo[args.item].stock = (Context.MarketInfo[args.item].stock - input)

            print(json.encode(Context.MarketInfo[args.item], {indent = true}))

        else
            lib.notify(source, {
                title = "Attention",
                description = "You don't have enough dirty money",
                type = 'error'
            })
        end
    else
        lib.notify(source, {
            title = "Attention",
            description = "Inventory is full!",
            type = 'inform'
        })
    end
end)

RegisterNetEvent("blackmarket:server:SellItems", function(args)
    local itemCount = exports.ox_inventory:Search(source, 'count', args.item)
    local payOut = itemCount * args.price

    if exports.ox_inventory:CanCarryItem(source, Config.MoneyItem, payOut) then
        if exports.ox_inventory:RemoveItem(source, args.item, itemCount) then
            exports.ox_inventory:AddItem(source, Config.MoneyItem, payOut)
            lib.notify(source, {
                title = "Attention",
                description = "You've made $"..payOut,
                type = 'success'
            })
        end
    else
        lib.notify(source, {
            title = "Attention",
            description = "Inventory is full!",
            type = 'inform'
        })
    end
end)

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:GenerateNumberCode', function(source)
    local correctCode = Config.EntranceTypes.NumberCode
    
    return correctCode
end)

lib.callback.register('blackmarket:server:GetPlayerJob', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local playerJob = player.PlayerData.job.name

    return playerJob
end)