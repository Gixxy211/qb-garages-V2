local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local PlayerGang = {}
local PlayerJob = {}
local garageZones = {}
local listenForKey = false

-- Functions

local function round(num, numDecimalPlaces)
    return tonumber(string.format('%.' .. (numDecimalPlaces or 0) .. 'f', num))
end

local function CheckPlayers(vehicle)
    for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(vehicle, i)
        if seat then
            TaskLeaveVehicle(seat, vehicle, 0)
        end
    end
    Wait(1500)
    QBCore.Functions.DeleteVehicle(vehicle)
end

local function OpenGarageMenu(data)
    QBCore.Functions.TriggerCallback('qb-garages:server:GetGarageVehicles', function(result)
        if result == nil then return QBCore.Functions.Notify(Lang:t('error.no_vehicles'), 'error', 5000) end
        local formattedVehicles = {}
        for _, v in pairs(result) do
            local enginePercent = round(v.engine, 0)
            local bodyPercent = round(v.body, 0)
            local vname = nil
            pcall(function()
                vname = QBCore.Shared.Vehicles[v.vehicle].name
            end)

            local logs = {}
            if v.logs and v.logs ~= '' then
                local decoded = json.decode(v.logs)
                if type(decoded) == 'table' then
                    logs = decoded
                    table.sort(logs, function(a, b) return a.time > b.time end)
                end
            end

            formattedVehicles[#formattedVehicles + 1] = {
                vehicle = v.vehicle,
                vehicleLabel = vname or v.vehicle,
                plate = v.plate,
                state = v.state,
                fuel = v.fuel,
                engine = enginePercent,
                body = bodyPercent,
                distance = v.drivingdistance or 0,
                garage = GarageConfig.Garages[data.indexgarage],
                type = data.type,
                index = data.indexgarage,
                depotPrice = v.depotprice or 0,
                balance = v.balance or 0,
                logs = logs
            }
        end

        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'GarageVehicleList',
            garageLabel = GarageConfig.Garages[data.indexgarage].label,
            vehicles = formattedVehicles,
            vehNum = #formattedVehicles,
            resourceName = GetCurrentResourceName(),
            garageType = data.type,
            useCarImg = true
        })
    end, data.indexgarage, data.type, data.category)
end

local function DepositVehicle(veh, data)
    local plate = QBCore.Functions.GetPlate(veh)
    QBCore.Functions.TriggerCallback('qb-garages:server:canDeposit', function(canDeposit)
        if canDeposit then
            local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
            local engineDamage = math.ceil(GetVehicleEngineHealth(veh))
            local totalFuel = exports[GarageConfig.FuelResource]:GetFuel(veh)
            local vehicleProperties = QBCore.Functions.GetVehicleProperties(veh)
            
            TriggerServerEvent('qb-garages:server:updateVehicleProperties', plate, vehicleProperties)
            TriggerServerEvent('qb-garages:server:updateVehicleStats', plate, totalFuel, engineDamage, bodyDamage)
            
            CheckPlayers(veh)
            if plate then TriggerServerEvent('qb-garages:server:UpdateOutsideVehicle', plate, nil) end
            QBCore.Functions.Notify(Lang:t('success.vehicle_parked'), 'primary', 4500)
        else
            QBCore.Functions.Notify(Lang:t('error.not_owned'), 'error', 3500)
        end
    end, plate, data.type, data.indexgarage, 1)
end

local function IsVehicleAllowed(classList, vehicle)
    if not GarageConfig.ClassSystem then return true end
    for _, class in ipairs(classList) do
        if GetVehicleClass(vehicle) == class then
            return true
        end
    end
    return false
end

local function CreateBlips(setloc)
    local Garage = AddBlipForCoord(setloc.takeVehicle.x, setloc.takeVehicle.y, setloc.takeVehicle.z)
    SetBlipSprite(Garage, setloc.blipNumber)
    SetBlipDisplay(Garage, 4)
    SetBlipScale(Garage, 0.60)
    SetBlipAsShortRange(Garage, true)
    SetBlipColour(Garage, 48) 
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(setloc.blipName)
    EndTextCommandSetBlipName(Garage)
end

local function CreateZone(index, garage, zoneType)
    local zone = PolyZone:Create(garage.zone.shape, {
        name = zoneType .. '_' .. index,
        minZ = garage.zone.minZ,
        maxZ = garage.zone.maxZ,
        debugPoly = false,
        data = {
            indexgarage = index,
            type = garage.type,
            category = garage.category
        }
    })
    return zone
