ESX = nil
local info = {stage = 0, style = nil, locked = false}
local blackoutstatus = false
local blackoutdur = 1800 -- Kein Strom in Sekunden

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("mrwhitee:ItemEntfernen")
RegisterServerEvent("mrwhitee:stromausfall")
RegisterServerEvent("mrwhitee:checkstromausfall")

ESX.RegisterServerCallback("mrwhitee:GetData", function(source, cb)
    cb(info)
end)
ESX.RegisterServerCallback("mrwhitee:checkItem", function(source, cb, itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemname)["count"]

    if item >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

AddEventHandler("mrwhitee:ItemEntfernen", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(item, 1)
end)

AddEventHandler("mrwhitee:checkstromausfall", function()
    if blackoutstatus == true then
        TriggerClientEvent("mrwhitee:power", source, true)
    end
end)
AddEventHandler("mrwhitee:stromausfall", function(status)
    blackoutstatus = true
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent("mrwhitee:power", xPlayers[i], status)
    end
    BlackoutTimer()
end)

function BlackoutTimer()
    local timer = blackoutdur
    repeat
        Citizen.Wait(1000)
        timer = timer - 1
    until timer == 0
    blackoutstatus = false
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent("mrwhitee:power", xPlayers[i], false)
    end
end