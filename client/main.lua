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
				
			ESX.ShowHelpNotification('Tekan ~INPUT_CONTEXT~ Untuk Hotwiring') -- Hotwiring Press Notification
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
