QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

local RecentHack = 0

----------
--Events--
----------

RegisterNetEvent("blackmarket:client:GetCode", function()
    local player = cache.ped
    local zoneOptions = Config.Hacking.ZoneOptions
    local hackItem = exports.ox_inventory:Search('count', Config.Hacking.HackItem)
    
    if hackItem == 0 then
        lib.notify({
            title = 'Missing items',
            description = "You're missing tools",
            type = 'error',
        })
        return
    end

    if RecentHack == 0 or GetGameTimer() > RecentHack then
        lib.requestAnimDict("amb@world_human_bum_wash@male@low@idle_a")
        TaskPlayAnim(player, 'amb@world_human_bum_wash@male@low@idle_a', 'idle_a', 1.0, 1.0, -1, 01, 0, true, true, true)
        exports['ps-ui']:VarHack(function(success)
            if success then
                if lib.progressCircle({
                    duration = zoneOptions.HackDuration * 1000,
                    position = 'bottom',
                    label = zoneOptions.HackProgressbarLabel,
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        move = true,
                        car = true,
                        combat = true,
                        mouse = false,
                    },
                    anim = {
                        dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
                        clip = "idle_a",
                    },
                    prop = {
                        {
                            model = `prop_cs_tablet_02`,
                            bone = 60309,
                            pos = vec3(0.03, 0.002, -0.0),
                            rot = vec3(10.0, 160.0, 0.0)
                        },
                    }
                })
                then
                    RecentHack = GetGameTimer() + (zoneOptions.Cooldown * 1000)
                    ClearPedTasksImmediately(player)
                    local correctCode = lib.callback.await('blackmarket:server:GenerateNumberCode', false)
                    lib.notify({
                        title = "Attention",
                        description = 'The access code is: '..correctCode.. '. Make sure you write it down!',
                        type = 'inform',
                        duration = 6000,
                    })
                else
                    ClearPedTasksImmediately(player)
                    lib.notify({
                        title = 'Canceled',
                        description = "Canceled",
                        type = 'error',
                    })
                end
            else
                ClearPedTasksImmediately(player)
                lib.notify({
                    title = 'Failed',
                    description = "You failed, best get moving!",
                    type = 'error',
                })
            end
        end, 4, 6)
    else
        lib.notify({
            title = 'Attention',
            description = 'Looks like someone already hit this',
            type = 'inform',
        })
    end
end)

-------------
--Functions--
-------------

function SpawnKidnapPed()
    local player = cache.ped
    local Kidnap = Config.BlackMarketAccess.KidnapPedInfo
    local playerCoords = GetEntityCoords(player)
    local headbagProp = "prop_money_bag_01"

    lib.requestModel(Kidnap.KidnapPedModel)
    lib.requestModel(headbagProp)
    lib.requestAnimDict("missminuteman_1ig_2")

    kidnapPed = CreatePed(1, Kidnap.KidnapPedModel, playerCoords.x-2, playerCoords.y-2, playerCoords.z, false, true)
    TaskPlayAnim(player, 'missminuteman_1ig_2', 'handsup_base', 8.0, 8.0, -1, 49, 0, true, true, true)
    FreezeEntityPosition(player, true)
    GiveWeaponToPed(kidnapPed, Kidnap.KidnapPedWeapon, 1000, false, true)
    TaskGoStraightToCoord(kidnapPed, playerCoords, 6.5, 400, 0.0, 0)
    Wait(1500)
    TaskTurnPedToFaceCoord(kidnapPed, playerCoords.x, playerCoords.y, playerCoords.z, 2000)
    TaskAimGunAtEntity(kidnapPed, player, -1)
    headbagObject = CreateObject(headbagProp, 0, 0, 0, true, true, true)
    AttachEntityToEntity(headbagObject, player, GetPedBoneIndex(player, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(headbagObject, false, true)
    SendNUIMessage({
        type = "openGeneral"
    })
    Wait(3500)
    TeleportPlayer()
    DeleteEntity(kidnapPed)
end

function TeleportPlayer()
    local player = cache.ped
    local coords = Config.BlackMarketAccess.EntranceInfo.EntranceLocation

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(player, coords.w)

    Wait(100)

    DoScreenFadeIn(1000)
    FreezeEntityPosition(player, false)
    ClearPedTasksImmediately(player)
    DeleteEntity(headbagObject)
    SendNUIMessage({
        type = "closeAll"
    })
end

function LeavingMarket()
    local player = cache.ped
    local Exit = Config.BlackMarketAccess.ExitInfo
    local randomLocation = math.random(1, #Exit.ExitLocations)
    local dropoffLocation = Exit.ExitLocations[randomLocation]

    lib.requestAnimDict("timetable@tracy@sleep@")
    DoScreenFadeOut(500)

    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetEntityCoords(player, dropoffLocation.x, dropoffLocation.y, dropoffLocation.z, false, false, false, false)
    TaskPlayAnim(player, 'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_shit2strong_laz', 8.0, 8.0, -1, 01, 0, true, true, true)
    DoScreenFadeIn(1000)
    Wait(1500)
    ClearPedTasksImmediately(player)
end