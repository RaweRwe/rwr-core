RWR = {}

AddEventHandler('RWRCore:getSharedObject', function(cb)
	cb(RWR)
end)

function getSharedObject()
	return RWR
end

-- Version Control

Citizen.CreateThread(function()
  Citizen.Wait(1000)
    VersionControl = function(err, result, headers)
        if result then
            local data = json.decode(result)
            if data.version ~= Config.Version then
                print("\n")
                print("^2[RWRCore] ^0New version finded: ".. data.version .." Updates: \n".. data.updates .. "\n")
                print("https://github.com/RaweRwe/rwr-core\n")
            end
            if data.version == Config.Version then
                print("\n")
                print("^2[RWRCore] ^0You using latest version: ".. data.version)
            end
        end
    end
  PerformHttpRequest("http://rawe.epizy.com/version.json", VersionControl, "GET")
end)

-- Discord webhook

function discordwebhook(content)
   local _source = source
         local connect = {
        {
            ["color"] = "23295",
            ["title"] = Config.DiscordTitle,
            ["description"] = "Player: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = Config.Version,
            },
        }
    }
  PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "RWRCore", embeds = connect}), { ['Content-Type'] = 'application/json' })
end

--- Kick

RegisterServerEvent("RWR:kickplayer")
AddEventHandler("RWR:kickplayer", function(reason)
	DropPlayer(source, reason)	
end)
