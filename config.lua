Config = Config or {}
Config.MinimumDrugSalePolice = 0

Config.Products = {
    [1] = {
        name = "weed_white-widow",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 1,
        minrep = 0,
    },
    [2] = {
        name = "weed_skunk",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 2,
        minrep = 20,
    },
    [3] = {
        name = "weed_purple-haze",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 3,
        minrep = 40,
    },
    [4] = {
        name = "weed_og-kush",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 4,
        minrep = 60,
    },
    [5] = {
        name = "weed_amnesia",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 5,
        minrep = 80,
    },
    [6] = {
        name = "weed_white-widow_seed",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 6,
        minrep = 100,
    },
    [7] = {
        name = "weed_skunk_seed",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 7,
        minrep = 120,
    },
    [8] = {
        name = "weed_purple-haze_seed",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 8,
        minrep = 140,
    },
    [9] = {
        name = "weed_og-kush_seed",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 9,
        minrep = 160,
    },
    [10] = {
        name = "weed_amnesia_seed",
        price = 15,
        amount = 150,
        info = {},
        type = "item",
        slot = 10,
        minrep = 180,
    },
}

Config.Dealers = {}

Config.CornerSellingDrugsList = {
    "weed_white-widow",
    "weed_skunk",
    "weed_purple-haze",
    "weed_og-kush",
    "weed_amnesia",
    "weed_ak47",
    "crack_baggy",
    "cokebaggy",
    "meth"
}

Config.DrugsPrice = {
    ["weed_white-widow"] = {
        min = 15,
        max = 24,
    },
    ["weed_og-kush"] = {
        min = 15,
        max = 28,
    },
    ["weed_skunk"] = {
        min = 15,
        max = 31,
    },
    ["weed_amnesia"] = {
        min = 18,
        max = 34,
    },
    ["weed_purple-haze"] = {
        min = 18,
        max = 37,
    },
    ["weed_ak47"] = {
        min = 18,
        max = 40,
    },
    ["crack_baggy"] = {
        min = 18,
        max = 34,
    },
    ["cokebaggy"] = {
        min = 18,
        max = 37,
    },
    ["meth"] = {
        min = 18,
        max = 40,
    },
}

Config.DeliveryLocations = {
    [1] = {
        ["label"] = "Stripclub",
        ["coords"] = vector3(106.24, -1280.32, 29.24),
    },
    [2] = {
        ["label"] = "Vinewood Video",
        ["coords"] = vector3(223.98, 121.53, 102.76),
    },
    [3] = {
        ["label"] = "Taxi",
        ["coords"] = vector3(882.67, -160.26, 77.11),
    },
    [4] = {
        ["label"] = "Resort",
        ["coords"] = vector3(-1245.63, 376.21, 75.34),
    },
    [5] = {
        ["label"] = "Bahama Mamas",
        ["coords"] = vector3(-1383.1, -639.99, 28.67),
    },
}

Config.CornerSellingZones = {
    vector2(810.61, 213.64),
    vector2(630.30, 309.09),
    vector2(331.82, 571.21),
    vector2(293.94, 824.24),
    vector2(118.18, 827.27),
    vector2(87.88, 628.79),
    vector2(-50.00, 616.67),
    vector2(-318.18, 818.18),
    vector2(-715.15, 983.33),
    vector2(-904.55, 865.15),
    vector2(-1174.24, 845.45),
    vector2(-1525.76, 583.33),
    vector2(-1851.52, 701.52),
    vector2(-2021.21, 690.91),
    vector2(-2095.45, 466.67),
    vector2(-2043.94, 150.00),
    vector2(-2022.73, -136.36),
    vector2(-2169.70, -224.24),
    vector2(-2193.94, -333.33),
    vector2(-2213.64, -439.39),
    vector2(-1786.36, -981.82),
    vector2(-1580.30, -1212.12),
    vector2(-1231.82, -1881.82),
    vector2(-1206.06, -1953.03),
    vector2(-1554.55, -2213.64),
    vector2(-1809.09, -2675.76),
    vector2(-2012.12, -3016.67),
    vector2(-1959.09, -3206.06),
    vector2(-1127.27, -3580.30),
    vector2(-913.64, -3595.45),
    vector2(-730.30, -3242.42),
    vector2(-857.58, -3036.36),
    vector2(-722.73, -2818.18),
    vector2(-778.79, -2706.06),
    vector2(-504.55, -2954.55),
    vector2(113.64, -3353.03),
    vector2(1304.55, -3369.70),
    vector2(1309.09, -2753.03),
    vector2(1309.09, -2613.64),
    vector2(1656.06, -2542.42),
    vector2(1816.67, -1469.70),
    vector2(1612.12, -1304.55),
    vector2(1312.12, -1462.12),
    vector2(1287.88, -1181.82),
    vector2(1427.27, -809.09),
    vector2(1475.76, -550.00),
    vector2(1109.09, -119.70)
}

Config.DeliveryItems = {
    [1] = {
        ["item"] = "weed_brick",
        ["minrep"] = 0,
    },
}
