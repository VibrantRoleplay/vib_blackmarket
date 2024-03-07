RegisterNetEvent('blackmarket:LaunderMenu', function(data)
    local playerJob = lib.callback.await('blackmarket:server:GetPlayerJob', false)

    if playerJob == "police" then
        PlayPedAmbientSpeechNative(data.entity, 'Generic_Fuck_You', 'Speech_Params_Force')
        lib.notify({
            title = 'Unable',
            description = 'I aint talking to no bitch ass cop',
            type = 'error',
        })
        return
    end
    
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HI', 'Speech_Params_Force')

    lib.callback('blackmarket:server:GetStoreInfo', false, function(storeInfo)
        lib.callback('blackmarket:server:GetWashTime', false, function(cooldown)
            local headerMenu = {}
            local citizenId = QBCore.Functions.GetPlayerData().citizenid

            if storeInfo.HasStoreBeenRobbed then
                if citizenId == storeInfo.Robber then
                    headerMenu[#headerMenu + 1] = {
                        title = "No chance",
                        description = "Get fucked ... You know how much trouble you caused me? \n\n I aint dealing with you for a good while, cunt...",
                        icon = 'fa-solid fa-xmark',
                        iconColor = "red",
                    }
                else
                    if citizenId ~= storeInfo.Owner then
                        headerMenu[#headerMenu + 1] = {
                            title = "Closed",
                            description = "I'm closed for the day, piss off",
                            icon = 'fa-solid fa-xmark',
                            iconColor = "red",
                            readOnly = true,
                        }
                    end
                end
            end

            if not storeInfo.CurrentlyWashing then
                headerMenu[#headerMenu + 1] = {
                    title = "Launder",
                    description = "So ... you're looking to clean some money...",
                    event = 'blackmarket:client:StartWashing',
                    args = data,
                    icon = 'fa-solid fa-dollar',
                    iconColor = "green",
                }
            elseif storeInfo.CurrentlyWashing then
                if citizenId == storeInfo.Owner then
                    if cooldown > 0 and not storeInfo.HasStoreBeenRobbed then
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
                        if storeInfo.HasStoreBeenRobbed then
                            if not storeInfo.Investigated then
                                headerMenu[#headerMenu + 1] = {
                                    title = "Investigate",
                                    description = "We got robbed ... I've done some diggin and I've come up with some stuff that might help you",
                                    event = 'blackmarket:client:InvestigateRobbery',
                                    args = {
                                        storeData = data,
                                        robber = storeInfo.Robber,
                                    },
                                    icon = 'fa-solid fa-question',
                                    iconColor = "yellow",
                                }
                            else
                                headerMenu[#headerMenu + 1] = {
                                    title = "I don't know",
                                    description = "I'm sorry boss ... I'll be more careful next time",
                                    icon = 'fa-solid fa-skull',
                                    iconColor = "yellow",
                                    readOnly = true,
                                }
                            end
                        else
                            local returnValue = (storeInfo.AmountBeingWashed - storeInfo.StoreCut)

                            headerMenu[#headerMenu + 1] = {
                                title = "Finished",
                                description = "I've washed your money ... my cut is $"..storeInfo.StoreCut.."  \n\n Your return is $"..returnValue,
                                serverEvent = 'blackmarket:server:RetrieveMoney',
                                args = {
                                    returnMoney = returnValue,
                                    storeData = data,
                                },
                                icon = 'fa-solid fa-dollar',
                                iconColor = "green",
                            }
                        end
                    end
                else
                    if not storeInfo.HasStoreBeenRobbed then
                        headerMenu[#headerMenu + 1] = {
                            title = "Rob Store",
                            description = "You sure you wanna do this? The guy who gave me this money seems unhinged ..." 
                            .."\n\n I'm sure he's watching the cameras, man... He'll know what you're doing",
                            event = 'blackmarket:client:RobStore',
                            args = {
                                storeData = data,
                            },
                            icon = 'fa-solid fa-gun',
                            iconColor = "red",
                        }
                    end
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