end

local function CreateBlipsZones()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job

    for index, garage in pairs(GarageConfig.Garages) do
        local zone
        if garage.showBlip then
            CreateBlips(garage)
        end
        if garage.type == 'job' and (PlayerJob.name == garage.job or PlayerJob.type == garage.jobType) then
            zone = CreateZone(index, garage, 'job')
        elseif garage.type == 'gang' and PlayerGang.name == garage.job then
            zone = CreateZone(index, garage, 'gang')
        elseif garage.type == 'depot' then
            zone = CreateZone(index, garage, 'depot')
        elseif garage.type == 'public' then
            zone = CreateZone(index, garage, 'public')
        end

        if zone then
            garageZones[#garageZones + 1] = zone
        end
    end

    local comboZone = ComboZone:Create(garageZones, { name = 'garageCombo', debugPoly = false })

    comboZone:onPlayerInOut(function(isPointInside, _, zone)
        if isPointInside then
            listenForKey = true
            CreateThread(function()
                while listenForKey do
                    Wait(0)
                    if IsControlJustReleased(0, 38) then
                        if GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
                            if zone.data.type == 'depot' then return end
                            local currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
                            if not IsVehicleAllowed(zone.data.category, currentVehicle) then
                                QBCore.Functions.Notify(Lang:t('error.not_correct_type'), 'error', 3500)
                                return
                            end
                            DepositVehicle(currentVehicle, zone.data)
                        else
                            OpenGarageMenu(zone.data)
                        end
                    end
                end
            end)

            local displayText = Lang:t('info.car_e')
            if zone.data.vehicle == 'sea' then
                displayText = Lang:t('info.sea_e')
            elseif zone.data.vehicle == 'air' then
                displayText = Lang:t('info.air_e')
            elseif zone.data.vehicle == 'rig' then
                displayText = Lang:t('info.rig_e')
            elseif zone.data.type == 'depot' then
                displayText = Lang:t('info.depot_e')
            end
            exports["karma-interaction"]:showInteraction('E', displayText)
        else
            listenForKey = false
            exports["karma-interaction"]:hideInteraction()
        end
    end)
end

local function doCarDamage(currentVehicle, stats, props)
    local engine = stats.engine + 0.0
    local body = stats.body + 0.0
    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)
    if not next(props) then return end
    if props.doorStatus then
        for k, v in pairs(props.doorStatus) do
            if v then SetVehicleDoorBroken(currentVehicle, tonumber(k), true) end
        end
    end
    if props.tireBurstState then
        for k, v in pairs(props.tireBurstState) do
            if v then SetVehicleTyreBurst(currentVehicle, tonumber(k), true) end
        end
    end
    if props.windowStatus then
        for k, v in pairs(props.windowStatus) do
            if not v then SmashVehicleWindow(currentVehicle, tonumber(k)) end
        end
    end
end

function GetSpawnPoint(garage)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local closest = nil
    local closestDist = math.huge

    for i = 1, #garage.spawnPoint do
        local sp = garage.spawnPoint[i]
        local isOccupied = IsPositionOccupied(
            sp.x, sp.y, sp.z,
            5.0,   -- range
            false,
            true,  -- checkVehicles
            false, -- checkPeds
            false,
            false,
            0,
            false
        )

        if not isOccupied then
            local dist = #(playerPos - vector3(sp.x, sp.y, sp.z))
            if dist < closestDist then
                closestDist = dist
                closest = sp
            end
        end
    end

    if not closest then
        QBCore.Functions.Notify(Lang:t('error.vehicle_occupied'), 'error')
    end

    return closest
end

-- NUI Callbacks

RegisterNUICallback('garageCallback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
    elseif data.action == "takeOutVehicle" then
        TriggerEvent('qb-garages:client:takeOutGarage', data.data)
    elseif data.action == "trackVehicle" then
        TriggerServerEvent('qb-garages:server:trackVehicle', data.plate)
    elseif data.action == "takeOutDepo" then
        local depotPrice = data.depotPrice
        if depotPrice ~= 0 then
            TriggerServerEvent('qb-garages:server:PayDepotPrice', data.data)
        else
            TriggerEvent('qb-garages:client:takeOutGarage', data.data)
        end
    end
end)

-- RegisterNUICallback('closeGarage', function(_, cb)
--     SetNuiFocus(false, false)
--     cb('ok')
-- end)

