------------------------------
-- Sistema de avisos InGame --
--       por Jougito        --
------------------------------

ESX         = nil
PlayerData  = {}

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/' .. Config.eCommand, 'Manda un mensaje de entorno a la policía', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a la policía' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.aCommand, 'Manda un mensaje de entorno a los EMS', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los EMS' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.mCommand, 'Manda un aviso a los mecánicos', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los mecánicos' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.tCommand, 'Manda un aviso a los taxistas', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los taxistas' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.bCommand, 'Manda un aviso a ArcaBurger', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a Badu-Bar' } } )
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Aviso a la facción y texto de proximidad

RegisterNetEvent('avisos:ProximityWarning')
AddEventHandler('avisos:ProximityWarning', function(playerId, title, message, color, proximity, job)
    local source = PlayerId()
    local target = GetPlayerFromServerId(playerId)
    local uName  = GetPlayerName(target)

    local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

    if proximity then
        if target == source then
            TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
        elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < Config.pRange then
            if Config.pName then
                if job == Config.eJob then
                    TriggerEvent('chat:addMessage', { args = { "[OOC] ".. uName .." (".. playerId .."): ", "Se ha enviado una llamada de rol de entorno a la policía" }, color = Config.oColour })
                elseif job == Config.aJob then
                    TriggerEvent('chat:addMessage', { args = { "[OOC] ".. uName .." (".. playerId .."): ", "Se ha enviado una llamada de rol de entorno a los EMS" }, color = Config.oColour })
                end
            else
                if job == Config.eJob then
                    TriggerEvent('chat:addMessage', { args = { "[OOC] ".. playerId ..": ", "Se ha enviado una llamada de rol de entorno a la policía" }, color = Config.oColour })
                elseif job == Config.aJob then
                    TriggerEvent('chat:addMessage', { args = { "[OOC] ".. playerId ..": ", "Se ha enviado una llamada de rol de entorno a los EMS" }, color = Config.oColour })
                end
            end
        end
    else
        if target == source then
            TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
        end
    end

    if PlayerData.job ~= nil and PlayerData.job.name == job then
        if target ~= source then
            TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
        end
    end

end)

-- Notificación

RegisterNetEvent('avisos:Notify')
AddEventHandler('avisos:Notify', function(playerId, message, job, icon, name)
    
    if PlayerData.job ~= nil and PlayerData.job.name == job then
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        SetNotificationMessage(icon, icon, true, 0, name, "ID: ".. playerId)
        DrawNotification(false, true)
    end

end)

-- Blip en el mapa

RegisterNetEvent('avisos:Blip')
AddEventHandler('avisos:Blip', function(playerId, icon, colour, scale, name, job)

    if PlayerData.job ~= nil and PlayerData.job.name == job then
        BlipGenerator(playerId, icon, colour, scale, name)
    end

end)

-- Funciones

function BlipGenerator(id, icon, colour, scale, name)
    local ped = GetPlayerPed(GetPlayerFromServerId(id))
    local coords = GetEntityCoords(ped)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    
    SetBlipSprite(blip, icon)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Aviso " .. name .. " - ID: ".. id)
    EndTextCommandSetBlipName(blip)
    Citizen.Wait(Config.bTime * 1000)
    SetBlipFade(blip, 0, 1000)
end
