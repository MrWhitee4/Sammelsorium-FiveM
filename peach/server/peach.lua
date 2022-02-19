local playersProcessingPeach = {}

RegisterServerEvent('esx_farm:pickedUpPeach')
AddEventHandler('esx_farm:pickedUpPeach', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('peach')

	if not xPlayer.canCarryItem('peach', xItem.count + 1) then
		TriggerClientEvent('esx:showNotification', _source, _U('peach_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_farm:processPeach')
AddEventHandler('esx_farm:processPeach', function()
	if not playersProcessingPeach[source] then
		local _source = source

		playersProcessingPeach[_source] = ESX.SetTimeout(Config.Delays.PeachProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xPeach, xPeachJuice = xPlayer.getInventoryItem('peach'), xPlayer.getInventoryItem('peach_juice')

			if not xPlayer.canCarryItem('peach_juice', xPeachJuice.count + 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('peach_processingfull'))
			elseif xPeach.count < 2 then
				TriggerClientEvent('esx:showNotification', _source, _U('peach_processingenough'))
			else
				xPlayer.removeInventoryItem('peach', 2)
				xPlayer.addInventoryItem('peach_juice', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('peach_processed'))
			end

			playersProcessingPeach[_source] = nil
		end)
	else
		print(('esx_farm: %s attempted to exploit peach processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingPeach[playerID] then
		ESX.ClearTimeout(playersProcessingPeach[playerID])
		playersProcessingPeach[playerID] = nil
	end
end

RegisterServerEvent('esx_farm:cancelProcessing')
AddEventHandler('esx_farm:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
