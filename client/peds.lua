CreateThread(function()
    if Config.UseMoneyLaundering then
        for _, shop in pairs(Config.Laundering) do
            lib.requestModel(shop.PedModel)
    
            local ShopKeeper = CreatePed(1, shop.PedModel, shop.PedSpawn, false, true)
            SetEntityInvincible(ShopKeeper, true)
            SetBlockingOfNonTemporaryEvents(ShopKeeper, true)
            FreezeEntityPosition(ShopKeeper, true)
    
            exports.ox_target:addSphereZone({
                coords = vec3(shop.PedSpawn.x, shop.PedSpawn.y, shop.PedSpawn.z+1),
                radius = 1,
                debug = Config.Debug,
                options = {
                    {
                        event = 'blackmarket:LaunderMenu',
                        label = "Speak to "..shop.ShopName.." owner",
                        args = shop,
                        icon = "fa-solid fa-basket-shopping",
                        iconColor = "white",
                        distance = 2,
                        debug = Config.Debug, 
                    },
                },
            })
            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
        end
    end

    for k, v in pairs(Config.MarketPeds) do
        lib.requestModel(v.Model)
        local MarketPeds = CreatePed(1, v.Model, v.Location, false, true)
        SetEntityInvincible(MarketPeds, true)
        SetBlockingOfNonTemporaryEvents(MarketPeds, true)
        FreezeEntityPosition(MarketPeds, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.AnimationDict)
            TaskPlayAnim(MarketPeds, v.AnimationDict, v.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
        end
        
        local coords = v.Location

        exports.ox_target:addSphereZone({
            coords = vec3(coords.x, coords.y, coords.z+1),
            radius = 1,
            debug = Config.Debug,
            options = {
                {
                    event = 'blackmarket:Menu',
                    label = "Trade "..v.Name,
                    args = v,
                    icon = "fa-solid fa-box-archive",
                    iconColor = "yellow",
                    distance = 2, 
                    debug = Config.Debug,
                },
            },
        })
    end
end)

CreateThread(function()
    local Entrance = Config.BlackMarketAccess.EntranceInfo
    local randomLocation = math.random(1, #Entrance.EntrancePedLocations)
    local dropoffLocation = Entrance.EntrancePedLocations[randomLocation]

    lib.requestModel(Entrance.EntrancePedModel)
    local entrancePed = CreatePed(1, Entrance.EntrancePedModel, dropoffLocation, false, true)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    
    if Config.UseAnims then
        lib.requestAnimDict(Entrance.EntrancePedAnimationDict)
        TaskPlayAnim(entrancePed, Entrance.EntrancePedAnimationDict, Entrance.EntrancePedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(dropoffLocation.x, dropoffLocation.y, dropoffLocation.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:EntranceMenu',
                label = "Speak to "..Entrance.EntrancePedName,
                args = Entrance.EntrancePedName,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)

CreateThread(function()
    local Exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = Exit.ExitPedLocation

    lib.requestModel(Exit.ExitPedModel)
    local exitPed = CreatePed(1, Exit.ExitPedModel, Exit.ExitPedLocation, false, true)
    SetEntityInvincible(exitPed, true)
    SetBlockingOfNonTemporaryEvents(exitPed, true)
    FreezeEntityPosition(exitPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(Exit.ExitPedAnimationDict)
        TaskPlayAnim(exitPed, Exit.ExitPedAnimationDict, Exit.ExitPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:ExitMenu',
                label = "Speak to "..Exit.ExitPedName,
                args = Exit.ExitPedName,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)

CreateThread(function()
    local pedCoords = Repair.RepairsPedLocation
    local Repair = Config.BlackMarketAccess.RepairsInfo

    lib.requestModel(Repair.RepairsPedModel)
    local repairPed = CreatePed(1, Repair.RepairsPedModel, Repair.RepairsPedLocation, false, true)
    SetEntityInvincible(repairPed, true)
    SetBlockingOfNonTemporaryEvents(repairPed, true)
    FreezeEntityPosition(repairPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(Repair.RepairsPedAnimationDict)
        TaskPlayAnim(repairPed, Repair.RepairsPedAnimationDict, Repair.RepairsPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:RepairMenu',
                label = "Speak to "..Repair.RepairsPedName,
                args = Repair,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)

CreateThread(function()
    local Sales = Config.ItemSelling.SalesPed
    local pedCoords = Config.ItemSelling.SalesPed.SalesPedLocation
    local SellingData = Config.ItemSelling.ItemInfo

    lib.requestModel(Sales.SalesPedModel)
    local salesPed = CreatePed(1, Sales.SalesPedModel, Sales.SalesPedLocation, false, true)
    SetEntityInvincible(salesPed, true)
    SetBlockingOfNonTemporaryEvents(salesPed, true)
    FreezeEntityPosition(salesPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(Sales.SalesPedAnimationDict)
        TaskPlayAnim(salesPed, Sales.SalesPedAnimationDict, Sales.SalesPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:SellingMenu',
                label = "Speak to "..Sales.SalesPedName,
                args = SellingData,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)