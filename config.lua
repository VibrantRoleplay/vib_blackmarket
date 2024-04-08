Config = Config or {}

Config.Debug = false
Config.UseAnims = true -- false = Peds have no animations and just stand still
Config.MoneyItem = "black_money" -- Item used for money
Config.HeadBagProp = "prop_money_bag_01" -- Prop placed on players head when entering black market

Config.BlackMarketAccess = {
    EntranceInfo = {
        EntrancePedModel = "u_m_m_jesus_01", -- Ped model
        EntrancePedName = "Disciple", -- Must be unique for menu reasons
        EntrancePedLocations = { -- Random locations the entrance can spawn at per restart [Set 1 vector4() if you want a static location]
            vector4(742.82, 4170.05, 39.53, 128.57),
        },
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
        ExitLocations = { -- One of the below locations will be chosen each time a player LEAVES the black market [Set 1 vector4() if you want a static location]
            vector4(479.43, -2248.61, 5.91, 329.6),
            vector4(1119.57, -2147.11, 30.83, 354.01),
            vector4(935.48, -1517.98, 31.02, 352.9),
        },
    },
    RepairsInfo = {
        RepairsPedModel = "a_m_m_acult_01",
        RepairsPedName = "Mac",
        RepairsPedLocation = vector4(907.85, -3211.16, -99.23, 23.39),
        RepairsPedAnimationDict = "missfbi5ig_15",
        RepairsPedAnimationClip = "look_into_microscope_a_scientista",
        RepairDuration = 5000, -- How long it takes to repair a weapon in ms
        RepairCost = 175, -- [Config.MoneyItem] is the currency for this
    },
}

Config.ItemSelling = {
    SalesPed = { -- Must be unique
        SalesPedModel = "a_m_m_malibu_01",
        SalesPedName = "Sell Items",
        SalesPedLocation = vector4(-381.39, -2682.38, 5.0, 329.84),
        SalesPedAnimationDict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
        SalesPedAnimationClip = "idle_a",
    },
    ItemInfo = {
        Artwork = {
            {item = "art1", price = math.random(50, 100)}, -- Price is chosen per restart
            {item = "art2", price = math.random(50, 100)},
            {item = "art3", price = math.random(50, 100)},
            {item = "art4", price = math.random(50, 100)},
            {item = "art5", price = math.random(50, 100)},
            {item = "art6", price = math.random(50, 100)},
            {item = "art7", price = math.random(50, 100)},
        },
        Minerals = {
            {item = "refined_gold", price = math.random(125, 275)},
            {item = "refined_silver", price = math.random(125, 275)},
        },
        Electricals = {
            {item = "boombox", price = math.random(125, 275)},
            {item = "md_speakers", price = math.random(125, 275)},
            {item = "md_tablet", price = math.random(125, 275)},
            {item = "md_desktop", price = math.random(125, 275)},
            {item = "md_monitor", price = math.random(125, 275)},
            {item = "laptop", price = math.random(75, 150)},
            {item = "phone", price = math.random(50, 125)},
            {item = "tablet", price = math.random(65, 125)},
            {item = "house_laptop", price = math.random(250, 450)},
            {item = "mansion_laptop", price = math.random(375, 550)},
        },
    }
}

