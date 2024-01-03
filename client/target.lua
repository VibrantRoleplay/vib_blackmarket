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
                    event = "blackmarket:client:GetCode",
                    label = zoneOptions.HackLabel,
                    icon = "fa-solid fa-code",
                    iconColor = "purple",
                    distance = 1.0,
                },
            },
        })
    end

    exports.ox_target:addSphereZone({
        name = "Weapon repairs",
        coords = Config.WeaponRepair.RepairBenchLocation,
        radius = 1.0,
        debug = Config.Debug,
        options = {
            {
                event = "blackmarket:client:GetCode",
                label = "Repair weapon",
                icon = "fa-solid fa-hammer",
                iconColor = "yellow",
                distance = 1.0,
            },
        },
    })
end)