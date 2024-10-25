QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

-------------
--Functions--
-------------

function SpawnKidnapPed()
    local player = cache.ped
    local playerCoords = GetEntityCoords(player)

    lib.requestModel("a_m_m_acult_01", 60000)
    lib.requestModel(Config.HeadBagProp, 60000)
    lib.requestAnimDict("melee@unarmed@streamed_variations")

    local kidnapPed = CreatePed(1, "a_m_m_acult_01", playerCoords.x-1.0, playerCoords.y-1.0, playerCoords.z, false, true, true)
    SetModelAsNoLongerNeeded("a_m_m_acult_01")
    SetModelAsNoLongerNeeded(Config.HeadBagProp)

    local kidnapPedCoords = GetEntityCoords(kidnapPed)
    SetEntityHeading(kidnapPed, playerCoords)
    TaskTurnPedToFaceCoord(kidnapPed, playerCoords.x, playerCoords.y, playerCoords.z, 1000)
    Wait(2000)

    TaskPlayAnim(kidnapPed, 'melee@unarmed@streamed_variations', 'plyr_takedown_rear_lefthook', 8.0, 8.0, -1, 10, 0, true, true, true)
    RemoveAnimDict("melee@unarmed@streamed_variations")
    Wait(750)

    SetPedToRagdollWithFall(player, 7500, 9000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    Wait(1500)

    headbagObject = CreateObject(Config.HeadBagProp, 0, 0, 0, true, true, true)
    AttachEntityToEntity(headbagObject, player, GetPedBoneIndex(player, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(headbagObject, false, true)

    SendNUIMessage({
        type = "openGeneral"
    })

    Wait(1500)

    SetEntityAsNoLongerNeeded(kidnapPed)

    TeleportPlayer()
end

function TeleportPlayer()
    local player = cache.ped
    local coords = Config.BlackMarketAccess.EntranceInfo.EntranceLandingLocation

    DoScreenFadeOut(3000)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(player, coords.w)

    Wait(100)

    DoScreenFadeIn(5000)
    while not IsScreenFadedIn() do
        Wait(10)
    end

    DeleteEntity(headbagObject)
    FreezeEntityPosition(player, false)
    ClearPedTasks(player)

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
    DoScreenFadeOut(3000)

    while not IsScreenFadedOut() do
        Wait(10)
    end

    SetEntityCoords(player, dropoffLocation.x, dropoffLocation.y, dropoffLocation.z, false, false, false, false)
    TaskPlayAnim(player, 'anim@amb@nightclub@lazlow@lo_sofa@', 'lowsofa_dlg_shit2strong_laz', 8.0, 8.0, -1, 01, 0, true, true, true)
    RemoveAnimDict("timetable@tracy@sleep@")
    DoScreenFadeIn(5000)

    while not IsScreenFadedIn() do
        Wait(10)
    end

    ClearPedTasks(player)
end