ESX = nil

MRWHITEE = {
    showtime = 60,

    info = {},
    locations ={
        loud = {
            start = {x=2663.18, y=1642.05, z=24.87},   
            bomb1 = {x=2834.27, y=1568.81, z=24.73},
            bomb2 = {x=2830.0, y=1553.0, z=24.73},
            bomb3 = {x=2811.54, y=1519.45, z=24.73},
            bomb4 = {x=2808.0, y=1503.59, z=24.73},
            bomb5 = {x=2835.1, y=1486.25, z=24.73},
            bomb6 = {x=2839.18, y=1502.61, z=24.73},
            bomb7 = {x=2857.21, y=1535.73, z=24.73},
            bomb8 = {x=2861.33, y=1552.1, z=24.73},        
        }
    },
    texts = {
        stromausfall = "stromausfall!",
        loud = {
            start = "[~g~E~w~] Attentat auf das ~r~Elektrizitätswerk~w~",
            bomb = "[~g~E~w~] Platziere den C4 Sprengsatz am Hauptgenerator",
            planted = "C4 Sprengsatz platziert"
        }
    }
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(60)
	end

    PlayerData = ESX.GetPlayerData()
    TriggerServerEvent("mrwhitee:checkstromausfall")
    AddRelationshipGroup("police")
    MRWHITEE:GetStage()
end)

function MRWHITEE:GetStage(...)
    ESX.TriggerServerCallback("mrwhitee:GetData", function(output)
        self.info = output
        return self:HandleInfo()
    end)
