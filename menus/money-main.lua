RegisterNetEvent('blackmarket:LaunderMenu', function(data)
	local headerMenu = {}

        headerMenu[#headerMenu + 1] = {
            title = "Launder",
            description = "So ... looking to clean some money...",
            event = 'blackmarket:client:StartWashing',
            icon = 'fa-solid fa-dollar',
            iconColor = "green",
            args = data
        }

    lib.registerContext({
        id = 'launder_menu',
        title = "Shop interaction things",
        options = headerMenu
    })

    lib.showContext('launder_menu')
end)