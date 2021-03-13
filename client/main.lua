------------------------------
-- Sistema de avisos InGame --
--       por Jougito        --
------------------------------

ESX         = nil
PlayerData  = {}
local warnMark, warnTimer, warnCoords = false, nil, nil

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/' .. Config.eCommand, 'Manda un mensaje de entorno a la policía', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a la policía' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.aCommand, 'Manda un mensaje de entorno a los EMS', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los EMS' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.mCommand, 'Manda un aviso a los mecánicos', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los mecánicos' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.tCommand, 'Manda un aviso a los taxistas', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a los taxistas' } } )
    TriggerEvent('chat:addSuggestion', '/' .. Config.bCommand, 'Manda un aviso a Badu-Bar', { { name = 'Mensaje', help = 'Mensaje que quieres enviar a Badu-Bar' } } )
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

RegisterNetEvent('avisos:WarningCoords')
AddEventHandler('avisos:WarningCoords', function(type, source, args)
    local ped = GetPlayerPed(GetPlayerFromServerId(source))
    local coords = GetEntityCoords(ped)

    if type == 1 then
        TriggerServerEvent('avisos:WarningSent', 1, coords, source, args)
    elseif type == 2 then
        TriggerServerEvent('avisos:WarningSent', 2, coords, source, args)
    elseif type == 3 then
        TriggerServerEvent('avisos:WarningSent', 3, coords, source, args)
    elseif type == 4 then
        TriggerServerEvent('avisos:WarningSent', 4, coords, source, args)
    elseif type == 5 then
        TriggerServerEvent('avisos:WarningSent', 5, coords, source, args)
    end
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
end)

RegisterNetEvent('avisos:JobWarning')
AddEventHandler('avisos:JobWarning', function(playerId,title, message, color, job)
    local source = PlayerId()
    local target = GetPlayerFromServerId(playerId)

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
AddEventHandler('avisos:Blip', function(playerId, icon, colour, scale, name, job, coords)
    if PlayerData.job ~= nil and PlayerData.job.name == job then
        BlipGenerator(playerId, icon, colour, scale, name, coords)
    end
end)

-- Funciones

function BlipGenerator(id, icon, colour, scale, name, coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    warnMark = true
    warnTimer = 1300
    warnCoords = coords
    
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

-- Marcar posición GPS

Citizen.CreateThread(function()
    while true do
        if warnMark then
            warnTimer = warnTimer-1
            if (Config.bAccept ~= nil) and (IsControlJustPressed(0, Config.bAccept)) then
                SetNewWaypoint(warnCoords.x, warnCoords.y)
                PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
                warnMark = false
                warnTimer = 0
            end
            if (Config.bCancel ~= nil) and (IsControlJustPressed(0, Config.bCancel)) then
                PlaySound(-1, "CANCEL", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
                warnMark = false
                warnTimer = 0
            end
            if warnTimer == 0 then 
                warnMark = false
            end
        end
        Citizen.Wait(1)
    end
end)
