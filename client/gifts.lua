if Config.GiftboxesAvailable == true then
    local spawnedgifts = {}

    local BccUtils = exports['bcc-utils'].initiate()

    local function spawnGifts(gifts)
        local model = Config.GiftboxModel

        for k, gift in pairs(gifts) do
            if gift.active == true then
                local giftbox = BccUtils.Object:Create(model, gift.coords.x, gift.coords.y, gift.coords.z, 0, true)

                giftbox:SetAsMission()
                giftbox:Freeze()

                local giftboxObj = giftbox:GetObj()

                Citizen.InvokeNative(0x7DFB49BCDB73089A, giftboxObj, true) -- SetPickupLight

                spawnedgifts[k] = {
                    giftbox = giftbox,
                    data = gift,
                    active = true,
                    src = 'other',
                    lastPickupTime = 0, -- Initialize the timer
                    canPickup = true    -- Initialize pickup state
                }
            end
        end
    end

    local function clearGifts()
        for k, gift in ipairs(spawnedgifts) do
            gift.giftbox:Remove()
        end
        spawnedgifts = {}
    end

    RegisterNetEvent("vorp:SelectedCharacter")
    AddEventHandler("vorp:SelectedCharacter", function(charid)
        Wait(1000)
        TriggerServerEvent("bccwintergifts:get")
    end)

    if Config.Devmode == true then
        Citizen.CreateThread(function()
            Wait(1000)
            TriggerServerEvent("bccwintergifts:get")
        end)
    end

    RegisterNetEvent("bccwintergifts:send")
    AddEventHandler("bccwintergifts:send", function(gifts)
        Wait(1000)
        clearGifts()
        spawnGifts(gifts)
    end)

    RegisterNetEvent("bccwintergifts:remove")
    AddEventHandler("bccwintergifts:remove", function(gifts)
        for k, gift in ipairs(spawnedgifts) do
            if gifts.id == gift.data.id and gift.src == 'other' then
                gift.giftbox:Remove()
                gift = nil
            end
        end
    end)

    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == GetCurrentResourceName() then
            clearGifts()
        end
    end)

    Citizen.CreateThread(function()
        local PromptGroup = BccUtils.Prompt:SetupPromptGroup()
        local giftprompt = PromptGroup:RegisterPrompt(_U('holidayPromptPickup'), 0x4CC0E2FE, 1, 1, true, 'hold')

        while true do
            Citizen.Wait(0)
            local playerped = PlayerPedId()
            
            -- Skip processing if the player is dead
            if IsEntityDead(playerped) then
                Citizen.Wait(1000) -- Add delay to avoid constant checks
                goto continue
            end

            if spawnedgifts[1] ~= nil then
                local closest = {
                    dist = 99999999
                }
                local playerCoords = GetEntityCoords(playerped)

                for i, gift in pairs(spawnedgifts) do
                    local giftCoords = gift.data.coords
                    local dist = BccUtils.Math.GetDistanceBetween(
                        vector3(playerCoords.x, playerCoords.y, playerCoords.z),
                        vector3(giftCoords.x, giftCoords.y, giftCoords.z))
                    
                    if dist < Config.ViewDistance and gift.canPickup then
                        if dist <= closest.dist then
                            closest = {
                                dist = dist,
                                gift = gift
                            }

                            Citizen.InvokeNative(0x69F4BE8C8CC4796C, playerped, gift.giftbox:GetObj(), 3000, 2048, 3) -- TaskLookAtEntity

                            local currentTime = GetGameTimer()
                            if currentTime - gift.lastPickupTime >= Config.PickupCooldown then
                                PromptGroup:ShowGroup(_U('holidayPrompt'))
                                if giftprompt:HasCompleted() then
                                    gift.src = 'player'
                                    TriggerServerEvent("bccwintergifts:collect", gift.data)

                                    local animDict = "amb_rest@world_human_sketchbook_ground_pickup@male_a@react_look@exit@generic"
                                    RequestAnimDict(animDict)

                                    while not HasAnimDictLoaded(animDict) do
                                        Wait(10)
                                    end

                                    TaskPlayAnim(playerped, animDict, "react_look_front_exit", 1.0, 8.0, -1, 1, 0, false, false, false)
                                    Wait(2200)
                                    ClearPedTasks(playerped)
                                    gift.giftbox:Remove()
                                    gift.lastPickupTime = currentTime
                                    gift.canPickup = false

                                    CreateThread(function()
                                        Wait(Config.PickupCooldown)
                                        gift.canPickup = true
                                    end)

                                    closest = { dist = 99999999 }
                                end

                                if giftprompt:HasFailed() then
                                    print("[DEBUG] Gift prompt failed.")
                                end
                            end
                        end
                    end
                end
            end
            ::continue::
        end
    end)
end
