Config = Config or {}

Config.Debug = false
Config.UseAnims = true -- false = Peds have no animations and just stand still
Config.MoneyItem = "black_money" -- Item used for dirty money
Config.HeadBagProp = "prop_money_bag_01"

Config.BlackMarketAccess = {
    EntranceInfo = {
        EntrancePedModel = "u_m_m_jesus_01", -- Ped model
        EntrancePedName = "Disciple", -- Must be unique for menu reasons
        EntrancePedLocations = { -- Random locations the entrance can spawn at per restart [Set 1 vector4() if you want a static location]
            vector4(742.82, 4170.05, 39.53, 128.57),
            -- vector4(661.11, 1282.45, 360.29, 264.06),
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
        RepairDuration = 3000, -- How long it takes to repair a weapon in ms
        RepairCost = 1000, -- [Config.MoneyItem] is the currency for this
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
        RareItemSalesChance = 50, -- Chance for rare items to be sellable per restart
        StandardItems = {
            {item = "silverbar", price = 10},
            {item = "advancedlockpick", price = 10},
        },
        RareItems = {
            {item = "goldore", price = 10},
            {item = "goldbar", price = 10},
        },
    }
}

Config.MarketPeds = {
    SuppliesPed = { -- Must be unique
        Name = "Supplies",
        Model = "s_m_m_ciasec_01", -- Ped model
        Location = vector4(899.86, -3206.64, -98.19, 114.26), -- Location ped spawns
        AnimationDict = "amb@prop_human_bum_shopping_cart@male@idle_a", -- Dict for animation
        AnimationClip = "idle_c", -- Animation ped plays
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

Config.Hacking = { -- Locations where players can "Hack" to get the [NumberCode] for the entrance
    HackItem = "laptop", -- Item needed to begin hack
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

Config.UseMoneyLaundering = true -- False if you don't want laundering system to start
Config.DirtyMoneyItem = "black_money"
Config.StoreCut = 0.1
Config.RobDuration = 1 -- How long it taskes to rob a store in seconds

Config.Laundering = {
    {
        ShopName = "Sandy 24/7", -- Unique name per shop
        PedModel = "mp_m_shopkeep_01", -- Model of ped that spawns in shop
        PedSpawn = vector4(1959.86, 3748.68, 31.34, 117.96), -- Location of each ped
        WashTime = 0.5, -- How long the wash takes in minutes (Example: 1 = 1 minute / 0.5 = 30 seconds)
    },
    {
        ShopName = "GrapeSeed 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(1707.31, 4920.68, 41.06, 155.0),
        WashTime = 0.5,
    },
    {
        ShopName = "Chiliad 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(1734.81, 6420.26, 34.03, 26.43),
        WashTime = 0.5,
    },
    {
        ShopName = "Senora Desert 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(545.92, 2663.19, 41.15, 266.01),
        WashTime = 0.5,
    },
    {
        ShopName = "Tatavium 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(2549.85, 385.3, 107.62, 157.79),
        WashTime = 0.5,
    },
    {
        ShopName = "Strawberry 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(28.83, -1339.76, 28.49, 66.97),
        WashTime = 0.5,
    },
    {
        ShopName = "Vinewood 24/7",
        PedModel = "mp_m_shopkeep_01",
        PedSpawn = vector4(378.49, 332.71, 102.56, 61.27),
        WashTime = 0.5,
    },
}

Config.AmbientPeds = {
    Static = {
        {
            PedModel = "a_m_m_prolhost_01",
            SpawnLocation = vector4(888.58, -3206.81, -99.2, 21.69),
            PlayAnim = false, -- Leave as fase if you don't want the ped to play an animation or if [IsPedArmed = true]
            AnimationDict = "amb@world_human_welding@male@base", -- Dictionary of animation
            AnimationClip = "base", -- Animation
            PlayScenario = true,
            Scenario = 'WORLD_HUMAN_WELDING',
            IsPedArmed = false, -- Leave as false if playing animation
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