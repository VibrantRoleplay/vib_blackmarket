RegisterNetEvent('blackmarket:client:StartWashing', function(data)
    local player = cache.ped

    lib.callback("blackmarket:server:GetWashTime", false, function(cooldown)
        if cooldown > 0 then
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
        local moneyAmount = exports.ox_inventory:Search('count', Config.DirtyMoneyItem)

        if moneyAmount >= input[1] then
            TriggerEvent('blackmarket:client:LaunderMoney', input, data.args)
            TriggerServerEvent('blackmarket:server:TriggerWashTimer', data)
        else
            lib.notify({
                title = 'Attention',
                description = "You don't have that much dirty money with you!",
                type = 'error',
            })
        end
    end, data)
end)

RegisterNetEvent('blackmarket:client:LaunderMoney', function(input, data)
    local player = cache.ped

    if lib.progressCircle({
        duration = 1000,
        position = 'bottom',
        label = "Handing over cash",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
        -- anim = {
        --     dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
        --     clip = "idle_a",
        -- },
    })
    then
        TriggerServerEvent('blackmarket:server:StartWashing', input, data)
        lib.alertDialog({
			header = "Store owner says:",
			content = "You've started washing $"..input[1].." at: "..data.ShopName,
			centered = true,
		})
    else
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end)