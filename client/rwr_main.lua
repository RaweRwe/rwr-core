RWR = {}
RWR.Streaming = {}
RWR.Functions = {}

AddEventHandler('RWRCore:getSharedObject', function(cb)
	cb(RWR)
end)

function getSharedObject()
	return RWR
end

RWR.Streaming.RequestAnimDict = function(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

---- Some Basic Code

RWR.Functions.GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

RWR.Functions.GetClosestVehicle = function(coords)
	local vehicles        = RWR.Functions.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle
end

RWR.Functions.DeleteVehicle = function(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

RWR.Functions.GetCoords = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        a = heading
    }
end

RWR.Functions.DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Bildirim / Notify

RegisterNetEvent('RWR:ShowNotification')
AddEventHandler('RWR:ShowNotification', function(text, color, textcolor, time)
    SendNUIMessage({
        shown = true,
        text = text,
        color = color,
        textcolor = textcolor, 
    })
    Citizen.Wait(time * 1000)
    HideNotify()
end)

function ShowNotify(text, color, textcolor, time)
    SendNUIMessage({
        shown = true,
        text = text,
        color = color,
        textcolor = textcolor, 
    })
    Citizen.Wait(time * 1000)
    HideNotify()
end

exports('ShowNotify', ShowNotify)

function HideNotify()
    SendNUIMessage({
        close_notify = true
    })
end

-- Interection

function ShowInteraction(text, color, textcolor)
    SendNUIMessage({
        showi = true,
        text = text,
        color = color,
        textcolor = textcolor, 
    })
end

exports('ShowInteraction', ShowInteraction)

function HideInteraction()
    SendNUIMessage({
        close_interaction = true
    })
end

exports('HideInteraction', HideInteraction)