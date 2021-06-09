--- this is the main update thread for pushing blip location updates to players
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local players = GetPlayers()
        local blips = {}
        for index, player in ipairs(players) do
            local playerPed = GetPlayerPed(player)
            if DoesEntityExist(playerPed) then
                local coords = GetEntityCoords(playerPed)
                blips[tostring(player)] = {
                    serverId = player, 
                    networkId = NetworkGetNetworkIdFromEntity(playerPed),
                    coords = { coords.x, coords.y, coords.z },
                    name = GetPlayerName(player),
                    ped = playerPed,
                }
            end
        end
        TriggerClientEvent("infinity:update", -1, blips)
    end
end)

RegisterServerEvent('infinity:player:ready')
AddEventHandler('infinity:player:ready', function()
    local coords = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('infinity:player:coords', -1, coords)
end)

RegisterServerEvent('infinity:entity:coords')
AddEventHandler('infinity:entity:coords', function(netId)
    local coords = GetEntityCoords(GetPlayerPed(netId))
    
    TriggerClientEvent('infinity:player:coords', source, coords)
end)