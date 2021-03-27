RegisterNetEvent('RWRCore:DeleteVehicle')
AddEventHandler('RWRCore:DeleteVehicle', function()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		RWR.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	else
		local vehicle = GetClosestVehicle()
		RWR.DeleteVehicle(vehicle)
	end
end)