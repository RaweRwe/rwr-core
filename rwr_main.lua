RWR                 = {}
RWR.ServerCallbacks = {}

AddEventHandler('RWRCore:getSharedObject', function(cb)
	cb(RWR)
end)

function getSharedObject()
	return RWR
end

RWR.RegisterServerCallback = function(name, cb)
	RWR.ServerCallbacks[name] = cb
end

RWR.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if RWR.ServerCallbacks[name] then
		RWR.ServerCallbacks[name](source, cb, ...)
	else
		print(('[rwr-core] "%s" callback bulunmamasına rağmen oynatıldı.'):format(name))
	end
end

RegisterServerEvent('RWRCore:triggerServerCallback')
AddEventHandler('RWRCore:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	RWR.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('RWRCore:serverCallback', playerId, requestId, ...)
	end, ...)
end)

function split(str, pat)
    local t = {}
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
end

Citizen.CreateThread( function()
    Citizen.Wait(1000)
    resourceName = GetCurrentResourceName()
    if resourceName ~= "rwr-core" then 
        print("\n")
        print("^1[rwr-core] ^0Lütfen script ismini değiştirmeyiniz.\n")
    end
end)

-- Discord webhook

RegisterServerEvent("imgToDiscord")
AddEventHandler("imgToDiscord", function(img)
    -- img, foto url oluyor
  PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Rawe", content = img}), { ['Content-Type'] = 'application/json' })
end)

function discordwebhook(content)
   local _source = source
         local connect = {
        {
            ["color"] = "23295",
            ["title"] = Config.DiscordTitle,
            ["description"] = "Kullanıcı: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = "RaweCore V1.0.0",
            },
        }
    }
  PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "RaweCore", embeds = connect}), { ['Content-Type'] = 'application/json' })
end