ESX.RegisterUsableItem('tasercart', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerClientEvent("tm_tasercartrage:reload", source)
	
end)

RegisterNetEvent("tm_tasercartrage:check")
AddEventHandler("tm_tasercartrage:check", function()
local source = source
local xPlayer  = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('tasercart', 1)

end)