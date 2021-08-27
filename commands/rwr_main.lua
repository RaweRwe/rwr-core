RegisterCommand("clearweapons", function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    if Config.UseMythicNotify then
        exports['mythic_notify']:SendAlert('success', 'Tüm silahlar başarıyla silindi')
    else
        exports['rwr-core']:ShowNotify('Weapons Removed!', '#00ff2f', '#ffff', 1000)
    end  
end)

RegisterCommand("as", function(source, args)
    TriggerClientEvent("RWRCore:DeleteVehicle")
    if Config.UseMythicNotify then
        exports['mythic_notify']:SendAlert('success', 'Araç başarıyla silindi')
    else
        exports['rwr-core']:ShowNotify('Vehicle Deleted!', '#00ff2f', '#ffff', 1000)
    end 
end)

RegisterCommand("yenile", function(source, args, raw)
    ClearPedTasksImmediately(GetPlayerPed(-1))
end, false)