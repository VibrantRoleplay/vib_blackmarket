CreateThread(function()
    -----------------
    --Money Washing--
    -----------------
    
    if Config.UseMoneyWashing then
        for _, shop in pairs(Config.Washing) do
            lib.requestModel(shop.PedModel, 60000)
    
            local shopKeeper = CreatePed(1, shop.PedModel, shop.PedSpawn, false, true, false)
            SetEntityInvincible(shopKeeper, true)
            SetBlockingOfNonTemporaryEvents(shopKeeper, true)
            FreezeEntityPosition(shopKeeper, true)

            if shop.PlayAnim then
                lib.requestAnimDict(shop.AnimationDict)
                TaskPlayAnim(shopKeeper, shop.AnimationDict, shop.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
            end
    
            if shop.PlayScenario then
                TaskStartScenarioInPlace(shopKeeper, shop.Scenario)
            end
    
            exports.ox_target:addSphereZone({
                coords = vec3(shop.PedSpawn.x, shop.PedSpawn.y, shop.PedSpawn.z+1),
                radius = 1,
                debug = Config.Debug,
                options = {
                    {
                        label = "Speak to "..shop.ShopName.." washer",
                        event = 'blackmarket:WashMenu',
                        args = {
                            shop = shop,
                            shopPed = shopKeeper,
                        },
                        icon = "fa-solid fa-basket-shopping",
                        iconColor = "white",
                        distance = 2,
                    },
                },
            })

            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
            SetModelAsNoLongerNeeded(shop.pedModel)
        end
    end

    ---------------
    --Market Peds--
    ---------------

    for k, v in pairs(Config.MarketPeds) do
        lib.requestModel(v.Model, 60000)
        local marketPed = CreatePed(1, v.Model, v.Location, false, true, false)

        SetEntityInvincible(marketPed, true)
        SetBlockingOfNonTemporaryEvents(marketPed, true)
        FreezeEntityPosition(marketPed, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.AnimationDict)
            TaskPlayAnim(marketPed, v.AnimationDict, v.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
            RemoveAnimDict(v.AnimationDict)
        end

        exports.ox_target:addSphereZone({
            coords = vec3(v.Location.x, v.Location.y, v.Location.z+1),
            radius = 1,
            debug = Config.Debug,
            options = {
                {
                    label = "Trade "..v.Name,
                    onSelect = function()
                        PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
                        exports.ox_inventory:openInventory('shop', {type = v.Name})
                    end,
                    args = v,
                    icon = "fa-solid fa-box-archive",
                    iconColor = "yellow",
                    distance = 2, 
                },
            },
        })

        TriggerServerEvent('blackmarket:server:UpdateMarkets', k, v)
        SetModelAsNoLongerNeeded(v.Model)
    end

    -------------------
    --Entering Market--
    -------------------

    local entrance = Config.BlackMarketAccess.EntranceInfo
    local entrancePedLocation = lib.callback.await('blackmarket:server:GetRandomEntranceLocation', false)

    lib.requestModel(entrance.EntrancePedModel, 60000)
    local entrancePed = CreatePed(1, entrance.EntrancePedModel, entrancePedLocation, false, true, false)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    
    if Config.UseAnims then
        lib.requestAnimDict(entrance.EntrancePedAnimationDict)
        TaskPlayAnim(entrancePed, entrance.EntrancePedAnimationDict, entrance.EntrancePedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)

        RemoveAnimDict(entrance.EntrancePedAnimationDict)
    end

    exports.ox_target:addLocalEntity(entrancePed, {
        {
            label = "Speak to "..entrance.EntrancePedName,
            event = 'blackmarket:EntranceMenu',
            args = entrance.EntrancePedName,
            icon = "fa-solid fa-box-archive",
            iconColor = "yellow",
            distance = 2,
        },
    })

    SetModelAsNoLongerNeeded(entrance.EntrancePedModel)

    ------------------
    --Exiting Market--
    ------------------

    local exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = exit.ExitPedLocation

    lib.requestModel(exit.ExitPedModel, 60000)
    local exitPed = CreatePed(1, exit.ExitPedModel, exit.ExitPedLocation, false, true, true)
    SetEntityInvincible(exitPed, true)
    SetBlockingOfNonTemporaryEvents(exitPed, true)
    FreezeEntityPosition(exitPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(exit.ExitPedAnimationDict)
        TaskPlayAnim(exitPed, exit.ExitPedAnimationDict, exit.ExitPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)

        RemoveAnimDict(exit.ExitPedAnimationDict)
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
    SetModelAsNoLongerNeeded(exit.ExitPedModel)

    ------------------
    --Weapon Repairs--
    ------------------

    for k, v in pairs(Config.BlackMarketAccess.RepairsInfo) do
        lib.requestModel(v.RepairsPedModel, 60000)
        local repairPed = CreatePed(1, v.RepairsPedModel, v.RepairsPedLocation, false, true, true)
        SetEntityInvincible(repairPed, true)
        SetBlockingOfNonTemporaryEvents(repairPed, true)
        FreezeEntityPosition(repairPed, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.RepairsPedAnimationDict)
            TaskPlayAnim(repairPed, v.RepairsPedAnimationDict, v.RepairsPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)

            RemoveAnimDict(v.RepairsPedAnimationDict)
        end

        exports.ox_target:addLocalEntity(repairPed, {
            {
                label = "Speak to "..v.RepairsPedName,
                event = 'blackmarket:RepairMenu',
                args = v,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
            },
        })

        SetModelAsNoLongerNeeded(v.RepairsPedModel)
    end
end)
