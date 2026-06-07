DrugsZones = {
    ["coke"] = {
        ["harvest"] = {x = 2132.08, y = 1934.04, z = 92.8},
        ["transform"] = {x = 2329.82, y = 2571.59, z = 45.68},
        ["sell"] = {x = 570.58, y = 2796.52, z = 41.01}
    },
    ["weed"] = {
        ["harvest"] = {x = -924, y = -1163.38, z = 3.82},
        ["transform"] = {x = 1090.02, y = -1278.18, z = 19.22},
        ["sell"] = {x = 988.85, y = -1665.39, z = 36.14}
    },
    ["meth"] = {
        ["harvest"] = {x = 1573.09, y = -2176.58, z = 76.43},
        ["transform"] = {x = 1480.64, y = -1915.35, z = 70.47},
        ["sell"] = {x = -1269.89, y = -1096.3, z = 38.43}
    },
    ["opium"] = {
        ["harvest"] = {x = -303.63, y = 2816.99, z = 58.43},
        ["transform"] = {x = 1388.8, y = 3607.21, z = 38.94},
        ["sell"] = {x = 1514.76, y = 3784.73, z = 33.47}
    },
    ["moneywash"] = {
        ["sell"] = {x = 722.49, y = 4188.9, z = 40.09}
    },
    ["washblack"] = {
        ["sell"] = {x = 2134.52, y = 1944.7, z = 93.76-0.96}
    },
    ["sellall"] = {
        ["sellall"] = {x = 2022.49, y = 2671.8, z = 47-0.97}
    },
}

GoFastZones = {
	["pickup"] = {coords = vector3(1603.99, -2392.12, 90.15), type = "pickup"},
	["delivery1"] = {coords = vector3(1216.07, -1323.75, 34.38), type = "delivery"},
	["delivery2"] = {coords = vector3(-634.3, -1728.04, 23.33), type = "delivery"},
	["delivery3"] = {coords = vector3(2540.93, 2588.98, 36.72), type = "delivery"}
}

GoFastData = {
    ["1"] = {delivery = vector3(1216.07, -1323.75, 34.38), time = 1.5, vehicle = "primo", reward = 10000},
	["2"] = {delivery = vector3(-634.3, -1728.04, 23.33), time = 2.75, vehicle = "sentinel2", reward = 25000},
	["3"] = {delivery = vector3(2540.93, 2588.98, 36.72), time = 6, vehicle = "cyclone", reward = 50000}
}