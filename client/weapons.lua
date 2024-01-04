----------------------
--Weapon Attachments--
----------------------

RegisterNetEvent('blackmarket:client:getcomponentinformation', function()
   local player = cache.ped
   local currentWeapon = GetSelectedPedWeapon(player)
   local labels = {}

    for k, v in pairs(exports.ox_inventory:Items()) do
        local search = k
        local stringSearch = string.sub(k, 1, 3)

        if stringSearch == "at_" then -- (All attachments in OX weapons.lua start with at_ by default, so that's what we search for)
            local attachment = k
            local components = v.client.component
            local label = v.label

            for _, component in pairs(components) do
                if DoesWeaponTakeWeaponComponent(currentWeapon, component) then
                    table.insert(labels, label)
                end
            end
        end
    end

    local markdown = "\n"

    for i, element in ipairs(labels) do
        markdown = markdown .. "- " .. element .. "\n"
    end

    if next(labels) == nil then
        lib.notify({
            title = 'Unable',
            description = "You don't have a weapon in your hand for me to see",
            type = 'error'
        })
        return
    end

    local alert = lib.alertDialog({
        header = 'Seems like your weapon will be able to use some of the following:',
        content = markdown,
        centered = true,
        cancel = false
    })
end)

------------------
--Weapon Repairs--
------------------

RegisterNetEvent('blackmarket:client:RepairWeapon', function(data)
    local weaponDura = lib.callback.await('blackmarket:server:CheckWeaponData', false)

    if weaponDura.durability == 100 then
        lib.notify({
            title = 'Attention',
            description = "Your weapon is already in good repair",
            type = 'inform'
        })
        return
    end

    lib.requestNamedPtfxAsset('scr_sm_trans')
    SetPtfxAssetNextCall('scr_sm_trans')
    local smokeEffect = StartParticleFxLoopedAtCoord('scr_sm_trans_smoke', 907.42, -3210.36, -98.44, 0.0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, 0)

    if lib.progressCircle({
        duration = data.args.RepairDuration,
        position = 'bottom',
        label = 'Repairing Weapon',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
    })
    then   
        StopParticleFxLooped(smokeEffect, 0)
        TriggerServerEvent('blackmarket:server:RepairWeapon', data)
    else
        StopParticleFxLooped(smokeEffect, 0)
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end)