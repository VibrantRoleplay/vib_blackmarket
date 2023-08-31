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
        if Config.UseProps then
            local Model = v.Prop
            lib.requestModel(Model)
            AttachEntityToEntity(Model, MarketPeds, 57005, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, false, false, false, true, 2, true)
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
                    event = 'blackmarket:OpenShop',
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
    local pedCoords = Entrance.EntrancePedLocation

    lib.requestModel(Entrance.EntrancePedModel)
    entrancePed = CreatePed(1, Entrance.EntrancePedModel, Entrance.EntrancePedLocation, false, true)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    if Config.UseAnims then
        lib.requestAnimDict(Entrance.EntrancePedAnimationDict)
        TaskPlayAnim(entrancePed, Entrance.EntrancePedAnimationDict, Entrance.EntrancePedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
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