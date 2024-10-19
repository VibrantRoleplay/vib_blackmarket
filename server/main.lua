QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

----------
--Events--
----------

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:GetPlayerJob', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local playerJob = player.PlayerData.job.name

    return playerJob
end)

lib.callback.register('blackmarket:server:GetRandomEntranceLocation', function()
    local randomEntranceKey = math.random(1, #Config.BlackMarketAccess.EntranceInfo.EntranceLocations)
    local chosenEntranceLocation = Config.BlackMarketAccess.EntranceInfo.EntranceLocations[randomEntranceKey]
    
    return chosenEntranceLocation
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