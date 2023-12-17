CreateThread(function()
    for k, v in pairs(Config.AmbientPeds.PatrolPeds) do
        print("k: ", json.encode(k, {indent = true}))
        print("k: ", json.encode(k, {indent = true}))
    end

    for k, v in pairs(Config.AmbientPeds.ScenarioPeds) do
        print("k: ", json.encode(k, {indent = true}))
    end
end)