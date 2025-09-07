Config = {}

Config.Locale = 'en'

Config.DutyStations = {
    police = {
        label = "LSPD",
        coords = vector3(441.2, -981.9, 30.6)
    },
    ambulance = {
        label = "LSMD",
        coords = vector3(307.5, -595.1, 43.3)
    }
}

Config.Marker = {
    Type = 1,
    Size = {x = 1.5, y = 1.5, z = 0.5},
    Color = {r = 0, g = 150, b = 255, a = 150}
}

Config.Discord = {
    use = true,
    webhook = "YOUR_DISCORD_WEBHOOK_URL"
}
