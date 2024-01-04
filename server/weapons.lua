RegisterNetEvent('blackmarket:server:RepairWeapon', function(data)
    local player = QBCore.Functions.GetPlayer(source)
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(source)

    if currentWeapon.metadata.durability >= 90 then
        if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.args.RepairCost) then
            exports.ox_inventory:SetDurability(source, currentWeapon.slot, 100)
            lib.notify(source, {
                title = 'new durability',
                description = 'Weapon durability was: '..currentDura.. '\n\nNew durability is: 100.0',
                type = 'inform'
            })
        end
    else
        local currentDura = currentWeapon.metadata.durability
        local newDura = (currentDura + data.args.RepairAmount)
        
        if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.args.RepairCost) then
            exports.ox_inventory:SetDurability(source, currentWeapon.slot, newDura)
            lib.notify(source, {
                title = 'new durability',
                description = 'old dura was: '..currentDura.. '\n\nNew dura is: '..newDura,
                type = 'inform'
            })
        end
    end
end)

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:CheckWeaponData', function()
    local player = QBCore.Functions.GetPlayer(source)
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(source)

    if currentWeapon == nil or currentWeapon.name == 'WEAPON_UNARMED' then
        lib.notify(source, {
            title = 'Unable',
            description = "You're not holding a weapon",
            type = 'inform'
        })
        return
    end

    return currentWeapon.metadata
end)