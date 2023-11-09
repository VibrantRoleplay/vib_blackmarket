CreateThread(function()
    for k, v in pairs(Config.MarketPeds) do
        lib.requestModel(v.Model)
        MarketPeds = CreatePed(1, v.Model, v.Location, false, true)
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
                    icon = "fa-solid fa-box-archive",
                    label = "Trade "..v.Name,
                    event = 'blackmarket:Menu',
                    args = v,
                    debug = Config.Debug,
                    distance = 2, 
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
    entrancePed = CreatePed(1, Entrance.EntrancePedModel, dropoffLocation, false, true)
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
                icon = "fa-solid fa-box-archive",
                label = "Speak to "..Entrance.EntrancePedName,
                event = 'blackmarket:EntranceMenu',
                args = Entrance.EntrancePedName,
                debug = Config.Debug,
                distance = 2, 
            },
        },
    })
end)

CreateThread(function()
    local Exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = Exit.ExitPedLocation

    lib.requestModel(Exit.ExitPedModel)
    exitPed = CreatePed(1, Exit.ExitPedModel, Exit.ExitPedLocation, false, true)
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
                icon = "fa-solid fa-box-archive",
                label = "Speak to "..Exit.ExitPedName,
                event = 'blackmarket:ExitMenu',
                args = Exit.ExitPedName,
                debug = Config.Debug,
                distance = 2, 
            },
        },
    })
end)

CreateThread(function()
    local Sales = Config.ItemSelling.SalesPed
    local pedCoords = Config.ItemSelling.SalesPed.SalesPedLocation
    local SellingData = Config.ItemSelling.ItemInfo

    lib.requestModel(Sales.SalesPedModel)
    salesPed = CreatePed(1, Sales.SalesPedModel, Sales.SalesPedLocation, false, true)
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
                icon = "fa-solid fa-box-archive",
                label = "Speak to "..Sales.SalesPedName,
                event = 'blackmarket:SellingMenu',
                args = SellingData,
                debug = Config.Debug,
                distance = 2, 
            },
        },
    })
end)

if Config.UseMoneyLaundering then
    CreateThread(function()
        for _, shop in pairs(Config.Laundering) do
            lib.requestModel(shop.PedModel)

            ShopKeeper = CreatePed(1, shop.PedModel, shop.PedSpawn, false, true)
            SetEntityInvincible(ShopKeeper, true)
            SetBlockingOfNonTemporaryEvents(ShopKeeper, true)
            FreezeEntityPosition(ShopKeeper, true)

            exports.ox_target:addSphereZone({
                coords = vec3(shop.PedSpawn.x, shop.PedSpawn.y, shop.PedSpawn.z+1),
                radius = 1,
                debug = Config.Debug,
                options = {
                    {
                        icon = "fa-solid fa-basket-shopping",
                        iconColor = "white",
                        label = "Speak to "..shop.ShopName.." owner",
                        event = 'blackmarket:LaunderMenu',
                        args = shop,
                        debug = Config.Debug,
                        distance = 2, 
                    },
                },
            })
            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
        end
    end)
end