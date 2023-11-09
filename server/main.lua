QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

----------
--Events--
----------

RegisterNetEvent("blackmarket:server:BuyStock", function(input, args)
    local amount = input
    local cost = (args.price * amount)

    if exports.ox_inventory:RemoveItem(source, "black_money", cost) then
        if exports.ox_inventory:CanCarryItem(source, args.item, amount) then
            exports.ox_inventory:AddItem(source, args.item, amount)
        else
            lib.notify(source, {
                title = "Attention",
                description = "Inventory is full!",
                type = 'inform'
            })
        end
    else
        lib.notify(source, {
            title = "Attention",
            description = "You don't have enough dirty money",
            type = 'error'
        })
    end
end)

RegisterNetEvent("blackmarket:server:SellItems", function(args)
    local itemCount = exports.ox_inventory:Search(source, 'count', args.item)
    local payOut = itemCount * args.price

    if exports.ox_inventory:RemoveItem(source, args.item, itemCount) then
        if exports.ox_inventory:CanCarryItem(source, "black_money", payOut) then
            exports.ox_inventory:AddItem(source, "black_money", payOut)
            lib.notify(source, {
                title = "Attention",
                description = "You've made $"..payOut,
                type = 'success'
            })
        else
            lib.notify(source, {
                title = "Attention",
                description = "Inventory is full!",
                type = 'inform'
            })
        end
    end
end)

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:GenerateNumberCode', function(source)
    local correctCode = Config.EntranceTypes.NumberCode
    
    return correctCode
end)

lib.callback.register('blackmarket:server:CheckRareItem', function(source)
    local canSellRare = Config.ItemSelling.ItemInfo.RareItemSalesChance < math.random(1, 100)

    return canSellRare
end)

lib.callback.register('blackmarket:server:GetPlayerJob', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local playerJob = player.PlayerData.job.name

    return playerJob
end)