-------------
--Variables--
-------------

local recentHack = 0
local bl_ui = exports.bl_ui

----------
--Events--
----------

RegisterNetEvent("blackmarket:client:GetCode", function()
    local player = cache.ped
    local zoneOptions = Config.Hacking.ZoneOptions
    local hackItem = exports.ox_inventory:Search('count', Config.Hacking.HackItem)
    
    if hackItem == 0 then
        lib.notify({
            title = 'Missing items',
            description = "You're missing tools",
            type = 'error',
        })
        return
    end

    if recentHack == 0 or GetGameTimer() > recentHack then
        lib.requestAnimDict("amb@world_human_bum_wash@male@low@idle_a")
        TaskPlayAnim(player, 'amb@world_human_bum_wash@male@low@idle_a', 'idle_a', 1.0, 1.0, -1, 01, 0, true, true, true)
        local success = bl_ui:CircleShake(2, math.random(25, 50), 3)

        if success then
            if lib.progressCircle({
                duration = zoneOptions.HackDuration * 1000,
                position = 'bottom',
                label = zoneOptions.HackProgressbarLabel,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                    mouse = false,
                },
                anim = {
                    dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
                    clip = "idle_a",
                },
                prop = {
                    {
                        model = `prop_cs_tablet_02`,
                        bone = 60309,
                        pos = vec3(0.03, 0.002, -0.0),
                        rot = vec3(10.0, 160.0, 0.0)
                    },
                }
            })
            then
                recentHack = GetGameTimer() + (zoneOptions.Cooldown * 1000)
                ClearPedTasksImmediately(player)
                local correctCode = lib.callback.await('blackmarket:server:GenerateNumberCode', false)
                lib.notify({
                    title = "Attention",
                    description = 'The access code is: '..correctCode.. '. Make sure you write it down!',
                    type = 'inform',
                    duration = 6000,
                })
            else
                ClearPedTasksImmediately(player)
                lib.notify({
                    title = 'Canceled',
                    description = "Canceled",
                    type = 'error',
                })
            end
        else
            ClearPedTasksImmediately(player)
            lib.notify({
                title = 'Failed',
                description = "You failed, best get moving!",
                type = 'error',
            })
        end
    else
        lib.notify({
            title = 'Attention',
            description = 'Looks like someone already hit this',
            type = 'inform',
        })
    end
end)

---------------------
--Hacking Locations--
---------------------

CreateThread(function()
    local locations = Config.Hacking.Locations
    local zoneOptions = Config.Hacking.ZoneOptions
    
    for _, hackLocations in pairs(locations) do
        exports.ox_target:addSphereZone({
            name = "Hack zones",
            coords = hackLocations,
            radius = 1.0,
            debug = Config.Debug,
            options = {
                {
                    label = zoneOptions.HackLabel,
                    event = "blackmarket:client:GetCode",
                    icon = "fa-solid fa-code",
                    iconColor = "purple",
                    distance = 1.0,
                },
            },
        })
    end
end)
