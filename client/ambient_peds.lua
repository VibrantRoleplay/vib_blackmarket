CreateThread(function()
    for k, v in pairs(Config.AmbientPeds.PatrolPeds) do
        Wait(3000)
        lib.requestModel(v.PedModel)
        local guardPed = CreatePed(0, v.PedModel, v.SpawnLocation, 0.0, true, true)

        CreatePatrolRoute("miss_Ass0")
        OpenPatrolRoute("miss_Ass0")
        AddPatrolRouteNode(0, "WORLD_HUMAN_GUARD_STAND", v.Destination0, v.WhereGuardLooksWhileIdle0, v.DurationBetweenWalks)
        AddPatrolRouteNode(1, "WORLD_HUMAN_GUARD_STAND", v.Destination1, v.WhereGuardLooksWhileIdle1, v.DurationBetweenWalks)
        AddPatrolRouteNode(2, "WORLD_HUMAN_GUARD_STAND", v.Destination2, v.WhereGuardLooksWhileIdle2, v.DurationBetweenWalks)
        AddPatrolRouteNode(3, "WORLD_HUMAN_GUARD_STAND", v.Destination3, v.WhereGuardLooksWhileIdle3, v.DurationBetweenWalks)
        AddPatrolRouteLink(0, 1)
        AddPatrolRouteLink(1, 2)
        AddPatrolRouteLink(2, 3)
        AddPatrolRouteLink(3, 2)
        AddPatrolRouteLink(2, 1)
        AddPatrolRouteLink(1, 0)
        ClosePatrolRoute("miss_Ass0")

        TaskPatrol(guardPed, "miss_Ass0", 0, 1, 1)
    end
end)