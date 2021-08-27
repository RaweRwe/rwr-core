Config = {}

Config.Version = "1.3"

Config.DiscordTitle = "Discord İsmi"
Config.Webhook = "webhook"

--- Notify Setting
Config.UseMythicNotify = false -- [true/false] / Eğer true yapılırsa komutlar için mythic-notify kullanılır. - If true then mythic-notify is used for commands


Config.DamageNeeded = 100.0 -- 100.0 being broken and 1000.0 being fixed a lower value than 100.0 will break it
Config.MaxWidth = 5.0 -- Will complete soon
Config.MaxHeight = 5.0
Config.MaxLength = 5.0

Config.PvP = true -- [true/false]
Config.NoWanted = true -- [true/false]

Blips = {
    ["blip1"] = {
        title="Example Blip", colour=5, scale = 0.8, id=446, x = -347.291, y = -133.370, z = 38.009
    },
    ["blip2"] = {
        title="Example Blip", colour=3, scale = 0.8, id=446, x = -204.4, y = -1306.58, z = 31.31
    },
}


-- NPC Settings
Config.NoGuns = true -- [true/false]
Config.NoDrops = true  -- [true/false]
Config.PedDensity = 0.0 -- max 1.0
Config.PedScenario = 0.0 -- max 1.0
Config.PedScenario1 = 0.0 -- max 1.0

Config.TrafficDensity = 0.0 -- max 1.0
Config.GarbageTruck = false -- [true/false]
Config.RandomBoats = false -- [true/false]
Config.RandomPolice = false -- [true/false]