CreateThread(function()
    -----------------
    --Money Washing--
    -----------------
    
    if Config.UseMoneyWashing then
        for _, shop in pairs(Config.Washing) do
            lib.requestModel(shop.PedModel, 10000)
    
            local shopKeeper = CreatePed(1, shop.PedModel, shop.PedSpawn, false, true, false)
            SetEntityInvincible(shopKeeper, true)
            SetBlockingOfNonTemporaryEvents(shopKeeper, true)
            FreezeEntityPosition(shopKeeper, true)
    
            exports.ox_target:addSphereZone({
                coords = vec3(shop.PedSpawn.x, shop.PedSpawn.y, shop.PedSpawn.z+1),
                radius = 1,
                debug = Config.Debug,
                options = {
                    {
                        label = "Speak to "..shop.ShopName.." owner",
                        event = 'blackmarket:WashMenu',
                        args = shop,
                        icon = "fa-solid fa-basket-shopping",
                        iconColor = "white",
                        distance = 2,
                    },
                },
            })
            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
        end
    end

    ---------------
    --Market Peds--
    ---------------

    for _, v in pairs(Config.MarketPeds) do
        lib.requestModel(v.Model, 10000)
        local marketPed = CreatePed(1, v.Model, v.Location, false, true, false)

        SetEntityInvincible(marketPed, true)
        SetBlockingOfNonTemporaryEvents(marketPed, true)
        FreezeEntityPosition(marketPed, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.AnimationDict)
            TaskPlayAnim(marketPed, v.AnimationDict, v.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
        end

        exports.ox_target:addSphereZone({
            coords = vec3(v.Location.x, v.Location.y, v.Location.z+1),
            radius = 1,
            debug = Config.Debug,
            options = {
                {
                    label = "Trade "..v.Name,
                    event = 'blackmarket:BuyMenu',
                    args = v,
                    icon = "fa-solid fa-box-archive",
                    iconColor = "yellow",
                    distance = 2, 
                },
            },
        })
    end

    ---------------
    --Selling Ped--
    ---------------

    local sales = Config.ItemSelling.SalesPed
    local pedCoords = sales.SalesPedLocation
    local sellingData = Config.ItemSelling.ItemInfo

    lib.requestModel(sales.SalesPedModel, 10000)
    local salesPed = CreatePed(1, sales.SalesPedModel, sales.SalesPedLocation, false, true, false)
    SetEntityInvincible(salesPed, true)
    SetBlockingOfNonTemporaryEvents(salesPed, true)
    FreezeEntityPosition(salesPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(sales.SalesPedAnimationDict)
        TaskPlayAnim(salesPed, sales.SalesPedAnimationDict, sales.SalesPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = sales.SalesPedName,
                event = 'blackmarket:SellingMenu',
                args = sellingData,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2,
            },
        },
    })

    -------------------
    --Entering Market--
    -------------------

    local entrance = Config.BlackMarketAccess.EntranceInfo
    local randomLocation = math.random(1, #entrance.EntrancePedLocations)
    local dropoffLocation = entrance.EntrancePedLocations[randomLocation]

    lib.requestModel(entrance.EntrancePedModel, 10000)
    local entrancePed = CreatePed(1, entrance.EntrancePedModel, dropoffLocation, false, true, false)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    
    if Config.UseAnims then
        lib.requestAnimDict(entrance.EntrancePedAnimationDict)
        TaskPlayAnim(entrancePed, entrance.EntrancePedAnimationDict, entrance.EntrancePedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(dropoffLocation.x, dropoffLocation.y, dropoffLocation.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = "Speak to "..entrance.EntrancePedName,
                event = 'blackmarket:EntranceMenu',
                args = entrance.EntrancePedName,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
            },
        },
    })

    ------------------
    --Exiting Market--
    ------------------

    local exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = exit.ExitPedLocation

    lib.requestModel(exit.ExitPedModel, 10000)
    local exitPed = CreatePed(1, exit.ExitPedModel, exit.ExitPedLocation, false, true, true)
    SetEntityInvincible(exitPed, true)
    SetBlockingOfNonTemporaryEvents(exitPed, true)
    FreezeEntityPosition(exitPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(exit.ExitPedAnimationDict)
        TaskPlayAnim(exitPed, exit.ExitPedAnimationDict, exit.ExitPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = "Speak to "..exit.ExitPedName,
                event = 'blackmarket:ExitMenu',
                args = exit.ExitPedName,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
            },
        },
    })

    ------------------
    --Weapon Repairs--
    ------------------

    local repair = Config.BlackMarketAccess.RepairsInfo

    lib.requestModel(repair.RepairsPedModel, 10000)
    local repairPed = CreatePed(1, repair.RepairsPedModel, repair.RepairsPedLocation, false, true, true)
    SetEntityInvincible(repairPed, true)
    SetBlockingOfNonTemporaryEvents(repairPed, true)
    FreezeEntityPosition(repairPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(repair.RepairsPedAnimationDict)
        TaskPlayAnim(repairPed, repair.RepairsPedAnimationDict, repair.RepairsPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(repair.RepairsPedLocation.x, repair.RepairsPedLocation.y, repair.RepairsPedLocation.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = "Speak to "..repair.RepairsPedName,
                event = 'blackmarket:RepairMenu',
                args = repair,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
            },
        },
    })
end)