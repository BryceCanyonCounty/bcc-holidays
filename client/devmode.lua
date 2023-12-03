local edit = false
local camcoords = nil

local function GetCoordsFromCam (distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local function PlayerTarget ()
    local Cam = GetGameplayCamCoord()
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4)
    local _, Hit, Coords, _, Entity = GetShapeTestResult(handle)
    local x, y, z = table.unpack(Coords)

    camcoords = Coords
    Citizen.InvokeNative(0x2A32FAA57B937173, 0x50638AB9, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.15, 93, 17, 100, 255, false, false, 2, false, false)
end

Citizen.CreateThread(function()
        while true do
            if edit == true then
                PlayerTarget()
            end
            Citizen.Wait(0)
        end
end)

RegisterCommand("setdisplayitem", function(source, args, rawCommand)
    if edit == true then
        TriggerServerEvent("bccwinterdisplayitem:add", table.unpack(camcoords))
    end

    edit = true
end)

RegisterCommand("setgiftbox", function(source, args, rawCommand)
    if edit == true then
        print('Gift Location Saved!')
        TriggerServerEvent("bccwintergifts:add", table.unpack(camcoords))
    end

    edit = true
end)

function Dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. Dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
 