RWR      			  = {}

RWR.PlayerLoaded	  = false
RWR.PlayerData 	  = {}
RWR.CurrentRequestId = 0
RWR.ServerCallbacks  = {}

RWR.Game   		  = {}
RWR.Utils  		  = {}
RWR.Streaming  	  = {}

AddEventHandler('RWRCore:getSharedObject', function(cb)
	cb(RWR)
end)

-- RegisterNetEvent("RWRCore:playerLoaded")
-- AddEventHandler("RWRCore:playerLoaded", function()
-- 	RWR.PlayerData["isBusy"] = false -- Kişi müsait mi, etkileşime girebilir mi? || Is player busy, is he/she can interact?

-- 	Citizen.Wait(250)
-- 	RWR.PlayerLoaded = true
-- end)

-- Citizen.CreateThread(function() -- After load
-- 	TriggerEvent("RWRCore:playerLoaded")
-- end)

function getSharedObject()
	return RWR
end

RWR.GetPlayerData = function()
	return RWR.PlayerData
end

RWR.SetPlayerData = function(data, val)
	RWR.PlayerData[data] = val
end

RWR.GetPlayerServerId = function()
	return GetPlayerServerId(PlayerId())
end

RWR.TriggerServerCallback = function(name, cb, ...)
	RWR.ServerCallbacks[RWR.CurrentRequestId] = cb

	TriggerServerEvent('RWRCore:triggerServerCallback', name, RWR.CurrentRequestId, ...)

	if RWR.CurrentRequestId < 65535 then
		RWR.CurrentRequestId = RWR.CurrentRequestId + 1
	else
		RWR.CurrentRequestId = 0
	end
end

RWR.Streaming.LoadModel = function(hash)
	if Config.Debug then return print(_U("RWR_R_M_HASH").. ''.. hash) end
	model = GetHashKey(hash)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end

	return model
end

RWR.Streaming.LoadAnimDict = function(dict, cb)
	if Config.Debug then return print(_U("RWR_R_A_DICT").. ''.. dict) end
	while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
	end
	
	if cb ~= nil then
		cb()
	end
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

RWR.DrawText3D = function(x, y, z, text, scale) -- Font ve arkaplan değiştirildi. || Changed font and rect
	SetTextScale(0.30, 0.30)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 15, 16, 17, 100)
end

RWR.DrawSubtitle = function(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

RWR.Game.Teleport = function(fadeTime, x, y, z, h, cb)
	local ply = GetPlayerServerId(PlayerId())
	local entity = GetPlayerFromServerId(ply)

	DoScreenFadeOut(fadeTime)
	Citizen.Wait(fadeTime)
	
	StartPlayerTeleport(entity, x, y, z, h, false, true, false)
	
	Citizen.Wait(fadeTime)
	DoScreenFadeIn(fadeTime)

	if cb ~= nil then
		cb()
	end
end

RegisterNetEvent('RWRCore:serverCallback')
AddEventHandler('RWRCore:serverCallback', function(requestId, ...)
	RWR.ServerCallbacks[requestId](...)
	RWR.ServerCallbacks[requestId] = nil
end)


RWR.GetClosestVehicle = function(coords)
	local vehicles        = QBCore.Functions.GetVehicles()
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

RWR.DeleteVehicle = function(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

RWR.KoordinatiCek = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        a = heading
    }
end