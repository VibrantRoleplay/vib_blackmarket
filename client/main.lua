QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

local RecentHack = 0

----------
--Events--
----------

RegisterNetEvent("blackmarket:OpenShop", function(v)
    local player = cache.ped

    TriggerEvent("blackmarket:Menu", v)
end)

RegisterNetEvent("blackmarket:client:GetCode", function()
    local player = cache.ped
    local zoneOptions = Config.Hacking.ZoneOptions
    lib.requestAnimDict("amb@world_human_bum_wash@male@low@idle_a")

    if RecentHack == 0 or GetGameTimer() > RecentHack then
        TaskPlayAnim(player, 'amb@world_human_bum_wash@male@low@idle_a', 'idle_a', 1.0, 1.0, -1, 01, 0, true, true, true)
        Wait(2500)
        exports['ps-ui']:VarHack(function(success)
            if success then
                if lib.progressCircle({
                    duration = zoneOptions.HackDuration,
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
                    RecentHack = GetGameTimer() + zoneOptions.Cooldown
                    ClearPedTasksImmediately(player)
                    TriggerEvent("blackmarket:GiveCode", player)
                    lib.notify({
                        title = 'Good job',
                        description = "You got what you came for!",
                        type = 'success'
                    })
                else
                    ClearPedTasksImmediately(player)
                    lib.notify({
                        title = 'Canceled',
                        description = "Canceled",
                        type = 'error'
                    })
                end
            else
                ClearPedTasksImmediately(player)
                lib.notify({
                    title = 'Failed',
                    description = "You failed, best get moving!",
                    type = 'error'
                })
            end
        end, 4, 6)
    else
        lib.notify({
            title = 'Attention',
            description = 'Looks like someone already hit this',
            type = 'inform'
        })
    end
end)

RegisterNetEvent("blackmarket:GiveCode", function()
    lib.callback('blackmarket:server:GenerateNumberCode', false, function(correctCode)
        local code = correctCode
        lib.notify({
            title = "Attention",
            description = 'The access code is: '..code.. '. Make sure you write it down!',
            type = 'inform',
            duration = 6000,
        })
    end)
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

    kidnapPed = CreatePed(1, Kidnap.KidnapPedModel, Kidnap.KidnapPedLocation, false, true)
    TaskPlayAnim(player, 'missminuteman_1ig_2', 'handsup_base', 8.0, 8.0, -1, 49, 0, true, true, true)
    FreezeEntityPosition(player, true)
    GiveWeaponToPed(kidnapPed, Kidnap.KidnapPedWeapon, 1000, false, true)
    TaskGoStraightToCoord(kidnapPed, playerCoords, 6.5, 400, 0.0, 0)
    Wait(3500)
    TaskTurnPedToFaceCoord(kidnapPed, playerCoords.x, playerCoords.y, playerCoords.z, 2000)
    TaskAimGunAtEntity(kidnapPed, player, -1)
    headbagObject = CreateObject(headbagProp, 0, 0, 0, true, true, true)
    AttachEntityToEntity(headbagObject, player, GetPedBoneIndex(player, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(headbagObject, false, true)
    SendNUIMessage({
        type = "openGeneral"
    })
    Wait(5000)
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
    local vehicle = Exit.ExitSpawnVehicle

    lib.requestModel(vehicle)

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    QBCore.Functions.SpawnVehicle(vehicle, function(JobVehicle)
        local plate = "byee"..tostring(math.random(1000, 9999))
        SetVehicleNumberPlateText(JobVehicle, plate)
        Entity(JobVehicle).state.fuel = 100.0
        TaskWarpPedIntoVehicle(player, JobVehicle, Exit.SeatNumber)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(JobVehicle))
        SetVehicleEngineOn(JobVehicle, true, true)
        exports.ox_inventory:ClearInventory('trunk'..plate)
        Wait(500)
        exports.ox_inventory:ClearInventory('glove'..plate)
    end, dropoffLocation, true)

    DoScreenFadeIn(1000)
end