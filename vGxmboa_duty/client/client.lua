ESX = nil
local onDuty = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

RegisterNetEvent("duty:setStatus")
AddEventHandler("duty:setStatus", function(job, status, dutyTime)
    onDuty[job] = status
    if status then
        ESX.ShowNotification("Du bist nun ~g~im Dienst~s~ als " .. job)
    else
        ESX.ShowNotification("Du bist nun ~r~außer Dienst~s~ als " .. job .. "\n~b~Zeit im Dienst: " .. dutyTime)
    end
end)
