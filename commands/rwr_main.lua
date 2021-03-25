RegisterCommand("clearweapons", function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    exports['mythic_notify']:SendAlert('success', 'Tüm silahlar başarıyla silindi')
end)
