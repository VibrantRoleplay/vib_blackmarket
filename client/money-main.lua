RegisterNetEvent('blackmarket:client:StartWashing', function(data)
    local player = cache.ped

    lib.callback("blackmarket:server:GetWashTime", false, function(cooldown)
        if cooldown > 0 then
            print("cooldown remaining: ", cooldown)
            lib.alertDialog({
                header = "Too busy",
                content = "I'm far too busy, come back another time my friend!",
                centered = true,
            })
            return
        end

        local input = lib.inputDialog('Laundering', {
            {
                type = "number",
                label = "Money Value",
                description = "How much you looking to clean?",
                required = true,
                icon = "fa-solid fa-bullet",
            },
        })
        if not input or #input < 1 then
            return
        end
        TriggerEvent('blackmarket:client:LaunderMoney', input, data)
        TriggerServerEvent('blackmarket:server:TriggerWashTimer', data)
    end, data)
end)

RegisterNetEvent('blackmarket:client:LaunderMoney', function(input, data)
    local player = cache.ped

    print("input: ", json.encode(input, {indent = true}))
    print("data: ", json.encode(data, {indent = true}))
end)