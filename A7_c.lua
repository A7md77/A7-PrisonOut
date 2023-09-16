local QBCore = exports[Config.core]:GetCoreObject()

-- ما اسامح اي شخص يحذف البرنت

print("^6A7 PrisonOut^7 - By : ^7A7store - ^6discord.gg/vvShNG4WYf")


RegisterNetEvent('A7-PrisonOut:out')
AddEventHandler('A7-PrisonOut:out' , function()
    exports[Config.dispatch]:CustomAlert({
        coords = GetEntityCoords(PlayerPedId()),
        message = "Prison Hacking",
        dispatchCode = "10-25",
        description = "Prison Hacking",
        radius = 0,
        sprite = 238,
        color = 1,
        scale = 1.0,
        length = 3,
    })
    exports[Config.ui]:Thermite(function(success)
        if success then
            TriggerServerEvent('qb-doorlock:server:updateState', 'out--904036698', false, false, false, true, false, false)
            QBCore.Functions.Notify("Door is Open , You have "..Config.time.."s", "error")
            Wait(Config.time * 1000)
            TriggerServerEvent('qb-doorlock:server:updateState', "out--904036698", true, true, true, true)
        else
            QBCore.Functions.Notify("Hacking Fail..", "error")
        end
    end, 15, 7, 5) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
end)


exports[Config.target]:AddBoxZone("out", vector3(1627.61, 2588.22, 45.56), 2.5, 2.5, {
    name = "out",
    heading = 30.0,
    debugPoly = false,
}, {
    options = {
        {
            type = "client",
            event = "A7-PrisonOut:out",
            icon = "fas fa-box",
            label = "Lets Go Out"
        },
    },
    distance = 1.5
})

exports[Config.target]:AddBoxZone("MotorCycle", vector3(1629.41, 2584.12, 39.4), 0.5, 0.5, {
    name = "MotorCycle",
    heading = 30.0,
    debugPoly = false,
}, {
    options = {
        {
            type = "client",
            event = "A7-PrisonOut:MotorCycle",
            icon = "fas fa-box",
            label = "Rent MotorCycle"
        },
    },
    distance = 1.5
})


RegisterNetEvent('A7-PrisonOut:MotorCycle', function()
    exports[Config.menu]:openMenu({
        {
            header = "Rental MotorCycle",
            isMenuHeader = true,
        },
        {
            id = 1,
            header = "MotorCycle",
            txt = "Go and spread corruption",
            params = {
                event = "A7-PrisonOut:spawncar",
                args = {
                    model = 'bati',
                }
            }
        },
    })
end)

RegisterNetEvent('A7-PrisonOut:spawncar')
AddEventHandler('A7-PrisonOut:spawncar', function(data)
    local model = data.model
    local player = PlayerPedId()
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        SetEntityHeading(vehicle, 352.51)
        TaskWarpPedIntoVehicle(player, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
        SpawnVehicle = true
    end, vector4(1628.2, 2586.55, 39.4, 348.47), true)
    Wait(1000)
    local vehicle = GetVehiclePedIsIn(player, false)
    local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    vehicleLabel = GetLabelText(vehicleLabel)
    local plate = GetVehicleNumberPlateText(vehicle)
    SetVehicleColours(vehicle, 147, 147)
end)

function CreateNPC(type, model, anim, dict, pos, help)
    Citizen.CreateThread(function()
        local hash = GetHashKey(model)
        local talking = false
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(1)
        end
        RequestAnimDict(anim)
        while not HasAnimDictLoaded(anim) do
            Wait(1)
        end
        local ped = CreatePed(type, hash, pos.x, pos.y, pos.z, pos.h, false, true)
        SetEntityHeading(ped, pos.h)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, anim, dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        while true do
            Citizen.Wait(0)
            local your = GetEntityCoords(GetPlayerPed(-1), false)
            if (Vdist(pos.x, pos.y, pos.z, your.x, your.y, your.z) < 2) and help ~= nil then
                SetTextComponentFormat("STRING")
                AddTextComponentString(help)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            end
        end
    end)
end

CreateNPC(4, "s_m_y_prismuscl_01", "amb@code_human_in_car_mp_actions@first_person@smoke@std@ds@base", "base", -- رسبتة البوت
    { x = 1629.45, y = 2584.09, z = 38.4, h = 140.66 }, "")