Config.MarketPeds = {
    {
        Name = "Supplies",
        Model = "s_m_m_ciasec_01", -- Ped model
        Location = vector4(899.86, -3206.64, -98.19, 114.26), -- Ped location
        AnimationDict = "amb@prop_human_bum_shopping_cart@male@idle_a", -- Dict for animation
        AnimationClip = "idle_c", -- Animation ped plays
        ItemsForSale = { -- Item / Item Price / Stock amount per restart
            {Item = "lockpick", Price = 10, AvailableStock = 10},
            {Item = "screwdriverset", Price = 10, AvailableStock = 10},
            {Item = "advancedlockpick", Price = 10, AvailableStock = 10},
        },
    },
    {
        Name = "Ammo",
        Model = "s_m_m_fibsec_01",
        Location = vector4(904.74, -3230.82, -99.27, 345.69),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        ItemsForSale = {
            {Item = "ammo-9", Price = 10, AvailableStock = 10},
            {Item = "ammo-rifle", Price = 10, AvailableStock = 10},
            {Item = "ammo-shotgun", Price = 10, AvailableStock = 10},
        },
    },
    {
        Name = "Attachments",
        Model = "s_m_m_highsec_01",
        Location = vector4(908.93, -3207.19, -98.19, 115.63),
        AnimationDict = "amb@world_human_drinking@coffee@male@idle_a",
        AnimationClip = "idle_c",
        ItemsForSale = {
            {Item = "at_scope_macro", Price = 10, AvailableStock = 10},
            {Item = "at_scope_small", Price = 10, AvailableStock = 10},
            {Item = "at_scope_medium", Price = 10, AvailableStock = 10},
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
            Correct_Answer = "A Towel", -- Must match one of the [Answers] above
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

Config.Hacking = {
    HackItem = "laptop", -- Item required to begin hack
    ZoneOptions = {
        HackDuration = 10, -- How long the hack takes in seconds
        HackProgressbarLabel = "Doing hacker stuff",
        HackLabel = "Hack in", -- Label the player see's when targeting the zone
        Cooldown = 60, -- Cooldown for obtaining [NumberCode] in seconds
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

Config.UseMoneyWashing = true -- [false] = money washing peds will NOT spawn
Config.DirtyMoneyItem = "black_money"
Config.RobDuration = 1 -- How long it taskes to rob a store in seconds

Config.Washing = {
    {
        ShopName = "Sandy 24/7", -- Unique name per shop (Used for cooldowwn  & target name purposes)
        PedModel = "mp_m_shopkeep_01", -- Ped model
        PedSpawn = vector4(1959.86, 3748.68, 31.34, 117.96), -- Ped Location
        WashTime = 25, -- Duration of wash in minutes (I.e 0.5 = 30 seconds)
        PercentageTakenFromPlayer = 0.1, -- % of money taken by NPC after washing money
    },
    {
        ShopName = "GrapeSeed 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(1707.31, 4920.68, 41.06, 155.0),
        WashTime = 25,
        PercentageTakenFromPlayer = 0.1,
    },
    {
        ShopName = "Strawberry 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(28.83, -1339.76, 28.49, 66.97),
        WashTime = 20,
        PercentageTakenFromPlayer = 0.1,
    },
    {
        ShopName = "Casino Laundry",
        PedModel = "a_m_m_business_01",
        PedSpawn = vector4(811.53, -107.79, 79.61, 220.8),
        WashTime = 15,
        PercentageTakenFromPlayer = 0.6,
    },
}

Config.AmbientPeds = {
    Static = {
        {
            PedModel = "a_m_m_prolhost_01", -- Ped model
            SpawnLocation = vector4(888.58, -3206.81, -99.2, 21.69), -- Ped location
            PlayAnim = false, -- Set to false if [PlayScenario] or [IsPedArmed] = true
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = true, -- set to false if [PlayAnim] = true
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = false, -- Set to false if [PlayAnim] or [PlayScenario] = true
            WeaponIfArmed = nil, -- Leave as nil if [IsPedArmed = false] otherwise make sure the weapon HASH is used (https://gtahash.ru/weapons/?page=1)
        },
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(888.95, -3194.64, -99.2, 165.48),
            PlayAnim = false,
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = true,
            Scenario = 'WORLD_HUMAN_GUARD_PATROL',
            IsPedArmed = false,
            WeaponIfArmed = nil,
        },
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(896.07, -3170.7, -98.13, 347.87),
            PlayAnim = false,
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = false,
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = true,
            WeaponIfArmed = 453432689,
            
        },
        {
            PedModel = "s_m_m_chemsec_01",
            SpawnLocation = vector4(892.59, -3170.18, -98.13, 345.9),
            PlayAnim = false,
            AnimationDict = "amb@world_human_welding@male@base",
            AnimationClip = "base",
            PlayScenario = false,
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = true,
            WeaponIfArmed = 736523883,
        },
    },
}