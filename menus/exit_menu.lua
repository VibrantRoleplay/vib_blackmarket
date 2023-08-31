RegisterNetEvent('blackmarket:ExitMenu', function()
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "What ya want?",
        description = "Oh ... You wanna leave already? :( uwu",
        icon = 'fa-solid fa-question',
        onSelect = function()
            LeavingMarket()
        end,
    }

    lib.registerContext({
        id = 'exit_menu',
        title = "Market Exit",
        options = headerMenu
    })

    lib.showContext('exit_menu')
end)