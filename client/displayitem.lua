if Config.DisplayItemActive == true then
    local BccUtils = exports['bcc-utils'].initiate()
    
    RegisterNetEvent("vorp:SelectedCharacter")
    AddEventHandler("vorp:SelectedCharacter", function(charid)
        Wait(1000)
        for k, displayitem in pairs(Config.DisplayItemLocations) do
            local ditem = BccUtils.Object:Create(Config.DisplayItemModel, displayitem.x, displayitem.y, displayitem.z, 0, true)
            ditem:SetAsMission()
            ditem:Freeze()
        end
    end)
end
