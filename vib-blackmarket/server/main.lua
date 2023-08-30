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