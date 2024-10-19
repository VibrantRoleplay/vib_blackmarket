RegisterNetEvent('blackmarket:WashMenu', function(data)
    local playerJob = lib.callback.await('blackmarket:server:GetPlayerJob', false)

    if playerJob == "police" then
        PlayPedAmbientSpeechNative(data.entity, 'GENERIC_INSULT_HIGH', 'SPEECH_PARAMS_FORCE_SHOUTED')
        lib.notify({
            title = 'Staying Quiet',
            description = "I don't talk to cops",
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
                        readOnly = true,
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
                    title = "Washing service",
                    description = "Wash your money here for a price",
                    event = 'blackmarket:client:StartWashing',
                    args = data,
                    icon = 'fa-solid fa-hands-bubbles',
                    iconColor = "white",
                }
            elseif storeInfo.CurrentlyWashing then
                if citizenId == storeInfo.Owner then
                    if cooldown > 0 and not storeInfo.HasStoreBeenRobbed then
                        headerMenu[#headerMenu + 1] = {
                            title = "Busy",
                            description = "Don't worry boss! Your $"..storeInfo.AmountBeingWashed.." will be washed in no time!",
                            progress = cooldown,
                            colorScheme = 'violet',
                            icon = 'fa-solid fa-hourglass-start',
                            iconColor = "yellow",
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
                                    icon = 'fa-solid fa-sack-dollar',
                                    iconColor = "red",
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
                                description = "I've washed your money ... my cut is $"..math.floor(storeInfo.StoreCut).."  \n\n Your return is $"..math.floor(returnValue),
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
                            title = "Rob",
                            description = "Rob money from store",
                            event = 'blackmarket:client:RobStore',
                            args = {
                                storeData = data,
                                washAmount = storeInfo.AmountBeingWashed,
                            },
                            icon = 'fa-solid fa-gun',
                            iconColor = "red",
                        }
                    end
                end
            end

            lib.registerContext({
                id = 'wash_menu',
                title = "Washing service",
                options = headerMenu
            })

            lib.showContext('wash_menu')
        end, data.args.shop)
    end, data.args.shop.ShopName)
end)