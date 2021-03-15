------------------------------
-- Sistema de avisos InGame --
--       por Jougito        --
------------------------------

Config              = {}

Config.eCommand     = "entorno" -- Comando Entorno
Config.aCommand     = "auxilio" -- Comando Auxilio
Config.mCommand     = "mecanico" -- Comando Mecánico
Config.tCommand     = "taxi" -- Comando Taxi
Config.bCommand     = "badubar" -- Comando Badu-Bar

Config.eName        = "Entorno" -- Título Entorno
Config.aName        = "Auxilio" -- Título Auxilio
Config.mName        = "Mecánico" -- Título Entorno
Config.tName        = "Taxi" -- Título Auxilio
Config.bName        = "Badu-Bar" -- Título Badu-Bar

Config.bAccept      = 121 -- Botón para aceptar GPS
Config.bCancel      = nil-- Botón para cancelar GPS

Config.eColour      = { 255, 150, 0 } -- Color del Entorno (Naranja)
Config.aColour      = { 255, 0, 0 } -- Color del Auxilio (Rojo)
Config.mColour      = { 155, 0, 150 } -- Color del Mecánico (Morado)
Config.tColour      = { 255, 235, 0 } -- Color del Taxi (Amarillo)
Config.bColour      = { 0, 255, 155 } -- Color del Badu-Bar (Verde)
Config.oColour      = { 150, 150, 150 } -- Color del OOC (Gris)

Config.eIcon        = 304 -- Icono del Entorno
Config.aIcon        = 153 -- Icono del Auxilio
Config.mIcon        = 643 -- Icono del Mecánico
Config.tIcon        = 280 -- Icono del Taxi
Config.bIcon        = 106 -- Icono del Badu-Bar

Config.eIconColour  = 3 -- Color icono del Entorno
Config.aIconColour  = 2 -- Color icono del Auxilio
Config.mIconColour  = 27 -- Color icono del Mecánico
Config.tIconColour  = 46 -- Color icono del Taxi
Config.bIconColour  = 15 -- Color icono del Badu-Bar

Config.eIconScale   = 0.75 -- Tamaño icono del Entorno
Config.aIconScale   = 1.0 -- Tamaño icono del Auxilio
Config.mIconScale   = 0.85 -- Tamaño icono del Mecánico
Config.tIconScale   = 1.0 -- Tamaño icono del Taxi
Config.bIconScale   = 0.75 -- Tamaño icono del Badu-Bar

Config.eJob         = "police" -- Nombre trabajo del Entorno
Config.aJob         = "ambulance" -- Nombre trabajo del Auxilio
Config.mJob         = "mechanic" -- Nombre trabajo del Mecánico
Config.tJob         = "taxi" -- Nombre trabajo del Taxi
Config.bJob         = "badubar" -- Nombre trabajo del Badu-Bar

Config.bTime        = 300 -- Tiempo en desaparecer los avisos en segundos
Config.pRange       = 10 -- Distancia máxima para el aviso de proximidad
Config.pName        = false -- Habilita si se muestra el nombre de usuario en el aviso de proximidad o solo la ID
Config.JouBot       = false -- Habilita si el comando es registrado por el script JouBot (Necesario tener instalado JouBot)
Config.osInfinity   = false -- Activar si usas OneSync Infinity para evitar errores de proximidad
