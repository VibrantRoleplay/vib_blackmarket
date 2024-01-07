RegisterNetEvent('blackmarket:RepairMenu', function(data)
    PlayPedAmbientSpeechNative(v.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
    
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)

    headerMenu[#headerMenu + 1] = {
        title = "Attachments",
        description = "Check weapon attachments for held weapon",
        event = 'blackmarket:client:getcomponentinformation',
        icon = 'fa-solid fa-gun',
        iconColor = "orange",
    }

    if moneyAmount > data.args.RepairCost then
        repairWeaponDescription = "I'll charge ya $"..data.args.RepairCost.." to repair any weapon"
    else
        repairWeaponDescription = "It don't seem like you have enough cash"
    end

    headerMenu[#headerMenu + 1] = {
        title = "Weapon Repairs",
        description = repairWeaponDescription,
        event = 'blackmarket:client:RepairWeapon',
        args = data,
        icon = 'fa-solid fa-hammer',
        iconColor = "yellow",
        readOnly = data.args.RepairCost > moneyAmount
    }

    lib.registerContext({
        id = 'repair_menu',
        title = "Weapons Repair",
        options = headerMenu
    })

    lib.showContext('repair_menu')
end)