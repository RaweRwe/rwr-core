Config = {}

Config.Version = "1.2.3"

Config.DiscordTitle = "Discord İsmi"
Config.Webhook = "discord webhook link"

Config.DamageNeeded = 100.0 -- 100.0 being broken and 1000.0 being fixed a lower value than 100.0 will break it
Config.MaxWidth = 5.0 -- Will complete soon
Config.MaxHeight = 5.0
Config.MaxLength = 5.0

Blips = {
    ["blip1"] = {
        title="Örnek Blip", colour=5, scale = 0.8, id=446, x = -347.291, y = -133.370, z = 38.009
    },
    ["blip2"] = {
        title="Örnek Blip", colour=3, scale = 0.8, id=446, x = -204.4, y = -1306.58, z = 31.31
    },
}

Config.NoGuns = true -- false yaparsanız çalışmaz
Config.NoDrops = true  -- false yaparsanız çalışmaz
Config.Pedsayisi = 0.0 -- max 1.0
Config.Pedsenaryo = 0.0 -- max 1.0
Config.Pedsenaryo1 = 0.0 -- max 1.0

Config.Trafficcoklugu = 0.0 -- Trafik yoğunlu max 1.0
Config.CopKamyonlari = false -- Rastgele ortaya çıkan çöp kamyonları [true/false]
Config.RandomTekne = false -- Rastgele denizde/suda tekne çıkması [true/false]
Config.RandomPolis = false -- Rastgele polisler (araç/yaya)[true/false]