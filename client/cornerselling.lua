local cornerselling = false
local hasTarget = false
local startLocation = nil
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local policeMessage = {
    Lang:t("info.suspicious_situation"),
    Lang:t("info.possible_drug_dealing"),
}
local inCity = false

CurrentCops = 0

RegisterNetEvent('qb-drugs:client:cornerselling', function(data)
    QBCore.Functions.TriggerCallback('qb-drugs:server:cornerselling:getAvailableDrugs', function(result)
        if CurrentCops >= Config.MinimumDrugSalePolice then
            if inCity then
                if result ~= nil then
                    availableDrugs = result
                    if not cornerselling then
                        cornerselling = true
                        -- LocalPlayer.state:set("inv_busy", true, true)
                        QBCore.Functions.Notify(Lang:t("info.started_selling_drugs"))
                        startLocation = GetEntityCoords(PlayerPedId())
                    else
                        cornerselling = false
                        -- LocalPlayer.state:set("inv_busy", false, true)
                        QBCore.Functions.Notify(Lang:t("info.stopped_selling_drugs"))
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.has_no_drugs"), 'error')
                -- LocalPlayer.state:set("inv_busy", false, true)
                end
            else
                QBCore.Functions.Notify("你不能在這裡進行毒品交易", "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_enough_police", {polices = Config.MinimumDrugSalePolice}), "error")
        end
    end)
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
    if #availableDrugs <= 0 then
        QBCore.Functions.Notify(Lang:t("error.no_drugs_left"), 'error')
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
    end
end)

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 300
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function toFarAway()
    LocalPlayer.state:set("inv_busy", false, true)
    cornerselling = false
    hasTarget = false
    startLocation = nil
    availableDrugs = {}
    Wait(5000)
end

local function SellToPed(ped)
    hasTarget = true
    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end
    
    local succesChance = math.random(1, 20)
    
    local scamChance = math.random(1, 5)
    
    local getRobbed = math.random(1, 20)
    
    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, availableDrugs[drugType].amount)
    
    if bagAmount > 15 then
        bagAmount = math.random(9, 15)
    end
    
    currentOfferDrug = availableDrugs[drugType]
    
    local ddata = Config.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance == 5 then
        randomPrice = math.random(3, 10) * bagAmount
    end
    
    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)
    
    local coords = GetEntityCoords(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)
    
    if getRobbed == 18 or getRobbed == 9 then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end
    
    while pedDist > 1.5 do
        coords = GetEntityCoords(PlayerPedId(), true)
        pedCoords = GetEntityCoords(ped)
        if getRobbed == 18 or getRobbed == 9 then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        pedDist = #(coords - pedCoords)
        
        Wait(100)
    end
    
    TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    
    if hasTarget then
        while pedDist < 1.5 do
            coords = GetEntityCoords(PlayerPedId(), true)
            pedCoords = GetEntityCoords(ped)
            pedDist = #(coords - pedCoords)
            if getRobbed == 18 or getRobbed == 9 then
                TriggerServerEvent('qb-drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
                QBCore.Functions.Notify(Lang:t("info.has_been_robbed", {bags = bagAmount, drugType = availableDrugs[drugType].label}))
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    amount = bagAmount,
                }
                hasTarget = false
                local rand = (math.random(6, 9) / 100) + 0.3
                local rand2 = (math.random(6, 9) / 100) + 0.3
                if math.random(10) > 5 then
                    rand = 0.0 - rand
                end
                if math.random(10) > 5 then
                    rand2 = 0.0 - rand2
                end
                local moveto = GetEntityCoords(PlayerPedId())
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed + 1] = ped
                break
            else
                if pedDist < 1.5 and cornerselling then
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Lang:t("info.drug_offer", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice}))
                    if IsControlJustPressed(0, 38) then
                        QBCore.Functions.Progressbar('sellCornerDrugs', '交易中...', 3000, false, false, {-- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = 'anim@heists@box_carry@',
                            anim = 'idle',
                            flags = 16,
                        }, {
                            model = "hei_prop_heist_box",
                            bone = 60309,
                            coords = { x = 0.025, y = 0.08, z = 0.255 },
                            rotation = { x = -145.0, y = 290.0, z = 0.0 }
                        }, {}, function()-- Play When Done
                            --Stuff goes here
                            if succesChance <= 10 then
                                hasTarget = false
                                if math.random(0, 1) == 1 then
                                    exports["qb-dispatch"]:DrugSale()
                                end
                                QBCore.Functions.Notify('顯然這筆交易破局了', 'error', 3000)
                                ClearPedTasks(PlayerPedId())
                                
                                SetPedKeepTask(ped, false)
                                SetEntityAsNoLongerNeeded(ped)
                                ClearPedTasksImmediately(ped)
                                lastPed[#lastPed + 1] = ped
                            elseif succesChance > 10 then
                                if math.random(0, 1) == 1 then
                                    exports["qb-dispatch"]:DrugSale()
                                end
                                TriggerServerEvent('qb-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
                                hasTarget = false
                                Wait(650)
                                ClearPedTasks(PlayerPedId())
                                
                                SetPedKeepTask(ped, false)
                                SetEntityAsNoLongerNeeded(ped)
                                ClearPedTasksImmediately(ped)
                                lastPed[#lastPed + 1] = ped
                            end
                        end, function()-- Play When Cancel
                        --Stuff goes here
                        end)
                        break
                    end
                    
                    if IsControlJustPressed(0, 47) then
                        hasTarget = false
                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        lastPed[#lastPed + 1] = ped
                        break
                    end
                else
                    hasTarget = false
                    pedDist = 5
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    lastPed[#lastPed + 1] = ped
                -- cornerselling = false
                end
            end
            Wait(3)
        end
        Wait(math.random(4000, 7000))
    end
end

CreateThread(function()
    while true do
        sleep = 1000
        if stealingPed ~= nil and stealData ~= nil then
            sleep = 0
            if IsEntityDead(stealingPed) then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local pedpos = GetEntityCoords(stealingPed)
                if #(pos - pedpos) < 1.5 then
                    DrawText3D(pedpos.x, pedpos.y, pedpos.z, Lang:t("info.pick_up_button"))
                    if IsControlJustReleased(0, 38) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Wait(0)
                        end
                        TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
                        Wait(2000)
                        ClearPedTasks(ped)
                        TriggerServerEvent("QBCore:Server:AddItem", stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        if cornerselling then
            sleep = 0
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if not hasTarget then
                local PlayerPeds = {}
                if next(PlayerPeds) == nil then
                    for _, player in ipairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(player)
                        PlayerPeds[#PlayerPeds + 1] = ped
                    end
                end
                local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
                if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) and not IsPedInAnyVehicle(player) and GetPedType(closestPed) ~= 28 then
                    SellToPed(closestPed)
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local saleDrugZone = PolyZone:Create({
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
    }, {
        name = "saledrugzone",
        minZ = 0,
        maxZ = 800,
        debugGrid = false,
    })
    saleDrugZone:onPlayerInOut(function(isPointInside, _)
        if isPointInside then
            inCity = true
        else
            inCity = false
            toFarAway()
        end
    end)
end)
