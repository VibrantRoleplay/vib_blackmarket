RegisterNetEvent('blackmarket:LaunderMenu', function(data)
    lib.callback('blackmarket:server:GetStoreInfo', false, function(storeInfo)
        lib.callback('blackmarket:server:GetWashTime', false, function(cooldown)
            local headerMenu = {}
            local citizenId = QBCore.Functions.GetPlayerData().citizenid
            print(json.encode(cooldown, {indent = true}))

            if not storeInfo.CurrentlyWashing then
                headerMenu[#headerMenu + 1] = {
                    title = "Launder",
                    description = "So ... you're looking to clean some money...",
                    event = 'blackmarket:client:StartWashing',
                    icon = 'fa-solid fa-dollar',
                    iconColor = "green",
                    args = data,
                }
            else
                if citizenId == storeInfo.Owner then
                    headerMenu[#headerMenu + 1] = {
                        title = "Busy",
                        description = "I'm currently washing your $"..storeInfo.AmountBeingWashed,
                        progress = cooldown,
                        colorScheme = "green",
                        icon = 'fa-solid fa-xmark',
                        iconColor = "red",
                        readOnly = true,
                    }
                else
                    headerMenu[#headerMenu + 1] = {
                        title = "Busy",
                        description = "I'm busy, come back later ... or don't... I don't give a fuck",
                        icon = 'fa-solid fa-xmark',
                        iconColor = "red",
                        readOnly = true,
                    }
                end
            end

            lib.registerContext({
                id = 'launder_menu',
                title = "Shop interaction things",
                options = headerMenu
            })

            lib.showContext('launder_menu')
        end, data)
    end, data.args.ShopName)
end)