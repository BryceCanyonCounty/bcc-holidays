if Config.DisplayItemActive == true then
    if Config.Devmode == true then
        RegisterServerEvent("bccwinterdisplayitem:add")
        AddEventHandler("bccwinterdisplayitem:add", function(x, y, z)
            local edata = LoadResourceFile(GetCurrentResourceName(), "./displayitems.json")
            local datas = json.decode(edata)
            datas[#datas + 1] = {
                x = x,
                y = y,
                z = z
            }
            SaveResourceFile(GetCurrentResourceName(), "./displayitems.json", json.encode(datas))
        end)
    end
end