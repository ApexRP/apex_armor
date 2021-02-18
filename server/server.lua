ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local currentArmour = nil

RegisterNetEvent('Apexrefresharmourserver')
AddEventHandler('Apexrefresharmourserver', function(updateArmour)
   currentArmour = updateArmour
end)

AddEventHandler('esx:playerLoaded', function(playerId)
	--print("Player has joined")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    MySQL.Async.fetchScalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = tostring(xPlayer.getIdentifier())
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('ApexrefreshArmour', playerId, data)
		end
    end)
end)

AddEventHandler('esx:playerDropped', function(playerId)
    if currentArmour ~= nil then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        MySQL.Async.execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
            ['@identifier'] = tostring(xPlayer.getIdentifier()),
            ['@armour'] = tonumber(currentArmour)
		})
		--print("Saved on leave")
    end
end)