-- RegisterNUICallback('takeOutVehicle', function(data, cb)
--     TriggerEvent('qb-garages:client:takeOutGarage', data)
--     cb('ok')
-- end)

-- RegisterNUICallback('trackVehicle', function(plate, cb)
--     TriggerServerEvent('qb-garages:server:trackVehicle', plate)
--     cb('ok')
-- end)

-- RegisterNUICallback('takeOutDepo', function(data, cb)
--     local depotPrice = data.depotPrice
--     if depotPrice ~= 0 then
--         TriggerServerEvent('qb-garages:server:PayDepotPrice', data)
--     else
--         TriggerEvent('qb-garages:client:takeOutGarage', data)
--     end
--     cb('ok')
-- end)

-- Events

RegisterNetEvent('qb-garages:client:trackVehicle', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)

local function CheckPlate(vehicle, plateToSet)
    local vehiclePlate = promise.new()
    CreateThread(function()
        while true do
            Wait(500)
            if GetVehicleNumberPlateText(vehicle) == plateToSet then
                vehiclePlate:resolve(true)
                return
            else
                SetVehicleNumberPlateText(vehicle, plateToSet)
            end
        end
    end)
    return vehiclePlate
end

RegisterNetEvent('qb-garages:client:takeOutGarage', function(data)
    QBCore.Functions.TriggerCallback('qb-garages:server:IsSpawnOk', function(spawn)
        if spawn then
            local location = GetSpawnPoint(GarageConfig.Garages[data.index])
            if not location then return end

            QBCore.Functions.TriggerCallback('qb-garages:server:spawnvehicle', function(netId, properties, vehPlate)
                while not NetworkDoesNetworkIdExist(netId) do Wait(10) end

                local veh = NetworkGetEntityFromNetworkId(netId)
                Citizen.Await(CheckPlate(veh, vehPlate))
                
                -- Apply the saved properties to the vehicle
                if properties and next(properties) then
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                end
                
                exports[GarageConfig.FuelResource]:SetFuel(veh, data.stats.fuel)
                TriggerServerEvent('qb-garages:server:updateVehicleState', 0, vehPlate)
                TriggerEvent('vehiclekeys:client:SetOwner', vehPlate)

                -- Trigger Bennys integration
                TriggerServerEvent('karma-bennys:setVehicleProperties', veh, vehPlate)

                if GarageConfig.Warp then
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                end

                if GarageConfig.VisuallyDamageCars then
                    doCarDamage(veh, data.stats, properties)
                end

                SetVehicleEngineOn(veh, true, true, false)

                if data.type == "depot" then
                    TriggerServerEvent('qb-garages:addGarageLog:server', {
                        plate = vehPlate,
                        garage = GarageConfig.Garages[data.index].label,
                        type = "Take Depot"
                    })
                else
                    TriggerServerEvent('qb-garages:addGarageLog:server', {
                        plate = vehPlate,
                        garage = GarageConfig.Garages[data.index].label,
                        type = "Take Out"
                    })
                end
            end, data.plate, data.vehicle, location, true)
        else
            QBCore.Functions.Notify(Lang:t('error.not_depot'), 'error', 5000)
        end
    end, data.plate, data.type)
end)

-- Housing calls

local houseGarageZones = {}
local listenForKeyHouse = false
local houseComboZones = nil

