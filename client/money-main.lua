RegisterNetEvent('blackmarket:client:StartWashing', function(data)
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
end)

RegisterNetEvent('blackmarket:client:LaunderMoney', function(input, data)
    local citizenId = QBCore.Functions.GetPlayerData().citizenid

    if lib.progressCircle({
        duration = 1500,
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
        anim = {
            dict = "mp_common",
            clip = "givetake2_a",
        },
    })
    then
        local moneyLaunderingLoss = input[1] * Config.StoreCut
        TriggerServerEvent('blackmarket:server:StartWashing', input, data, citizenId, moneyLaunderingLoss)
        lib.alertDialog({
			header = "Store owner says:",
			content = "You've started washing $"..input[1].." at: "..data.ShopName.." \n\n I'll be taking a "..(Config.StoreCut * 100).." % cut",
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