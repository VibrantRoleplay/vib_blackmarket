QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

----------
--Events--
----------

RegisterNetEvent("blackmarket:server:BuyStock", function(input, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = input
    local cost = (args.price * amount)

    if exports.ox_inventory:CanCarryItem(source, args.item, amount) then
        if exports.ox_inventory:RemoveItem(source, "black_money", cost) then
            exports.ox_inventory:AddItem(source, args.item, amount)
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
    local Player = QBCore.Functions.GetPlayer(source)
    local itemCount = exports.ox_inventory:Search(source, 'count', args.item)
    local payOut = itemCount * args.price

    if Config.Debug then
        print(json.encode(args.price, {indent = true}))
    end

    if exports.ox_inventory:RemoveItem(source, args.item, itemCount) then
        exports.ox_inventory:AddItem(source, "black_money", payOut)
        lib.notify(source, {
            title = "Attention",
            description = "You've made $"..payOut,
            type = 'success'
        })
    else
        lib.notify(source, {
            title = "Attention",
            description = "You fucked it, uwu O_o",
            type = 'error'
        })
    end

end)

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:GenerateNumberCode', function(source)
    local correctCode = Config.EntranceTypes.NumberCode
    if Config.Debug then
        print("This is the current code: "..correctCode)
    end
    return correctCode
end)