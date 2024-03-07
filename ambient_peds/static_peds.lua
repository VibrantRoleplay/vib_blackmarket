CreateThread(function()
    for k, pedInfo in pairs(Config.AmbientPeds.Static) do
        lib.requestModel(pedInfo.PedModel)
        Wait(500)
        
        local ambientPed = CreatePed(0, pedInfo.PedModel, pedInfo.SpawnLocation.xyz, pedInfo.SpawnLocation.w, true, true)
        SetBlockingOfNonTemporaryEvents(ambientPed, true)
        FreezeEntityPosition(ambientPed, true)
        SetEntityInvincible(ambientPed, true)
        Wait(250)
        if pedInfo.IsPedArmed then
            GiveWeaponToPed(ambientPed, 736523883, 1000, false, true)
            TaskShootAtCoord(ambientPed, 902.86, -3133.16, -97.13, -1, "FIRING_PATTERN_BURST_FIRE")
        end
    end
end)