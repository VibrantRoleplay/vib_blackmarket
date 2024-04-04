RegisterNetEvent('blackmarket:SellingMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Artwork",
        description = "Sell your valuable Artwork",
        event = "blackmarket:client:SellItemsMenu",
        args = data.args.Artwork,
        icon = "nui://ox_inventory/web/images/art1.png",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Minerals",
        description = "Sell your valuable Minerals",
        event = "blackmarket:client:SellItemsMenu",
        args = data.args.Minerals,
        icon = "nui://ox_inventory/web/images/refined_gold.png",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Electricals",
        description = "Sell your valuable Electricals here",
        event = "blackmarket:client:SellItemsMenu",
        args = data.args.Electricals,
        icon = "nui://ox_inventory/web/images/boombox.png",
    }

    lib.registerContext({
        id = 'main_sales_menu',
        title = data.label,
        options = headerMenu
    })

    lib.showContext('main_sales_menu')
end)

RegisterNetEvent('blackmarket:client:SellItemsMenu', function(data)
	local headerMenu = {}

    for k, v in pairs(data) do
        local itemAmount = exports.ox_inventory:Search('count', v.item)

        if itemAmount <= 0 then
            goto continue
        end
        headerMenu[#headerMenu + 1] = {
            title = exports.ox_inventory:Items(v.item).label,
            description = "I can pay $"..v.price.." for each of these",
            serverEvent = "blackmarket:server:SellItems",
            args = {
                item = v.item,
                price = v.price,
            },
            icon = "nui://ox_inventory/web/images/"..v.item..".png",
        }

        ::continue::
    end

    if next(headerMenu) == nil then
        headerMenu[#headerMenu + 1] = {
            title = "Empty Pockets",
            description = "You don't have anything to sell",
            icon = 'fa-solid fa-x',
            iconColor = 'red',
            readOnly = true,
        }
    end


    lib.registerContext({
        id = 'item_sales_menu',
        title = "Shit",
        options = headerMenu,
        menu = 'main_sales_menu',
    })

    lib.showContext('item_sales_menu')
end)