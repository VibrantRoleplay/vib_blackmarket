CreateThread(function()
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

        exports.ox_target:addLocalEntity(marketPed, {
            {
                label = 'Trade '..v.Name,
                onSelect = function()
                    PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
                    exports.ox_inventory:openInventory('shop', {type = v.Name})
                end,
                args = v,
                icon = 'fa-solid fa-box-archive',
                iconColor = "yellow",
                distance = 2, 
            },
        })

        TriggerServerEvent('blackmarket:server:UpdateMarkets', k, v)
        SetModelAsNoLongerNeeded(v.Model)
    end

    -------------------
    --Entering Market--
    -------------------

    local entranceInfo = lib.callback.await('blackmarket:server:GetRandomEntranceLocation', false)

    lib.requestModel(entranceInfo.pedModel, 60000)
    local entrancePed = CreatePed(1, entranceInfo.pedModel, entranceInfo.location, false, true, false)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)

    SetModelAsNoLongerNeeded(entranceInfo.pedModel)
    
    if entranceInfo.animInfo.active then
        lib.requestAnimDict(entranceInfo.animInfo.dict)
        TaskPlayAnim(entrancePed, entranceInfo.animInfo.dict, entranceInfo.animInfo.clip, 4.0, 4.0, -1, 1, false, false, false, false)
        RemoveAnimDict(entranceInfo.animInfo.dict)
    end

    if entranceInfo.propInfo.active then
        local placement = entranceInfo.propInfo.placement
        lib.RequestModel(entranceInfo.propInfo.propModel, 60000)
        local propModel = CreateObject(entranceInfo.propInfo.propModel, entranceInfo.location.xyz, false, true, false)
        AttachEntityToEntity(propModel, entrancePed, GetPedBoneIndex(entrancePed, entranceInfo.propInfo.bone), placement.x, placement.y, placement.z, placement.xRot, placement.yRot, placement.zRot, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(entranceInfo.propInfo.propModel)
    end

    exports.ox_target:addLocalEntity(entrancePed, {
        {
            label = 'Speak',
            event = 'blackmarket:EntranceMenu',
            icon = 'fa-solid fa-comment-dots',
            iconColor = 'yellow',
            distance = 2,
        },
    })

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

    exports.ox_target:addLocalEntity(exitPed, {
        {
            label = 'Speak to '..exit.ExitPedName,
            event = 'blackmarket:ExitMenu',
            args = exit.ExitPedName,
            icon = 'fa-solid fa-box-archive',
            iconColor = 'yellow',
            distance = 2, 
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
                label = 'Speak to '..v.RepairsPedName,
                event = 'blackmarket:RepairMenu',
                args = v,
                icon = 'fa-solid fa-box-archive',
                iconColor = 'yellow',
                distance = 2, 
            },
        })

        SetModelAsNoLongerNeeded(v.RepairsPedModel)
    end

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

            SetModelAsNoLongerNeeded(shop.PedModel)

            if shop.PlayAnim then
                lib.requestAnimDict(shop.AnimationDict)
                TaskPlayAnim(shopKeeper, shop.AnimationDict, shop.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
            end
    
            if shop.PlayScenario then
                TaskStartScenarioInPlace(shopKeeper, shop.Scenario)
            end

            
    
            exports.ox_target:addLocalEntity(shopKeeper, {
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
            })

            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
        end
    end
end)