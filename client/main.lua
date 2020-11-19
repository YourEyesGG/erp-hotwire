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
		local MyCoords = GetEntityCoords(GetPlayerPed(source), false)

		if GetVehiclePedIsTryingToEnter(PlayerPedId()) then
			DrawText3D(MyCoords['x'], MyCoords['y'], MyCoords['z']+offset-1.250, "~b~[X]~w~ To Hotwiring")
			if IsControlJustPressed(0, 23) then
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 10000, true)
				TriggerEvent("mythic_progbar:client:progress", {
					name = "hotwiring",
					duration = 10000,
					label = "Hotwiring Vehicle",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "",
						anim = "",
					},
					prop = {
						model = "",
					}
				}, function(status)
					if not status then
						exports['mythic_notify']:DoHudText('success', 'Hotwiring Successfully')
					end
				end)
			end
		end
	end
end)