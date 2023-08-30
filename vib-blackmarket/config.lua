Config = Config or {}

Config.Debug = true
Config.UseAnims = true -- false = Peds have no animations and just stand still
Config.UseProps = false -- false = Peds don't hold any props

Config.BlackMarketAccess = {
    EntranceInfo = {
        EntrancePedModel = "u_m_m_jesus_01", -- Ped model
        EntrancePedName = "Disciple", -- Must be unique for menu reasons
        EntrancePedLocation = vector4(742.82, 4170.05, 39.53, 128.57), -- Location of the ped
        EntrancePedAnimationDict = "amb@prop_human_seat_deckchair@male@base", -- Dictionary of animation
        EntrancePedAnimationClip = "base", -- Animation ped plays
        EntranceLocation = vector4(892.62, -3245.87, -98.28, 73.49), -- Where the player lands after being teleported inside
    },
    ExitInfo = {
        ExitPedModel = "a_m_m_acult_01",
        ExitPedName = "Gimp",
        ExitPedLocation = vector4(895.4, -3242.6, -99.26, 81.78),
        ExitPedAnimationDict = "amb@prop_human_seat_deckchair@male@base",
        ExitPedAnimationClip = "base",
        ExitSpawnVehicle = "sultan", -- Vehicle the player spawns inside
        ExitLocations = { -- One of the below locations will be chosen each time a player LEAVES the black market
            vector4(479.43, -2248.61, 5.91, 329.6),
            vector4(1119.57, -2147.11, 30.83, 354.01),
            vector4(935.48, -1517.98, 31.02, 352.9),
        },
        SeatNumber = 2, -- Seat numbers start at -1 (-1 == drivers seat) - If you choose a 2 door car, it';ll either be [-1] or [0]
    },
    KidnapPedInfo = {
        KidnapPedModel = "a_m_m_acult_01",
        KidnapPedName = "Frank",
        KidnapPedLocation = vector3(737.43, 4162.98, 41.31),
        KidnapPedWeapon = "WEAPON_PISTOL",
    },
}

Config.MarketPeds = {
    SuppliesPed = { -- Must be unique
        Name = "Supplies", -- Must be Unique
        Model = "s_m_m_ciasec_01", -- Ped model
        Location = vector4(891.83, -3211.57, -99.21, 204.62), -- Location ped spawns
        AnimationDict = "amb@world_human_welding@male@base", -- Dict for animation
        AnimationClip = "base", -- Animation ped plays
        Prop = "prop_weld_torch",
        ItemsForSale = { -- Item = Price
            lockpick = 10,
            screwdriverset = 10,
            advancedlockpick = 10,
        },
    },
    AmmoPed = {
        Name = "Ammo",
        Model = "s_m_m_fibsec_01",
        Location = vector4(904.74, -3230.82, -99.27, 345.69),
        AnimationDict = "amb@world_human_aa_coffee@base",
        AnimationClip = "base",
        Prop = "apa_mp_h_acc_vase_02",
        ItemsForSale = {
            can = 10,
            cola = 10,
            weapon_pistol = 10,
        },
    },
    AttachmentsPed = {
        Name = "Attachments",
        Model = "s_m_m_highsec_01",
        Location = vector4(908.93, -3207.19, -98.19, 115.63),
        AnimationDict = "amb@code_human_wander_gardener_leaf_blower@base",
        AnimationClip = "static",
        Prop = "prop_leaf_blower_01",
        ItemsForSale = {
            at_scope_macro = 10,
            at_scope_small = 10,
            at_scope_medium = 10,
        },
    },
}

Config.EntranceTypes = {
    Riddles = {
        {
            Question = "What gets more wet as it dries?",
            Answers = {
                "A Human",
                "A Spud",
                "A Sponge",
                "A Towel",
            },
            Correct_Answer = "A Towel",
        },
        {
            Question = "What has to be broken before you can use it?",
            Answers = {
                "A Phone",
                "A Mirror",
                "A Chair",
                "An Egg",
            },
            Correct_Answer = "An Egg",
        },
        {
            Question = "What creature walks on four legs in the morning, two legs in the afternoon, and three legs in the evening?",
            Answers = {
                "A Centipede",
                "A Dog",
                "A Paraplegic",
                "A Man",
            },
            Correct_Answer = "A Man",
        },
        {
            Question = "What is always in front of you but you can't see it?",
            Answers = {
                "A Car",
                "A Phone",
                "Your Nose",
                "The Future",
            },
            Correct_Answer = "The Future",
        },
    },
    NumberCode = math.random(1111, 9999), -- This can be as many numbers as you want or a static number
}

Config.Hacking = { -- Locations where players can "Hack" to get the [NumberCode] for the entrance
    ZoneOptions = {
        HackDuration = 10000, -- How long the hack takes in ms
        HackProgressbarLabel = "Doing hacker stuff",
        HackLabel = "Hack in", -- Label the player see's when targeting the zone
        Cooldown = 60000, -- Cooldown for obtaining [NumberCode] in ms
    },
    Locations = { -- You can add as many locations here as you like
        vector3(43.41, -668.6, 31.74),
        vector3(475.62, -1017.01, 28.0),
        vector3(313.93, -1439.34, 29.96),
        vector3(1180.46, -1498.94, 34.85),
        vector3(-2033.56, -370.31, 20.09),
    },
}