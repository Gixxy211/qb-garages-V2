GarageConfig = {}
GarageConfig.AutoRespawn = true          -- true == stores cars in garage on restart | false == doesnt modify car states
GarageConfig.VisuallyDamageCars = true   -- true == damage car on spawn | false == no damage on spawn
GarageConfig.SharedGarages = false       -- true == take any car from any garage | false == only take car from garage stored in
GarageConfig.ClassSystem = false         -- true == restrict vehicles by class | false == any vehicle class in any garage
GarageConfig.FuelResource = 'qb-fuel' -- supports any that has a GetFuel() and SetFuel() export
GarageConfig.Warp = false                 -- true == warp player into vehicle | false == vehicle spawns without warping

-- https://docs.fivem.net/natives/?_0x29439776AAA00A62
GarageConfig.VehicleClass = {
    all = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22 },
    car = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 18, 22 },
    air = { 15, 16 },
    sea = { 14 },
    rig = { 10, 11, 17, 19, 20 }
}

GarageConfig.Garages = {
    ["Occupation Ave Garage"] = {
        label = 'Occupation Ave Parking',
        takeVehicle = vector3(274.29, -334.15, 44.92),
        zone = {
            shape = { -- Create a polyzone by using '/pzcreate poly', '/pzadd' and '/pzfinish' or '/pzcancel' to cancel it. the newly created polyzone will be in txData/QBCoreFramework_******.base/polyzone_created_zones.txt
                vector2(267.63858032227, -314.39105224609),
                vector2(258.39846801758, -343.55117797852),
                vector2(294.19735717773, -357.86618041992),
                vector2(305.30615234375, -328.1120300293)
            },
            minZ = 44.019950866699,
            maxZ = 46.019950866699,
            -- VERY IMPORTANT: Make sure the parking zone is high enough - higher than the tallest vehicle and LOW ENOUGH / touches the ground (turn on debug to see)
        },
        spawnPoint = {
            vector4(293.39, -349.81, 44.3, 70.47),
            vector4(294.46, -346.47, 44.28, 70.88),
            vector4(296.17, -343.33, 44.28, 70.95),
            vector4(297.12, -339.86, 44.28, 69.71),
            vector4(297.12, -339.86, 44.28, 69.71),
            vector4(299.19, -333.34, 44.28, 69.18),
            vector4(300.49, -330.19, 44.28, 69.65),
            vector4(289.12, -326.04, 44.28, 248.97),
            vector4(287.82, -329.17, 44.28, 249.77),
            vector4(286.66, -332.5, 44.28, 247.69),
            vector4(285.53, -335.87, 44.28, 249.13),
            vector4(283.95, -338.96, 44.28, 248.97),
            vector4(282.82, -342.1, 44.28, 250.36),
            vector4(284.0, -324.15, 44.28, 69.37),
            vector4(282.27, -327.17, 44.28, 69.86),
            vector4(281.0, -330.42, 44.28, 68.27),
            vector4(279.91, -333.71, 44.28, 67.28),
            vector4(278.35, -336.77, 44.28, 69.7),
            vector4(277.37, -340.19, 44.28, 68.41),
            vector4(271.08, -319.43, 44.28, 248.7),
            vector4(269.26, -322.4, 44.28, 249.16),
            vector4(268.23, -325.67, 44.28, 251.47),
            vector4(267.5, -328.99, 44.28, 250.96),
            vector4(265.85, -332.07, 44.28, 249.44)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public', -- public, gang, job, depot
        category = GarageConfig.VehicleClass['all']
    },
    ["Apartment Garage"] = {
        label = 'Apartment Parking',
        takeVehicle = vector3(-693.35, -1102.33, 14.11),
        zone = {
            shape = {
                vector2(-688.72351074218, -1105.252319336),
                vector2(-693.35711669922, -1098.5419921875),
                vector2(-706.83795166016, -1107.3133544922),
                vector2(-702.70935058594, -1113.8671875)
            },
            minZ = 12.525604248046,
            maxZ = 17.525606155396,
        },
        spawnPoint = {
            vector4(-693.35, -1102.33, 14.11, 212.95),
            vector4(-696.92, -1104.49, 14.11, 211.76),
            vector4(-700.31, -1106.59, 14.11, 213.12),
            vector4(-703.79, -1108.65, 14.11, 213.41)
        },
        showBlip = true,
        blipName = 'Apartment Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Vespucci Beach Garage"] = {
        label = 'Vespucci Beach Parking',
        zone = {
            shape = {
                vector2(-1316.0959472656, -1130.9549560547),
                vector2(-1321.2368164062, -1130.7243652344),
                vector2(-1321.236328125, -1153.6495361328),
                vector2(-1316.0729980469, -1153.7891845703)
            },
            minZ = 3.49,
            maxZ = 5.49,
        },
        takeVehicle = vector3(-1323.59, -1143.19, 4.42),
        spawnPoint = {
            vector4(-1318.73, -1134.5, 4.16, 92.02),
            vector4(-1318.95, -1137.66, 4.1, 91.53),
            vector4(-1318.65, -1141.34, 4.11, 91.91),
            vector4(-1318.84, -1145.17, 4.11, 90.96),
            vector4(-1318.79, -1148.51, 4.11, 90.73),
            vector4(-1318.91, -1151.8, 4.17, 93.47)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Mirror Park Garage"] = {
        label = 'Mirror Park Parking',
        zone = {
            shape = {
                vector2(1007.247253418, -764.10473632812),
                vector2(1031.0369873047, -794.39038085938),
                vector2(1048.7291259766, -794.59844970703),
                vector2(1049.6694335938, -769.24688720703),
                vector2(1023.3350219727, -752.16235351562)
            },
            minZ = 56.99,
            maxZ = 58.99,
        },
        takeVehicle = vector3(1033.26, -765.09, 58.18),
        spawnPoint = {
            vector4(1015.81, -770.93, 57.5, 309.54),
            vector4(1018.11, -773.4, 57.51, 308.59),
            vector4(1020.46, -776.4, 57.49, 307.65),
            vector4(1022.86, -779.29, 57.49, 308.93),
            vector4(1025.28, -782.39, 57.48, 312.74),
            vector4(1028.17, -770.94, 57.64, 144.68),
            vector4(1030.81, -773.45, 57.67, 144.24),
            vector4(1027.38, -785.17, 57.48, 307.49),
            vector4(1029.67, -788.07, 57.47, 307.16),
            vector4(1046.53, -782.19, 57.61, 89.95),
            vector4(1046.35, -785.59, 57.6, 91.31),
            vector4(1046.42, -778.44, 57.62, 90.24)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Casino Garage"] = {
        label = 'Casino Parking',
        zone = {
            shape = {
                vector2(870.03948974609, -5.4726943969727),
                vector2(847.56652832031, -40.945533752441),
                vector2(865.67010498047, -51.732013702393),
                vector2(887.86694335938, -16.47052192688)
            },
            minZ = 77.84,
            maxZ = 79.84,
        },
        takeVehicle = vector3(873.51, -18.32, 78.76),
        spawnPoint = {
            vector4(883.07, -16.32, 78.37, 56.82),
            vector4(880.76, -18.67, 78.37, 59.06),
            vector4(879.29, -21.71, 78.37, 59.02),
            vector4(877.7, -24.92, 78.37, 57.79),
            vector4(875.82, -27.81, 78.37, 56.62),
            vector4(873.96, -30.49, 78.37, 56.82),
            vector4(872.26, -33.9, 78.37, 55.92),
            vector4(860.58, -26.35, 78.37, 236.42),
            vector4(862.75, -23.65, 78.37, 238.06),
            vector4(864.37, -20.8, 78.37, 238.69),
            vector4(866.36, -17.89, 78.37, 237.8),
            vector4(867.88, -14.83, 78.37, 239.22)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Tuner Shop Garage"]= {
        label = 'Tuner Shop Parking',
        zone = {
            shape = {
                vector2(159.00495910644, -3011.0944824218),
                vector2(168.07168579102, -3011.3381347656),
                vector2(169.36390686036, -2987.982421875),
                vector2(159.21203613282, -2987.23046875)

            },
            minZ = 4.8767561912536,
            maxZ = 8.0137224197388

        },
        takeVehicle = vector3(163.19, -3009.21, 5.53),
        spawnPoint = {
            vector4(163.19, -3009.21, 5.53, 270.02),
            vector4(163.66, -3006.16, 5.52, 269.81),
            vector4(163.77, -3002.86, 5.51, 270.28),
            vector4(163.98, -2999.62, 5.51, 270.53),
            vector4(164.05, -2996.3, 5.51, 269.18),
            vector4(163.79, -2993.14, 5.51, 269.36),
            vector4(163.32, -2989.82, 5.5, 269.76)
        },
        showBlip = true,
        blipName = 'Tuner Shop Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Mining Garage"] = {
        label = 'Mining Parking',
        zone = {
            shape = {
                vector2(2481.5021972656, 1586.6632080078),
                vector2(2465.2097167969, 1586.8752441406),
                vector2(2465.1166992188, 1580.2175292969),
                vector2(2453.3491210938, 1569.5010986328),
                vector2(2453.3491210938, 1563.8603515625),
                vector2(2478.7795410156, 1563.8167724609)
            },
            minZ = 31.72,
            maxZ = 33.72,
        },
        takeVehicle = vector3(2473.28, 1566.84, 32.33),
        spawnPoint = {
            vector4(2473.28, 1566.84, 32.33, 0.45),
            vector4(2477.1, 1584.29, 32.33, 179.32),
            vector4(2473.79, 1583.83, 32.33, 181.05),
            vector4(2470.28, 1583.89, 32.33, 181.52),
            vector4(2479.85, 1583.91, 32.33, 179.28)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Sandy Shores Garage"] = {
        label = 'Sandy Shores Parking',
        zone = {
            shape = {
                vector2(1748.0808105469, 3711.8063964844),
                vector2(1738.5590820313, 3733.1381835938),
                vector2(1714.6356201172, 3721.67578125),
                vector2(1722.2064208984, 3704.3276367188)
            },
            minZ = 32.889950866699,
            maxZ = 34.019950866699,
        },
        takeVehicle = vector3(1737.03, 3718.88, 34.05),
        spawnPoint = {
            vector4(1739.92, 3716.1, 33.45, 21.63),
            vector4(1735.54, 3714.19, 33.48, 20.58)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Paleto Garage"] = {
        label = 'Paleto Parking',
        zone = {
            shape = {
                vector2(67.040328979492, 6415.5810546875),
                vector2(-25.122016906738, 6323.75),
                vector2(-11.668456077576, 6304.4697265625),
                vector2(109.81146240234, 6372.2202148438)
            },
            minZ = 30.019950866699,
            maxZ = 32.019950866699,
        },
        takeVehicle = vector3(76.88, 6397.3, 31.23),
        spawnPoint = {
            vector4(72.1, 6404.47, 30.58, 135.43),
            vector4(75.31, 6401.36, 30.58, 132.96),
            vector4(77.89, 6398.39, 30.58, 136.05),
            vector4(80.86, 6396.1, 30.58, 134.47),
            vector4(59.67, 6400.91, 30.58, 217.2),
            vector4(59.67, 6400.91, 30.58, 217.2),
            vector4(64.68, 6406.7, 30.58, 211.84),
            vector4(66.4, 6379.98, 30.6, 35.64),
            vector4(63.37, 6377.44, 30.6, 32.38),
            vector4(60.47, 6375.04, 30.6, 32.78)

        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['all']
    },
    ["Impound Lot"] = {
        label = 'Impound Lot',
        takeVehicle = vector3(401.76, -1632.57, 29.29),
        zone = {
            shape = {
                vector2(411.75018310547, -1619.7192382812),
                vector2(406.21807861328, -1626.2105712891),
                vector2(403.39260864258, -1623.6715087891),
                vector2(388.09436035156, -1641.982421875),
                vector2(410.87994384766, -1660.5321044922),
                vector2(423.43499755859, -1645.0350341797),
                vector2(423.10702514648, -1628.1901855469)
            },
            minZ = 27.019950866699,
            maxZ = 31.019950866699,
        },
        spawnPoint = {
            vector4(410.97, -1656.46, 28.66, 320.75),
            vector4(408.44, -1654.62, 28.66, 321.12),
            vector4(405.62, -1652.84, 28.67, 318.71),
            vector4(403.29, -1650.45, 28.67, 318.35),
            vector4(400.94, -1648.48, 28.67, 317.55),
            vector4(398.43, -1646.93, 28.67, 319.89),
            vector4(396.18, -1644.76, 28.67, 317.7),
            vector4(418.31, -1646.32, 28.66, 48.59)
        },
        showBlip = true,
        blipName = 'Depot Lot',
        blipNumber = 68,
        blipColor = 0,
        type = 'depot',
        category = GarageConfig.VehicleClass['all']
    },
    ["Paleto Impound"] = {
        label = 'Paleto Impound Lot',
        takeVehicle = vector3(-406.34, 6163.87, 31.54),
        zone = {
            shape = {
                vector2(-397.79446411133, 6154.513671875),
                vector2(-390.42739868164, 6162.1098632812),
                vector2(-413.61340332031, 6186.4052734375),
                vector2(-421.85897827148, 6177.6879882812)
            },
            minZ = 30.419950866699,
            maxZ = 32.419950866699,
        },
        spawnPoint = {
            vector4(-400.61, 6161.88, 31.08, 353.93),
            vector4(-403.58, 6165.09, 31.13, 353.89),
            vector4(-406.23, 6167.49, 31.11, 354.28),
            vector4(-412.0, 6173.58, 31.09, 350.22),
            vector4(-409.32, 6170.57, 31.08, 352.72)
        },
        showBlip = true,
        blipName = 'Depot Lot Nord',
        blipNumber = 68,
        blipColor = 0,
        type = 'depot',
        category = GarageConfig.VehicleClass['all']
    },
    ["BCSO Garage"] = {
        label = 'BCSO Sherrif',
        takeVehicle = vector3(1859.49, 3693.98, 34.43),
        zone = {
            shape = {
                vector2(1873.2486572266, 3687.4318847656),
                vector2(1862.1466064453, 3681.103515625),
                vector2(1849.1208496094, 3703.37890625),
                vector2(1861.6126708984, 3707.6049804688)
            },
            minZ = 32.019950866699,
            maxZ = 35.019950866699,
        },
        spawnPoint = {
            vector4(1869.28, 3687.23, 33.05, 120.12),
            vector4(1867.38, 3690.7, 33.1, 120.15),
            vector4(1865.38, 3693.6, 33.11, 119.51),
            vector4(1863.8, 3697.37, 33.1, 120.25),
            vector4(1861.97, 3700.87, 33.1, 120.25),
            vector4(1860.13, 3704.45, 33.09, 121.05)
        },
        showBlip = false,
        blipName = 'Sherrif',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = GarageConfig.VehicleClass['all'], --car, air, sea, rig
        job = 'bcso',
        jobType = 'leo'
    },
    ["Paleto PD Garage"] = {
        label = 'Paleto PD',
        takeVehicle = vector3(-476.01, 6025.45, 31.34),
        zone = {
            shape = {
                vector2(-450.30178833008, 6041.40625),
                vector2(-460.90432739258, 6051.8706054688),
                vector2(-488.33441162109, 6024.427734375),
                vector2(-477.79156494141, 6013.8125)
            },
            minZ = 30.319950866699,
            maxZ = 32.319950866699,
        },
        spawnPoint = {
            vector4(-482.72, 6025.12, 30.95, 224.50),
            vector4(-479.62, 6027.75, 30.95, 223.10),
            vector4(-472.21, 6035.33, 30.95, 225.95),
            vector4(-461.14, 6047.44, 30.95, 137.41),
            vector4(-458.20, 6044.29, 30.95, 135.63)
        },
        showBlip = false,
        blipName = 'Sherrif',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = GarageConfig.VehicleClass['all'], --car, air, sea, rig
        job = 'bcso',
        jobType = 'leo'
    },
    ["Airport Garage"] = {
        label = 'Airport Hangar',
        takeVehicle = vector3(-979.06, -2995.48, 13.95),
        zone = {
            shape = {
                vector2(-988.62725830078, -3000.5405273438),
                vector2(-979.84320068359, -2984.6083984375),
                vector2(-969.06640625, -2990.7717285156),
                vector2(-977.34497070312, -3006.4653320312)
            },
            minZ = 11.019950866699,
            maxZ = 15.019950866699,
        },
        spawnPoint = {
            vector4(-978.15, -2990.34, 13.32, 65.44),
            vector4(-984.54, -2999.84, 13.32, 58.77)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['air']
    },
    ["Helitours Garage"] = {
        label = 'Higgins Helitours',
        takeVehicle = vector3(-722.15, -1472.79, 5.0),
        zone = {
            shape = {
                vector2(-758.50836181641, -1469.9782714844),
                vector2(-744.5380859375, -1481.6302490234),
                vector2(-712.20745849609, -1443.2182617188),
                vector2(-725.38098144531, -1431.7524414062)
            },
            minZ = 3.019950866699,
            maxZ = 7.019950866699,
        },
        spawnPoint = {
            vector4(-745.22, -1468.72, 5.39, 319.84),
            vector4(-724.36, -1443.61, 5.39, 135.78)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['air']
    },
    ["Airport Garage Sandy"] = {
        label = 'Sandy Shores Hangar',
        takeVehicle = vector3(1737.89, 3288.13, 41.14),
        zone = {
            shape = {
                vector2(1751.0200195312, 3253.6936035156),
                vector2(1748.1513671875, 3282.5402832031),
                vector2(1728.4143066406, 3281.9548339844),
                vector2(1730.5595703125, 3249.611328125)
            },
            minZ = 40.019950866699,
            maxZ = 42.019950866699,
        },
        spawnPoint = {
            vector4(1742.83, 3266.83, 41.24, 102.64)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['air']
    },
    ["Air Depot"] = {
        label = 'Air Depot',
        takeVehicle = vector3(-1270.01, -3377.53, 14.33),
        zone = {
            shape = {
                vector2(-1248.9865722656, -3380.0737304688),
                vector2(-1274.2775878906, -3364.365234375),
                vector2(-1285.97265625, -3381.6142578125),
                vector2(-1263.0495605469, -3394.4047851562)
            },
            minZ = 11.019950866699,
            maxZ = 14.019950866699,
        },
        spawnPoint = {
            vector4(-1270.01, -3377.53, 14.33, 329.25)
        },
        showBlip = true,
        blipName = 'Air Depot',
        blipNumber = 359,
        blipColor = 0,
        type = 'depot',
        category = GarageConfig.VehicleClass['air']
    },
    ["LSYMC Boathouse"] = {
        label = 'LSYMC Boathouse',
        takeVehicle = vector3(-785.95, -1497.84, -0.09),
        zone = {
            shape = {
                vector2(-787.84265136719, -1492.4404296875),
                vector2(-811.28533935547, -1501.3481445312),
                vector2(-806.55834960938, -1513.0714111328),
                vector2(-782.34558105469, -1504.1981201172)
            },
            minZ = -1.5019950866699,
            maxZ = 1.019950866699,
        },
        spawnPoint = {
            vector4(-796.64, -1502.6, -0.09, 111.49)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['sea']
    },
    ["Paleto Boathouse"] = {
        label = 'Paleto Boathouse',
        takeVehicle = vector3(-278.21, 6638.13, 7.55),
        zone = {
            shape = {
                vector2(-286.16806030273, 6631.56640625),
                vector2(-299.78063964844, 6642.90625),
                vector2(-284.54107666016, 6663.482421875),
                vector2(-269.02484130859, 6649.4760742188)
            },
            minZ = -1.5019950866699,
            maxZ = 1.019950866699,
        },
        spawnPoint = {
            vector4(-289.2, 6637.96, 1.01, 45.5)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['sea']
    },
    ["Millars BoatHouse"] = {
        label = 'Millars Boathouse',
        takeVehicle = vector3(1298.56, 4212.42, 33.25),
        zone = {
            shape = {
                vector2(1310.8342285156, 4211.5859375),
                vector2(1306.1059570312, 4191.7177734375),
                vector2(1287.3016357422, 4191.6162109375),
                vector2(1287.2047119141, 4217.548828125)
            },
            minZ = 27.5019950866699,
            maxZ = 30.019950866699,
        },
        spawnPoint = {
            vector4(1297.82, 4209.61, 30.12, 253.5)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = GarageConfig.VehicleClass['sea']
    },
    ["LSYMC Depot"] = {
        label = 'LSYMC Depot',
        takeVehicle = vector3(-742.95, -1407.58, 5.5),
        zone = {
            shape = {
                vector2(-725.28265380859, -1338.3333740234),
                vector2(-710.76458740234, -1350.0482177734),
                vector2(-725.02581787109, -1366.4116210938),
                vector2(-737.95306396484, -1356.6075439453)
            },
            minZ = -1.5019950866699,
            maxZ = 1.019950866699,
        },
        spawnPoint = {
            vector4(-729.77, -1355.49, 1.19, 142.5)
        },
        showBlip = true,
        blipName = 'LSYMC Depot',
        blipNumber = 356,
        blipColor = 0,
        type = 'depot',
        category = GarageConfig.VehicleClass['sea']
    },
}
