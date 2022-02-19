ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local Ausruestung = {
    mask = 0,
    tank = 0,
    enabled = false
}

local Ausruestung2 = {
    mask = 0,
    tank = 0,
    enabled = false
}

function AusruestungEntfernen1()
	if Ausruestung.mask ~= 0 then
        DetachEntity(Ausruestung.mask, 0, 1)
        DeleteEntity(Ausruestung.mask)
		Ausruestung.mask = 0
    end
    
	if Ausruestung.tank ~= 0 then
        DetachEntity(Ausruestung.tank, 0, 1)
        DeleteEntity(Ausruestung.tank)
		Ausruestung.tank = 0
	end
end

function AusruestungEntfernen2()
	if Ausruestung2.mask ~= 0 then
        DetachEntity(Ausruestung2.mask, 0, 1)
        DeleteEntity(Ausruestung2.mask)
		Ausruestung2.mask = 0
    end
    
	if Ausruestung2.tank ~= 0 then
        DetachEntity(Ausruestung2.tank, 0, 1)
        DeleteEntity(Ausruestung2.tank)
		Ausruestung2.tank = 0
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

RegisterNetEvent('mrwhitee:tauchflasche')
AddEventHandler('mrwhitee:tauchflasche', function()
	if Ausruestung.enabled == false then
		GearAnim()
		AusruestungEntfernen1()
		local maskModel = GetHashKey("p_d_scuba_mask_s")
		local tankModel = GetHashKey("p_michael_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end
		TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
		AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.30, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		Ausruestung.tank = TankObject

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end
		
		MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
		AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		Ausruestung.mask = MaskObject

		SetEnableScuba(GetPlayerPed(-1), true)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 400.00)
		Ausruestung.enabled = true
		ClearPedTasks(GetPlayerPed(-1))
    end
end)

RegisterNetEvent('mrwhitee:abnehmen')
AddEventHandler('mrwhitee:abnehmen', function()
	if Ausruestung.enabled then
		GearAnim()
		AusruestungEntfernen1()

		SetEnableScuba(GetPlayerPed(-1), false)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 20.00)
		Ausruestung.enabled = false
		TriggerServerEvent('mrwhitee:server:AusruestungZurueck')
		ClearPedTasks(GetPlayerPed(-1))
	end
end)	


RegisterNetEvent('mrwhitee:tauchflasche2')
AddEventHandler('mrwhitee:tauchflasche2', function()
	if Ausruestung2.enabled == false then
		GearAnim()
		AusruestungEntfernen2()
		local maskModel = GetHashKey("p_d_scuba_mask_s") 
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
		AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		Ausruestung2.tank = TankObject

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end
		
		MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
		AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		Ausruestung2.mask = MaskObject

		SetEnableScuba(GetPlayerPed(-1), true)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1500.00)
		Ausruestung2.enabled = true
		ClearPedTasks(GetPlayerPed(-1))
    end
end)

RegisterNetEvent('mrwhitee:abnehmen2')
AddEventHandler('mrwhitee:abnehmen2', function()
	if Ausruestung2.enabled then
		GearAnim()
		AusruestungEntfernen2()

		SetEnableScuba(GetPlayerPed(-1), false)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 20.00)
		Ausruestung2.enabled = false
		TriggerServerEvent('mrwhitee:server:AusruestungZurueck2')
		ClearPedTasks(GetPlayerPed(-1))
	end
end)		

function GearAnim()
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

