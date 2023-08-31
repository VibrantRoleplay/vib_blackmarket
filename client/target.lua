CreateThread(function()
    local locations = Config.Hacking.Locations
    local zoneOptions = Config.Hacking.ZoneOptions
    
    for _, hackLocations in pairs(locations) do

        if Config.Debug then
            print(json.encode(hackLocations, {indent = true}))
        end

        exports.ox_target:addSphereZone({
            name = "Hack zones",
            coords = hackLocations,
            radius = 1.0,
            debug = Config.Debug,
            options = {
                {
                    event = "blackmarket:client:GetCode",
                    icon = "fas fa-ring",
                    item = "goldpan",
                    label = zoneOptions.HackLabel,
                    distance = 1.0,
                },
            },
        })
    end
end)