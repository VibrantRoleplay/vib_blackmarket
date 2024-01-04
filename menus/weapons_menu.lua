RegisterNetEvent('blackmarket:RepairMenu', function(data)
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', Config.MoneyItem)

    headerMenu[#headerMenu + 1] = {
        title = "Attachments",
        description = "Check weapon attachments for held weapon",
        event = 'blackmarket:client:getcomponentinformation',
        icon = 'fa-solid fa-hammer',
        iconColor = "yellow",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Weapon Repairs",
        description = "Repair current weapon in hand",
        event = 'blackmarket:client:RepairWeapon',
        args = data,
        icon = 'fa-solid fa-hammer',
        iconColor = "yellow",
        disabled = data.args.RepairCost > moneyAmount
    }

    lib.registerContext({
        id = 'repair_menu',
        title = "Weapons Repair",
        options = headerMenu
    })

    lib.showContext('repair_menu')
end)