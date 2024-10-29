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

lib.callback.register('blackmarket:server:GetAccessCode', function(source)
    local correctCode = Config.Hacking.RandomNumberCode
    
    return correctCode
end)