RegisterNetEvent('blackmarket:client:StartWashing', function(data)
    local moneyAmount = exports.ox_inventory:Search('count', Config.DirtyMoneyItem)

    local input = lib.inputDialog('Washing', {
        {
            type = "slider",
            label = "Amount",
            description = "How much you looking to clean?",
            required = true,
            min = 1,
            max = moneyAmount,
            icon = "fa-solid fa-dollar",
            iconColor = 'green',
        },
    })

    if input == nil then
        return
    end

    TriggerEvent('blackmarket:client:WashMoney', input, data.args.shop)
    TriggerServerEvent('blackmarket:server:TriggerWashTimer', data)
end)

RegisterNetEvent('blackmarket:client:WashMoney', function(input, data)
    local citizenId = QBCore.Functions.GetPlayerData().citizenid

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
        anim = {
            dict = "mp_common",
            clip = "givetake2_a",
        },
    })
    then
        local moneyWashingLoss = input[1] * data.PercentageTakenFromPlayer
        
        TriggerServerEvent('blackmarket:server:StartWashing', input, data, citizenId, moneyWashingLoss)
        lib.notify({
            title = 'Started',
            description = 'Handed over $'..input[1].."! I'll take my cut at the end",
            type = 'success'
        })
    else
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end)

RegisterNetEvent('blackmarket:client:RobStore', function(data)
    local currentWeapon = lib.callback.await('blackmarket:server:CheckWeaponData', false)
    local canRob = false

    if currentWeapon == nil then
        return
    end

    for k, v in pairs(Config.UseableWeapons) do
        if string.lower(currentWeapon.name) == v then
            canRob = true
        end
    end

    if not canRob then
        lib.notify({
            title = 'No way',
            description = "You can't rob here with such little firepower",
            type = 'error'
        })
        return
    end

    local citizenId = QBCore.Functions.GetPlayerData().citizenid
    TaskAimGunAtCoord(cache.ped, data.storeData.args.shop.PedSpawn.x, data.storeData.args.shop.PedSpawn.y, data.storeData.args.shop.PedSpawn.z+1, (Config.RobDuration * 1000), true, true)

    if lib.progressCircle({
        duration = (Config.RobDuration * 1000),
        position = 'bottom',
        label = "Robbing store",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = true,
        },
        -- anim = {
        --     dict = "random@shop_robbery",
        --     clip = "robbery_action_b",
        --     flag = 16,
        -- },
    })
    then
        TriggerServerEvent('blackmarket:server:RobStore', data, citizenId)
        lib.notify({
            title = 'Robbed',
            description = "You robbed $"..data.washAmount.."! Best get moving!",
            type = 'success'
        })
    else
        ClearPedTasksImmediately(cache.ped)
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end)

RegisterNetEvent('blackmarket:client:InvestigateRobbery', function(data)
    lib.callback('blackmarket:server:InvestigateRobbery', false, function(robberInfo)
        lib.alertDialog({
            header = "Store owner says:",
            content = "Boss ... I got robbed... but before you go balistic, I did manage to get a little bit of information for you: "
            .."\n\n Here's their CID: "..data.robber.." and their nationality: "..robberInfo.nationality,
            centered = true,
        })
    end, data)
end)