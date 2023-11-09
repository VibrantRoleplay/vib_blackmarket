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
                    icon = "fa-solid fa-code",
                    iconColor = "purple",
                    label = zoneOptions.HackLabel,
                    distance = 1.0,
                },
            },
        })
    end
end)