local function CreateHouseZone(index, garage, zoneType)
    local houseZone = CircleZone:Create(garage.takeVehicle, 5.0, {
        name = zoneType .. '_' .. index,
        debugPoly = false,
        useZ = true,
        data = {
            indexgarage = index,
            type = zoneType,
            category = garage.category
        }
    })

    if houseZone then
        houseGarageZones[#houseGarageZones + 1] = houseZone

        if not houseComboZones then
            houseComboZones = ComboZone:Create(houseGarageZones, { name = 'houseComboZones', debugPoly = false })
        else
            houseComboZones:AddZone(houseZone)
        end
    end

    houseComboZones:onPlayerInOut(function(isPointInside, _, zone)
        if isPointInside then
            listenForKeyHouse = true
            CreateThread(function()
                while listenForKeyHouse do
                    Wait(0)
                    if IsControlJustReleased(0, 38) then
                        if GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
                            local currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
                            DepositVehicle(currentVehicle, zone.data)
                        else
                            OpenGarageMenu(zone.data)
                        end
                    end
                end
            end)
            exports["karma-interaction"]:showInteraction('E', Lang:t('info.house_garage'))
            --exports['qb-core']:DrawText(Lang:t('info.house_garage'), 'left')
        else
            listenForKeyHouse = false
            exports["karma-interaction"]:hideInteraction()
            --exports['qb-core']:HideText()
        end
    end)
end

local function ZoneExists(zoneName)
    for _, zone in ipairs(houseGarageZones) do
        if zone.name == zoneName then
            return true
        end
    end
    return false
end

local function RemoveHouseZone(zoneName)
    local removedZone = houseComboZones:RemoveZone(zoneName)
    if removedZone then
        removedZone:destroy()
    end
    for index, zone in ipairs(houseGarageZones) do
        if zone.name == zoneName then
            table.remove(houseGarageZones, index)
            break
        end
    end
end

RegisterNetEvent('qb-garages:client:setHouseGarage', function(house, hasKey) -- event sent periodically from housing
    if not house then return end
    local formattedHouseName = string.gsub(string.lower(house), ' ', '')
    local zoneName = 'house_' .. formattedHouseName
    if GarageConfig.Garages[formattedHouseName] then
        if hasKey and not ZoneExists(zoneName) then
            CreateHouseZone(formattedHouseName, GarageConfig.Garages[formattedHouseName], 'house')
        elseif not hasKey and ZoneExists(zoneName) then
            RemoveHouseZone(zoneName)
        end
    else
        QBCore.Functions.TriggerCallback('qb-garages:server:getHouseGarage', function(garageInfo) -- create garage if not exist
            local garageCoords = json.decode(garageInfo.garage)
            GarageConfig.Garages[formattedHouseName] = {
                houseName = house,
                takeVehicle = vector3(garageCoords.x, garageCoords.y, garageCoords.z),
                spawnPoint = {
                    vector4(garageCoords.x, garageCoords.y, garageCoords.z, garageCoords.w or garageCoords.h)
                },
                label = garageInfo.label,
                type = 'house',
                category = GarageConfig.VehicleClass['all']
            }
            TriggerServerEvent('qb-garages:server:syncGarage', GarageConfig.Garages)
        end, house)
    end
end)

RegisterNetEvent('qb-garages:client:houseGarageGarageConfig', function(houseGarages)
    for _, garageGarageConfig in pairs(houseGarages) do
        local formattedHouseName = string.gsub(string.lower(garageGarageConfig.label), ' ', '')
        if garageGarageConfig.takeVehicle and garageGarageConfig.takeVehicle.x and garageGarageConfig.takeVehicle.y and garageGarageConfig.takeVehicle.z and garageGarageConfig.takeVehicle.w then
            GarageConfig.Garages[formattedHouseName] = {
                houseName = house,
                takeVehicle = vector3(garageGarageConfig.takeVehicle.x, garageGarageConfig.takeVehicle.y, garageGarageConfig.takeVehicle.z),
                spawnPoint = {
                    vector4(garageGarageConfig.takeVehicle.x, garageGarageConfig.takeVehicle.y, garageGarageConfig.takeVehicle.z, garageGarageConfig.takeVehicle.w)
                },
                label = garageGarageConfig.label,
                type = 'house',
                category = GarageConfig.VehicleClass['all']
            }
        end
    end
    TriggerServerEvent('qb-garages:server:syncGarage', GarageConfig.Garages)
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo) -- event from housing on garage creation
    local formattedHouseName = string.gsub(string.lower(house), ' ', '')
    GarageConfig.Garages[formattedHouseName] = {
        houseName = house,
        takeVehicle = vector3(garageInfo.takeVehicle.x, garageInfo.takeVehicle.y, garageInfo.takeVehicle.z),
        spawnPoint = {
            vector4(garageInfo.takeVehicle.x, garageInfo.takeVehicle.y, garageInfo.takeVehicle.z, garageInfo.takeVehicle.w)
        },
        label = garageInfo.label,
        type = 'house',
        category = GarageConfig.VehicleClass['all']
    }
    TriggerServerEvent('qb-garages:server:syncGarage', GarageConfig.Garages)
end)

RegisterNetEvent('qb-garages:client:removeHouseGarage', function(house)
    local formattedHouseName = string.gsub(string.lower(house), ' ', '')
    local zoneName = 'house_' .. formattedHouseName
    RemoveHouseZone(zoneName)
    Config.Garages[formattedHouseName] = nil
end)

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    CreateBlipsZones()
end)

AddEventHandler('onResourceStart', function(res)
    if res ~= GetCurrentResourceName() then return end
    CreateBlipsZones()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)
