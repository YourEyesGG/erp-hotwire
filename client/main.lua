ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		local MyCoords = GetEntityCoords(playerPed) -- Get Entity Coords

		if (IsPedJacking(playerPed)) then
			local vehicle = ESX.Game.GetClosestVehicle()
				
			DrawText3D(MyCoords['x'], MyCoords['y'], MyCoords['z'], '[E] To Hotwiring', 0.6) -- Draw 3D Text
			SetVehicleUndriveable(vehicle, true)
			SetVehicleEngineOn(vehicle, false, true, true) -- Set Vehicle Engine OFF
			if IsControlJustReleased(1, 38) then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "hotwiring",
					duration = 10000,
					label = "Hotwiring Vehicle",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "mini@repair",
						anim = "fixing_a_ped",
					},
					prop = {
						model = "",
					}
				}, function(status)
					if not status then
						SetVehicleEngineOn(vehicle, true, true, false)
						exports['mythic_notify']:DoHudText('success', 'Hotwiring Successfully')
						ClearPedTasks(playerPed)
					end
				end)
			end	
		end
	end
end)

function DrawText3D(x, y, z, text, scale) -- 3D Text Function
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)
 
	AddTextComponentString(text)
	DrawText(_x, _y)
	ClearDrawOrigin()
end
