RegisterNetEvent('RWRCore:AracSil')
AddEventHandler('RWRCore:AracSil', function()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		RWR.AracSil(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	else
		local vehicle = GetClosestVehicle()
		RWR.AracSil(vehicle)
	end
end)