end
function MRWHITEE:HandleInfo(...)
    if not self.info.locked then
        if self.info.stage == 0 then
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(1)
                    local pedcoords = GetEntityCoords(PlayerPedId())
                    local startloud = GetDistanceBetweenCoords(pedcoords, self.locations.loud.start.x, self.locations.loud.start.y, self.locations.loud.start.z, true)
                    if startloud <= 6 then
                        DrawText3D(self.locations.loud.start.x, self.locations.loud.start.y, self.locations.loud.start.z, self.texts.loud.start, 0.40)
                        DrawMarker(1, self.locations.loud.start.x, self.locations.loud.start.y, self.locations.loud.start.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                        if startloud <= 1.5 and IsControlJustReleased(0, 38) then
                            TriggerServerEvent("mrwhitee:schloss")
                            self.info.stage = 1
                            self.info.style = 1
                            return self:HandleInfo()
                        end
                    end
                end
            end)
        elseif self.info.stage == 1 then
            if self.info.style == 1 then
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(1)
                        local pedcoords = GetEntityCoords(PlayerPedId())

                        if not MRWHITEE.planted1 then
                            local bomb1 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb1.x, self.locations.loud.bomb1.y, self.locations.loud.bomb1.z, true)

                            if bomb1 <= 5 and not MRWHITEE.planted1 then
                                DrawText3D(self.locations.loud.bomb1.x, self.locations.loud.bomb1.y, self.locations.loud.bomb1.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb1.x, self.locations.loud.bomb1.y, self.locations.loud.bomb1.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb1 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted1 = true
                                            self.currentplant = 1
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted2 then
                            local bomb2 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb2.x, self.locations.loud.bomb2.y, self.locations.loud.bomb2.z, true)

                            if bomb2 <= 5 and not MRWHITEE.planted2 then
                                DrawText3D(self.locations.loud.bomb2.x, self.locations.loud.bomb2.y, self.locations.loud.bomb2.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb2.x, self.locations.loud.bomb2.y, self.locations.loud.bomb2.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb2 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted2 = true
                                            self.currentplant = 2
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted3 then
                            local bomb3 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb3.x, self.locations.loud.bomb3.y, self.locations.loud.bomb3.z, true)

                            if bomb3 <= 5 and not MRWHITEE.planted3 then
                                DrawText3D(self.locations.loud.bomb3.x, self.locations.loud.bomb3.y, self.locations.loud.bomb3.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb3.x, self.locations.loud.bomb3.y, self.locations.loud.bomb3.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb3 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted3 = true
                                            self.currentplant = 3
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted4 then
                            local bomb4 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb4.x, self.locations.loud.bomb4.y, self.locations.loud.bomb4.z, true)

                            if bomb4 <= 5 and not MRWHITEE.planted4 then
                                DrawText3D(self.locations.loud.bomb4.x, self.locations.loud.bomb4.y, self.locations.loud.bomb4.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb4.x, self.locations.loud.bomb4.y, self.locations.loud.bomb4.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb4 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted4 = true
                                            self.currentplant = 4
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted5 then
                            local bomb5 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb5.x, self.locations.loud.bomb5.y, self.locations.loud.bomb5.z, true)

                            if bomb5 <= 5 and not MRWHITEE.planted5 then
                                DrawText3D(self.locations.loud.bomb5.x, self.locations.loud.bomb5.y, self.locations.loud.bomb5.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb5.x, self.locations.loud.bomb5.y, self.locations.loud.bomb5.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb5 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted5 = true
                                            self.currentplant = 5
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted6 then
                            local bomb6 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb6.x, self.locations.loud.bomb6.y, self.locations.loud.bomb6.z, true)

                            if bomb6 <= 5 and not MRWHITEE.planted6 then
                                DrawText3D(self.locations.loud.bomb6.x, self.locations.loud.bomb6.y, self.locations.loud.bomb6.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb6.x, self.locations.loud.bomb6.y, self.locations.loud.bomb6.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb6 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted6 = true
                                            self.currentplant = 6
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted7 then
                            local bomb7 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb7.x, self.locations.loud.bomb7.y, self.locations.loud.bomb7.z, true)

                            if bomb7 <= 5 and not MRWHITEE.planted7 then
                                DrawText3D(self.locations.loud.bomb7.x, self.locations.loud.bomb7.y, self.locations.loud.bomb7.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb7.x, self.locations.loud.bomb7.y, self.locations.loud.bomb7.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb7 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted7 = true
                                            self.currentplant = 6
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if not MRWHITEE.planted8 then
                            local bomb8 = GetDistanceBetweenCoords(pedcoords, self.locations.loud.bomb8.x, self.locations.loud.bomb8.y, self.locations.loud.bomb8.z, true)

                            if bomb8 <= 5 and not MRWHITEE.planted8 then
                                DrawText3D(self.locations.loud.bomb8.x, self.locations.loud.bomb8.y, self.locations.loud.bomb8.z, self.texts.loud.bomb, 0.40)
                                DrawMarker(1, self.locations.loud.bomb8.x, self.locations.loud.bomb8.y, self.locations.loud.bomb8.z - 1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 236, 80, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if bomb8 <= 1.5 and IsControlJustReleased(0, 38) then
                                    ESX.TriggerServerCallback("mrwhitee:checkItem", function(cb)
                                        if cb then
                                            MRWHITEE.planted8 = true
                                            self.currentplant = 6
                                            TriggerServerEvent("mrwhitee:ItemEntfernen", "c4_sprengsatz")
                                            self:PlantBomb()
                                        elseif not cb then
                                            exports['mythic_notify']:SendAlert("error", "Du hast kein C4 dabei")
                                        end
                                    end, "c4_sprengsatz")
                                end
                            end
                        end
                        if MRWHITEE.planted1 and MRWHITEE.planted2 and MRWHITEE.planted3 and MRWHITEE.planted4 and MRWHITEE.planted5 and MRWHITEE.planted6 and MRWHITEE.planted7 and MRWHITEE.planted8 then
                            self.info.stage = 2
                            return self:HandleInfo()
                        end
                    end
                end)
            end
        elseif self.info.stage == 2 then
            if self.info.style == 1 then
                MRWHITEE.showtime = 60
                self.info.stage = 3
                self.info.locked = true
                self:stromausfall()
                TriggerServerEvent("mrwhitee:update", self)
                return
            elseif self.info.style == 2 then
                MRWHITEE.showtime = 60
                self.info.stage = 3
                self.info.locked = true
                self:stromausfall()
                TriggerServerEvent("mrwhitee:update", self)
                return
            end
        end
    end
end
function Player()
    if PlayerData.job.name == "police" then
        SetPedRelationshipGroupHash(PlayerPedId(), MRWHITEE.police)
    end
end
function MRWHITEE:PlantBomb(...)
    if self.currentplant == 1 then
        loc = self.locations.loud.bomb1
        heading = 256.21
    elseif self.currentplant == 2 then
        loc = self.locations.loud.bomb2
        heading = 256.21
    elseif self.currentplant == 3 then
        loc = self.locations.loud.bomb3
        heading = 256.21
    elseif self.currentplant == 4 then
        loc = self.locations.loud.bomb4
        heading = 256.21
    elseif self.currentplant == 5 then
        loc = self.locations.loud.bomb5
        heading = 76.74
    elseif self.currentplant == 6 then
        loc = self.locations.loud.bomb6
        heading = 76.74
    elseif self.currentplant == 7 then
        loc = self.locations.loud.bomb7
        heading = 76.74
    elseif self.currentplant == 8 then
        loc = self.locations.loud.bomb8
        heading = 76.74
    end

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("prop_bomb_01")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasModelLoaded("prop_bomb_01")do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, heading)
    Citizen.Wait(100)
    local rot = vec3(GetEntityRotation(ped))
    local bagscene = NetworkCreateSynchronisedScene(loc.x - 0.70, loc.y + 0.50, loc.z, rot, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)

    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "work_carrybox",
        duration = 4000,
        label = "C4 wird platziert",
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,
        },
    })
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("prop_bomb_01"), x, y, z + 0.2,  true,  true, true)

    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(3000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    NetworkStopSynchronisedScene(bagscene)
    exports['mythic_notify']:SendAlert("success", "Sprengladung plaziert")
end

function MRWHITEE:stromausfall(...)
    TriggerEvent("mrwhitee:showtime", 1)
    repeat
        Citizen.Wait(1000)
        MRWHITEE.showtime = MRWHITEE.showtime - 1
    until MRWHITEE.showtime == 0
    if self.info.style == 1 then
        local camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(camera, 2817.1033, 1589.8843, 24.5568)
        SetCamRot(camera, 0, 0, 212.3395, 2)
        RenderScriptCams(1, 0, 0, 1, 1)
        Citizen.Wait(2000)
        AddExplosion(self.locations.loud.bomb1.x, self.locations.loud.bomb1.y, self.locations.loud.bomb1.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb2.x, self.locations.loud.bomb2.y, self.locations.loud.bomb2.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb3.x, self.locations.loud.bomb3.y, self.locations.loud.bomb3.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)      
        AddExplosion(self.locations.loud.bomb4.x, self.locations.loud.bomb4.y, self.locations.loud.bomb4.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb5.x, self.locations.loud.bomb5.y, self.locations.loud.bomb5.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb6.x, self.locations.loud.bomb6.y, self.locations.loud.bomb6.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb7.x, self.locations.loud.bomb7.y, self.locations.loud.bomb7.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        AddExplosion(self.locations.loud.bomb8.x, self.locations.loud.bomb8.y, self.locations.loud.bomb8.z, 34, 20.0, true, false, 1.0, true)
        Citizen.Wait(600)
        DestroyCam(camera, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
        SetFocusEntity(PlayerPedId())
    end
    TriggerServerEvent("mrwhitee:stromausfall", true)
    exports['mythic_notify']:SendAlert("success", "Stromausfall!")
end
function SmallExp(method, coords)
    MRWHITEE.mintime = 5
    TriggerEvent("mrwhitee:showtime", 2)
    repeat
        Citizen.Wait(1000)
        MRWHITEE.mintime = MRWHITEE.mintime - 1
    until MRWHITEE.mintime == 0
    if method == 1 then
        AddExplosion(2821.52, 1496.06, 24.57, 33, 1.0, true, false, 1.0, true)
    elseif method == 2 then
        AddExplosion(2845.7, 1552.06, 24.57, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.1 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.2 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.3 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.4 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.5 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.6 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.7 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.8 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.9 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.10 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.11 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    elseif method == 2.12 then
        AddExplosion(coords, 33, 1.0, true, false, 1.0, true)
    end
end

RegisterNetEvent("mrwhitee:power")
RegisterNetEvent("mrwhitee:showtime")


AddEventHandler("mrwhitee:power", function(status)
    SetArtificialLightsState(status)
    if not status then
        exports['mythic_notify']:SendAlert("success", "Der Strom ist wieder an!")
    elseif status then
        MRWHITEE.info.locked = true
    end
end)
AddEventHandler("mrwhitee:showtime", function(method)
    if method == 1 then
        while MRWHITEE.showtime > 0 do
            Citizen.Wait(1)
            ShowTimer(1)
        end
    elseif method == 2 then
        while MRWHITEE.mintime > 0 do
            Citizen.Wait(1)
            ShowTimer(2)
        end
    end
end)
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        SetArtificialLightsState(false)
    end
end)

-----------------

 function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 255) AddTextComponentString(text) DrawText(_x, _y) end

function ShowTimer(method)
    if method == 1 then
        SetTextFont(0)
        SetTextProportional(0)
        SetTextScale(0.42, 0.42)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString("~r~"..MRWHITEE.showtime.."~w~")
        DrawText(0.682, 0.96)
    elseif method == 2 then
        SetTextFont(0)
        SetTextProportional(0)
        SetTextScale(0.42, 0.42)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString("~r~"..MRWHITEE.mintime.."~w~")
        DrawText(0.682, 0.96)
    end
end

local blips = {
    {title="Elektrizitätswerk", colour=73, id=354, x = 2663.11, y = 1642.02, z = 24.87}
 }
     
Citizen.CreateThread(function()

   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 1.0)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)