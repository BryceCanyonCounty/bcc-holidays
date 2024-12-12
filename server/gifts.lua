
local Core = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()

if Config.GiftboxesAvailable == true then
    if Config.Devmode == true then
        RegisterServerEvent("bccwintergifts:add")
        AddEventHandler("bccwintergifts:add", function(x, y, z)
            local edata = LoadResourceFile(GetCurrentResourceName(), "./gifts.json")
            local datas = json.decode(edata)
            local gift = {
                id = #datas + 1,
                coords = {
                    x = x,
                    y = y,
                    z = z
                },
                active = true
            }

            datas[#datas + 1] = gift
            SaveResourceFile(GetCurrentResourceName(), "./gifts.json", json.encode(datas))
            TriggerClientEvent("bccwintergifts:send", -1, datas)
        end)
    end


    if Config.ResetGiftsOnRestart then
        local edata = LoadResourceFile(GetCurrentResourceName(), "./gifts.json")
        local gifts = json.decode(edata)

        for index, storedgift in ipairs(gifts) do
            storedgift.active = true
        end

        SaveResourceFile(GetCurrentResourceName(), "./gifts.json", json.encode(gifts))
        TriggerClientEvent("bccwintergifts:send", -1, gifts)
    end

    RegisterServerEvent("bccwintergifts:collect")
    AddEventHandler("bccwintergifts:collect", function(gift)
        local _source = source
        TriggerClientEvent("bccwintergifts:remove", -1, gift)

        local edata = LoadResourceFile(GetCurrentResourceName(), "./gifts.json")
        local gifts = json.decode(edata)
        local found = false

        for index, storedgift in ipairs(gifts) do
            if storedgift.id == gift.id then
                found = true
                storedgift.active = false
                break
            end
        end

        SaveResourceFile(GetCurrentResourceName(), "./gifts.json", json.encode(gifts))

        if found == true then
            local randomIndex = math.random(1, #Config.GiftableItems)
            local giftedItem = Config.GiftableItems[randomIndex]
            local giftedQuantity = math.random(giftedItem.quantity.min, giftedItem.quantity.max)
            exports.vorp_inventory:addItem(_source, giftedItem.item, giftedQuantity)
            Core.NotifyAvanced(source, _U('holidayGiftReceived') .. giftedItem.itemLabel .. ' x' .. giftedQuantity, giftedItem.itemTextureDict, giftedItem.itemTexturehashname, giftedItem.itemTextureColor, 4000)
        end
    end)

    RegisterServerEvent("bccwintergifts:get")
    AddEventHandler("bccwintergifts:get", function(cb)
        local _source = source
        local edata = LoadResourceFile(GetCurrentResourceName(), "./gifts.json")
        local datas = json.decode(edata)
        TriggerClientEvent("bccwintergifts:send", _source, datas)
    end)
end

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-holidays')
