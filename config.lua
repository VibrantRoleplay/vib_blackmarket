Config = Config or {}

Config.Debug = false
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
        ExitPedAnimationDict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        ExitPedAnimationClip = "idle_a",
        ExitSpawnVehicle = "sultan", -- Vehicle the player spawns inside
        ExitLocations = { -- One of the below locations will be chosen each time a player LEAVES the black market
            vector4(479.43, -2248.61, 5.91, 329.6),
            vector4(1119.57, -2147.11, 30.83, 354.01),
            vector4(935.48, -1517.98, 31.02, 352.9),
        },
        SeatNumber = 1, -- Seat number the player is placed in after leaving the black market (Drivers seat == -1)
    },
    KidnapPedInfo = {
        KidnapPedModel = "a_m_m_acult_01",
        KidnapPedName = "Frank",
        KidnapPedLocation = vector3(737.43, 4162.98, 41.31),
        KidnapPedWeapon = "WEAPON_PISTOL",
    },
}

Config.ItemSelling = {
    SalesPed = { -- Must be unique
        SalesPedModel = "a_m_m_malibu_01",
        SalesPedName = "Sales Ped",
        SalesPedLocation = vector4(-381.39, -2682.38, 5.0, 329.84),
        SalesPedAnimationDict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
        SalesPedAnimationClip = "idle_a",
    },
    ItemInfo = {
        RareItemSalesChance = 50, -- Chance for a rare item to be sellable per restart (It will only choose 1 random rare item per restart)
        StandardItems = {
            {item = "copperbar", price = 10},
            {item = "silverbar", price = 10},
            {item = "advancedlockpick", price = 10},
        },
        RareItems = {
            {item = "goldbar", price = 10},
        },
    }
}

Config.MarketPeds = {
    SuppliesPed = { -- Must be unique
        Name = "Supplies", -- Must be Unique
        Model = "s_m_m_ciasec_01", -- Ped model
        Location = vector4(899.86, -3206.64, -98.19, 114.26), -- Location ped spawns
        AnimationDict = "amb@prop_human_bum_shopping_cart@male@idle_a", -- Dict for animation
        AnimationClip = "idle_c", -- Animation ped plays
        PropItem = "p_amb_coffeecup_01",
        PropBone = 28422, -- Bone index the prop is attached to
        PropX = 0.0, -- x coord of prop
        PropY = 0.01, -- y coord of prop
        PropZ = 0.05, -- z coord of prop
        PropRotX = 0.0, -- x axis rotation of prop
        PropRotY = 0.0, -- y axis rotation of prop
        PropRotZ = -1.5, -- z axis rotation of prop
        ItemsForSale = { -- Item = Price
            {item = "lockpick", price = 10},
            {item = "screwdriverset", price = 10},
            {item = "advancedlockpick", price = 10},
        },
    },
    AmmoPed = {
        Name = "Ammo",
        Model = "s_m_m_fibsec_01",
        Location = vector4(904.74, -3230.82, -99.27, 345.69),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        PropItem = "p_amb_coffeecup_01",
        PropBone = 28422, -- Bone index the prop is attached to
        PropX = 0.0, -- x coord of prop
        PropY = 0.0, -- y coord of prop
        PropZ = 0.0, -- z coord of prop
        PropRotX = 0.0, -- x axis rotation of prop
        PropRotY = 0.0, -- y axis rotation of prop
        PropRotZ = 0.0, -- z axis rotation of prop
        ItemsForSale = {
            {item = "ammo-9", price = 10},
            {item = "ammo-rifle", price = 10},
            {item = "ammo-shotgun", price = 10},
        },
    },
    AttachmentsPed = {
        Name = "Attachments",
        Model = "s_m_m_highsec_01",
        Location = vector4(908.93, -3207.19, -98.19, 115.63),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        PropItem = "p_amb_coffeecup_01",
        PropBone = 28422, -- Bone index the prop is attached to
        PropX = 0.0, -- x coord of prop
        PropY = 0.0, -- y coord of prop
        PropZ = 0.0, -- z coord of prop
        PropRotX = 0.0, -- x axis rotation of prop
        PropRotY = 0.0, -- y axis rotation of prop
        PropRotZ = -1.5, -- z axis rotation of prop
        ItemsForSale = {
            {item = "at_scope_macro", price = 10},
            {item = "at_scope_small", price = 10},
            {item = "at_scope_medium", price = 10},
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
    HackItem = "laptop",
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

-----------------
--Money Washing--
-----------------

Config.Laundering = {
    {
        ShopName = "Sandy 24/7", -- Unique name per shop
        PedModel = "mp_m_shopkeep_01", -- Model of ped that spawns in shop
        PedSpawn = vector3(1960.15, 3748.89, 31.34), -- Location of each ped
        WashTime = 10, -- Duration in minutes
    },
    {
        ShopName = "Sandy 24/7 2",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector3(1955.91, 3747.17, 31.66),
        WashTime = 10,
    }
}