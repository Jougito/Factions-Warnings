------------------------------
-- Sistema de avisos InGame --
--       por Jougito        --
------------------------------

RegisterCommand(Config.eCommand, function(source, args, rawCommand)

    local args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.eCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:WarningCoords', source, 1, source, args)
    end
    
end, false)

RegisterCommand(Config.aCommand, function(source, args, rawCommand)

    local args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.aCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:WarningCoords', source, 2, source, args)
    end
    
end, false)

RegisterCommand(Config.mCommand, function(source, args, rawCommand)

    local args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.mCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:WarningCoords', source, 3, source, args)
    end
    
end, false)

RegisterCommand(Config.tCommand, function(source, args, rawCommand)

    local args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.tCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:WarningCoords', source, 4, source, args)
    end
    
end, false)

RegisterCommand(Config.bCommand, function(source, args, rawCommand)

    local args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.bCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:WarningCoords', source, 5, source, args)
    end
    
end, false)

RegisterServerEvent('avisos:WarningSent')
AddEventHandler('avisos:WarningSent', function(type, coords, source, args)
    if type == 1 then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.eName .." (".. source ..") ", args, Config.eColour, true, Config.eJob)
        TriggerClientEvent('avisos:JobWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.eColour, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.eJob, "CHAR_CALL911", "Aviso de Entorno")
        TriggerClientEvent('avisos:Blip', -1, source, Config.eIcon, Config.eIconColour, Config.eIconScale, Config.eName, Config.eJob, coords)
    elseif type == 2 then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.aName .." (".. source ..") ", args, Config.aColour, true, Config.aJob)
        TriggerClientEvent('avisos:JobWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.aColour, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.aJob, "CHAR_PLANESITE", "Aviso de Auxilio")
        TriggerClientEvent('avisos:Blip', -1, source, Config.aIcon, Config.aIconColour, Config.aIconScale, Config.aName, Config.aJob, coords)
    elseif type == 3 then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.mName .." (".. source ..") ", args, Config.mColour, false, Config.mJob)
        TriggerClientEvent('avisos:JobWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.mColour, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.mJob, "CHAR_LS_CUSTOMS", "Aviso de Mecánico")
        TriggerClientEvent('avisos:Blip', -1, source, Config.mIcon, Config.mIconColour, Config.mIconScale, Config.mName, Config.mJob, coords)
    elseif type == 4 then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.tName .." (".. source ..") ", args, Config.tColour, false, Config.tJob)
        TriggerClientEvent('avisos:JobWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.tColour, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.tJob, "CHAR_TAXI", "Aviso de Taxi")
        TriggerClientEvent('avisos:Blip', -1, source, Config.tIcon, Config.tIconColour, Config.tIconScale, Config.tName, Config.tJob, coords)
    elseif type == 5 then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.bColour, false, Config.tJob)
        TriggerClientEvent('avisos:JobWarning', -1, source, Config.bName .." (".. source ..") ", args, Config.bColour, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.bJob, "CHAR_PEGASUS_DELIVERY", "Aviso de Badu-Bar")
        TriggerClientEvent('avisos:Blip', -1, source, Config.bIcon, Config.bIconColour, Config.bIconScale, Config.bName, Config.bJob, coords)
    end
end)

-- Version Checking - DON'T TOUCH THIS

local CurrentVersion = '1.0.4'
local GithubResourceName = 'Factions-Warnings'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
    PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
        print('^0')
        print('^6[Factions Warnings]^0 Checking for updates...')
        print('^0')
        print('^6[Factions Warnings]^0 Current version: ^5' .. CurrentVersion .. '^0')
        print('^6[Factions Warnings]^0 Updater version: ^5' .. NewestVersion .. '^0')
        print('^0')
        if CurrentVersion ~= NewestVersion then
            print('^6[Factions Warnings]^0 Your script is ^8outdated^0!')
            print('^0')
            print('^6[Factions Warnings] ^3CHANGELOG ^5' .. NewestVersion .. ':')
            print('^3')
            print(Changes)
            print('^0')
            print('^6[Factions Warnings]^0 You ^8are not^0 running the newest stable version of ^5Factions Warnings^0. Please update: https://github.com/Jougito/Factions-Warnings')
        else
            print('^6[Factions Warnings]^0 Your script is ^2up to update^0')
        end
        print('^0')
    end)
end)
