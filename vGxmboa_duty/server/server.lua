ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dutyStatus = {}
local dutyStart = {}

local function sendToDiscord(name, job, dutyTime)
    if not Config.Discord.use or Config.Discord.webhook == "" then return end

    local connect = {
        {
            ["color"] = 3447003,
            ["title"] = "Duty Report",
            ["description"] = "**Spieler:** " .. name .. "\n**Job:** " .. job .. "\n**Dienstzeit:** " .. dutyTime,
            ["footer"] = { ["text"] = os.date("%d.%m.%Y %H:%M:%S") }
        }
    }
    PerformHttpRequest(Config.Discord.webhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Duty Logger",
        embeds = connect
    }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("duty:toggle")
AddEventHandler("duty:toggle", function(job)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= job then
        TriggerClientEvent('esx:showNotification', src, "Du arbeitest hier nicht.")
        return
    end

    if dutyStatus[src] == nil then dutyStatus[src] = {} end

    dutyStatus[src][job] = not dutyStatus[src][job]

    if dutyStatus[src][job] then
        dutyStart[src] = os.time()
        TriggerClientEvent("duty:setStatus", src, job, true)
    else
        local endTime = os.time()
        local duration = os.difftime(endTime, dutyStart[src] or endTime)

        local hours = math.floor(duration / 3600)
        local minutes = math.floor((duration % 3600) / 60)
        local seconds = duration % 60
        local dutyTime = string.format("%02d:%02d:%02d", hours, minutes, seconds)

        TriggerClientEvent("duty:setStatus", src, job, false, dutyTime)
        sendToDiscord(xPlayer.getName(), job, dutyTime)
    end
end)
