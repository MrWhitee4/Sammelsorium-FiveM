local spawnedpeachs = 0
local peachPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.PeachField.coords, true) < 50 then
			SpawnpeachPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.PeachProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('peach_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							Processpeach()
						else
							OpenBuyLicenseMenu('peach_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'peach_processing')
				else
					Processpeach()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Processpeach()
	isProcessing = true

	ESX.ShowNotification(_U('peach_processingstarted'))
	TriggerServerEvent('esx_farm:processPeach')
	local timeLeft = Config.Delays.PeachProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.PeachProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('peach_processingtoofar'))
			TriggerServerEvent('esx_farm:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #peachPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(peachPlants[i]), false) < 1 then
				nearbyObject, nearbyID = peachPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('peach_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_farm:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(peachPlants, nearbyID)
						spawnedpeachs = spawnedpeachs - 1
		
						TriggerServerEvent('esx_farm:pickedUpPeach')
					else
						ESX.ShowNotification(_U('peach_inventoryfull'))
					end

					isPickingUp = false

				end, 'peach')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(peachPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnpeachPlants()
	while spawnedpeachs < 15 do
		Citizen.Wait(0)
		local peachCoords = GeneratepeachCoords()

		ESX.Game.SpawnLocalObject('prop_joshua_tree_01c', peachCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(peachPlants, obj)
			spawnedpeachs = spawnedpeachs + 1
		end)
	end
end

function ValidatepeachCoord(plantCoord)
	if spawnedpeachs > 0 then
		local validate = true

		for k, v in pairs(peachPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.PeachField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratepeachCoords()
	while true do
		Citizen.Wait(1)

		local peachCoordX, peachCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		peachCoordX = Config.CircleZones.PeachField.coords.x + modX
		peachCoordY = Config.CircleZones.PeachField.coords.y + modY

		local coordZ = GetCoordZpeach(peachCoordX, peachCoordY)
		local coord = vector3(peachCoordX, peachCoordY, coordZ)

		if ValidatepeachCoord(coord) then
			return coord
		end
	end
end

function GetCoordZpeach(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end