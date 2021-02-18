
RegisterNetEvent('ApexrefreshArmour')
AddEventHandler('ApexrefreshArmour', function(armour)
    Citizen.Wait(6000)  
                        
    SetPedArmour(PlayerPedId(), tonumber(armour))
end)

local TimeFreshCurrentArmour = 1000  -- 1s

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        TriggerServerEvent('Apexrefresharmourserver', GetPedArmour(PlayerPedId()))
        Citizen.Wait(TimeFreshCurrentArmour)
    end
end)
