ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('tauchflasche', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('tauchflasche', 1)
        TriggerClientEvent('mrwhitee:tauchflasche', _source)
end)


ESX.RegisterUsableItem('tauchflasche2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('tauchflasche2', 1)
        TriggerClientEvent('mrwhitee:tauchflasche2', _source)
end)

RegisterServerEvent('mrwhitee:server:AusruestungZurueck')
AddEventHandler('mrwhitee:server:AusruestungZurueck', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addInventoryItem('tauchflasche', 1)
end)

RegisterServerEvent('mrwhitee:server:AusruestungZurueck2')
AddEventHandler('mrwhitee:server:AusruestungZurueck2', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addInventoryItem('tauchflasche2', 1)
end)

RegisterCommand(Config.abnehmen, function(source, args, user)
    TriggerClientEvent("mrwhitee:abnehmen", source, false)
end, false)

RegisterCommand(Config.abnehmen2, function(source, args, user)
    TriggerClientEvent("mrwhitee:abnehmen2", source, false)
end, false)
