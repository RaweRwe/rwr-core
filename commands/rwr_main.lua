RegisterCommand("clearweapons", function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    exports['mythic_notify']:SendAlert('success', 'Tüm silahlar başarıyla silindi')
end)

RegisterCommand("as", function(source, args)
    TriggerClientEvent("RwR:AracSil")
    exports['mythic_notify']:SendAlert('success', 'Araç başarıyla silindi')  
end)
