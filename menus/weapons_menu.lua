RegisterNetEvent('blackmarket:RepairMenu', function(data)
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Weapon Repairs",
        description = "Repair Weapon in hand",
        serverEvent = 'blackmartket:server:RepairWeapon',
        args = data.args.RepairItems,
        icon = 'fa-solid fa-hammer',
        iconColor = "yellow",
    }

    lib.registerContext({
        id = 'repair_menu',
        title = "Weapons Repair",
        options = headerMenu
    })

    lib.showContext('repair_menu')
end)