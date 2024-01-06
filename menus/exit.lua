RegisterNetEvent('blackmarket:ExitMenu', function()
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "What ya want?",
        description = "Looking to leave?  \n\nNo peaking ... I'll whack you if you do!",
        icon = 'fa-solid fa-question',
        iconColor = "yellow",
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