# blackmarket
Black market resource for illegal sales and crafting

# DEPENDENCIES

- QBCore
- ox_lib
- ox_inventory
- ox_target
- ps-ui

# What does this resource provide?

- Peds where players can buy configurable stock from using [Config.MoneyItem]
- Ped where players can sell configurable items to, receiving [Config.MoneyItem]
- Configurable, unique money washing locations across the city, with the ability to be robbed and interrogated (Converts[Config.MoneyItem] to ["money"])
- Ped where players can interact with and see what attachments can be applied to their currently held weapon
- Ped where players can fully repair their currently held weapon

# How do players access the blackmarket?

One of two ways!

They can either do a quick hack. Upon completion of said hack, they'll be given a code that they can give over to be teleported in or they can answer one of many
configurable questions/riddles from the [Config.EntranceTypes.Riddles]

# How do players exit the market?

Players can simply speak to a ped inside the market to leave. Upon leaving the market, the player will be respawned in one of the locations from [ExitInfo.ExitLocations] table (We prefer to keep these locations within a fair walking distance of local traffic or a garage)

# FAQ

# How do I move the locations of stuff?

Easy! Every location (Minus particle effects and the like) are all in the config. So, moving everyhting is kept just about all in one place!

# Why can't my players take a car inside the market?

SIMPLE! Not all server owners will have this location in a vehicle friendly location and we didn't want to make a config value and a bunch of code for some to do so and others not

# Why aren't you using ["marked_bills"] for your currency of dirty money?

Whilst this resource is free and we'd love to see it on every server out there, before anything else we've designed it for OUR server specifically and with it being open source, you're free and encouraged to make changes!