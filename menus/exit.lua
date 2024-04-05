RegisterNetEvent('blackmarket:ExitMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "What ya want?",
        description = "Looking to leave?  \n\nNo peeking ... I'll whack you if you do!",
        onSelect = function()
            LeavingMarket()
        end,
        icon = 'fa-solid fa-question',
        iconColor = "yellow",
    }

    lib.registerContext({
        id = 'exit_menu',
        title = "Market Exit",
        options = headerMenu
    })

    lib.showContext('exit_menu')
end)