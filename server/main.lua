------------------------------
-- Sistema de avisos InGame --
--       por Jougito        --
------------------------------

RegisterCommand(Config.eCommand, function(source, args, rawCommand)

    args = table.concat(args, ' ')
    
    if Config.JouBot then
        local name = GetPlayerName(source)
        
        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.eCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.eName .." (".. source .."): ", args, Config.eColour, true, Config.eJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.eJob, "CHAR_CALL911", "Aviso de Entorno")
        TriggerClientEvent('avisos:Blip', -1, source, Config.eIcon, Config.eIconColour, Config.eIconScale, Config.eName, Config.eJob)
    end
    
end, false)

RegisterCommand(Config.aCommand, function(source, args, rawCommand)

    args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.aCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.aName .." (".. source .."): ", args, Config.aColour, true, Config.aJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.aJob, "CHAR_PLANESITE", "Aviso de Auxilio")
        TriggerClientEvent('avisos:Blip', -1, source, Config.aIcon, Config.aIconColour, Config.aIconScale, Config.aName, Config.aJob)
    end
    
end, false)

RegisterCommand(Config.mCommand, function(source, args, rawCommand)

    args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.mCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.mName .." (".. source .."): ", args, Config.mColour, false, Config.mJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.mJob, "CHAR_LS_CUSTOMS", "Aviso de Mecánico")
        TriggerClientEvent('avisos:Blip', -1, source, Config.mIcon, Config.mIconColour, Config.mIconScale, Config.mName, Config.mJob)
    end
    
end, false)

RegisterCommand(Config.tCommand, function(source, args, rawCommand)

    args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.tCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.tName .." (".. source .."): ", args, Config.tColour, false, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.tJob, "CHAR_TAXI", "Aviso de Taxi")
        TriggerClientEvent('avisos:Blip', -1, source, Config.tIcon, Config.tIconColour, Config.tIconScale, Config.tName, Config.tJob)
    end
    
end, false)

RegisterCommand(Config.bCommand, function(source, args, rawCommand)

    args = table.concat(args, ' ')

    if Config.JouBot then
        local name = GetPlayerName(source)

        TriggerEvent('JouBot:ToDiscord', 'chat', name .. ' (ID: ' .. source .. ')', '/' .. Config.bCommand .. ' ' .. args, 'steam', true, source, TTS)
    end

    if args ~= "" then
        TriggerClientEvent('avisos:ProximityWarning', -1, source, Config.bName .." (".. source .."): ", args, Config.bColour, false, Config.tJob)
        TriggerClientEvent('avisos:Notify', -1, source, args, Config.bJob, "CHAR_PEGASUS_DELIVERY", "Aviso de Badu-Bar")
        TriggerClientEvent('avisos:Blip', -1, source, Config.bIcon, Config.bIconColour, Config.bIconScale, Config.bName, Config.bJob)
    end
    
end, false)

-- Version Checking - DON'T TOUCH THIS

local CurrentVersion = '1.0.0'
local GithubResourceName = 'Factions-Warnings'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
		print('\n')
        print('[Factions Warnings] Checking for updates...')
        print('')
        print('[Factions Warnings] Current version: ' .. CurrentVersion)
        print('[Factions Warnings] Updater version: ' .. NewestVersion)
        print('')
		if CurrentVersion ~= NewestVersion then
			print('[Factions Warnings] Your script is outdated!')
			print('')
            print('[Factions Warnings] CHANGELOG ' .. NewestVersion .. ':')
            print('')
            print(Changes)
            print('')
            print('[Factions Warnings] You are not running the newest stable version of Factions Chat. Please update: https://github.com/Jougito/Factions-Warnings')
		else
			print('[Factions Warnings] Your script is up-to-update')
		end
		print('\n')
	end)
end)
