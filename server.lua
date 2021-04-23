local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterCommand('suelmarker', function(source, args, rawCommand)
    TriggerClientEvent('suel:DrawMarkerInit', source)
end)

RegisterNetEvent('suel::drawmarkercallback')
AddEventHandler('suel::drawmarkercallback', function(a)
    local source = source
    vRP.prompt(source, "Função: ", a)
end)