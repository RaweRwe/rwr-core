RegisterNetEvent('RWRCore:DeleteVehicle')
AddEventHandler('RWRCore:DeleteVehicle', function()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		RWR.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	else
		local vehicle = GetClosestVehicle()
		RWR.Functions.DeleteVehicle(vehicle)
	end
end)