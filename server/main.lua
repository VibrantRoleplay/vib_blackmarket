QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

local randomEntranceKey = math.random(1, #Config.BlackMarketAccess.EntranceInfo.EntrancePedLocations)
local randomEntranceLocation = Config.BlackMarketAccess.EntranceInfo.EntrancePedLocations[randomEntranceKey]

----------
--Events--
----------

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

lib.callback.register('blackmarket:server:GetRandomEntranceLocation', function()

    return randomEntranceLocation
end)

-----------
--Threads--
-----------

CreateThread(function()
    for k, v in pairs(Config.MarketPeds) do
        exports.ox_inventory:RegisterShop(v.Name, {
            name = v.Name,
            inventory = v.ItemsForSale,
        })
    end
end)
