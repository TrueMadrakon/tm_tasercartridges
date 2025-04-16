MaxAmmo = Config.Cartridges 
local ShotsRemaining = MaxAmmo
local taserModel = GetHashKey("WEAPON_STUNGUN")

RegisterNetEvent("tm_tasercartrage:reload")
AddEventHandler("tm_tasercartrage:reload", function()
    if ShotsRemaining <= 0 then
        TriggerServerEvent("tm_tasercartrage:check") 
        
        if lib.progressBar({
            duration = Config.reloadTime,
            label = Config.progressbarLabel,
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = false,
                move = false,
            },
            anim = {
                dict = 'anim@weapons@first_person@aim_rng@generic@pistol@singleshot@str',
                clip = 'reload_aim'
            },
        }) then
            ShotsRemaining = MaxAmmo
            SetResourceKvp("tm_tasercartrage", tostring(ShotsRemaining))
            if Config.Debug then print("reload success") end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if GetSelectedPedWeapon(ped) == taserModel then
            while GetSelectedPedWeapon(ped) == taserModel do
                Citizen.Wait(0)

                if Config.CustomTime then
                    SetPedMinGroundTimeForStungun(ped, Config.Time * 1000)
                end

                if IsPedShooting(ped) then
                    ShotsRemaining = math.max(0, ShotsRemaining - 1) 
                    SetResourceKvp("tm_tasercartrage", tostring(ShotsRemaining))
                    if Config.Debug then print("taser shot remaining : " .. ShotsRemaining) end
                end

                if exports.ox_inventory:GetItemCount("tasercart") > 0 and not lib.progressActive() and IsControlJustPressed(0, 45) and ShotsRemaining <= 0 then
                    if Config.Debug then print("reloading taser (keybind)") end
                    TriggerEvent("tm_tasercartrage:reload")
                end
                

                if ShotsRemaining <= 0 then
                    SetPlayerCanDoDriveBy(ped, false)
                    DisablePlayerFiring(ped, true)
                    DisableControlAction(0, 24, true) 
                    DisableControlAction(0, 257, true)
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

AddEventHandler('esx:onPlayerSpawn', function()
    local savedShots = GetResourceKvpString("tm_tasercartrage")
    if savedShots then
        ShotsRemaining = tonumber(savedShots)
        if Config.Debug then print("saved shots : " .. savedShots) end
    else
        ShotsRemaining = MaxAmmo
    end
end)

AddEventHandler('playerDropped', function()
    SetResourceKvp("tm_tasercartrage", tostring(ShotsRemaining))
    if Config.Debug then print("saving shots : " .. ShotsRemainings) end
end)
