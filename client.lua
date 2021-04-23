local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local IsOpenGui = false
local pronto = false

local _type = 4 --[[ integer ]]

local posX = 0 --[[ number ]]
local posY = 0 --[[ number ]]
local posZ = 0 --[[ number ]]

local dirX = 0 --[[ number ]]
local dirY = 0 --[[ number ]]
local dirZ = 0 --[[ number ]]
local rotX = 0 ---[[ number ]] 
local rotY = 0 --[[ number ]]
local rotZ = 0 --[[ number ]]
local scaleX = 1 --[[ number ]]
local scaleY = 1 --[[ number ]]
local scaleZ = 1 --[[ number ]]
local red = 255 --[[ integer ]]
local green = 255 --[[ integer ]]
local blue = 255 --[[ integer ]]
local alpha = 255 --[[ integer ]]
local bobUpAndDown = 0 --[[ boolean ]]
local faceCamera = 0 --[[ boolean ]]
local p19 = 2 --[[ integer ]]
local rotate = 1 --[[ boolean ]]
local textureDict = "" --[[ string ]]
local textureName = "" --[[ string ]]
local drawOnEnts = 0 --[[ boolean ]]


local meta = " DrawMarker(%d, %.4f, %.4f,  %.4f, %.4f, %.4f,  %.4f, %.4f, %.4f,  %.4f, %.4f, %.4f,  %.4f, %d, %d, %d, %d, 0, 0, 0, %d)"



RegisterNetEvent('suel:DrawMarkerInit')
AddEventHandler('suel:DrawMarkerInit', function()
    if not IsOpenGui then
        OpenGUI()
    end
end)

function OpenGUI()
   
    SendNUIMessage({
        abrirGui = true,
    })
    SetNuiFocus(true, true)
    IsOpenGui = true
end

function CloseGUI()
    IsOpenGui = false
    pronto = false
    SetNuiFocus(false, false)
end

RegisterNUICallback('closeui', function(data, cb)
    CloseGUI()
end)

function BoolToInt(v)
    if v then
        return 1
    else
        return 0
    end
end

function parseInt(n)
    local b = tonumber(n)
    if b ~= nil then
        return b
    end
    return 0
end


RegisterNUICallback('updateblip', function(data, cb)    
    

    if parseInt(data.posicaoX) then
        posX = data.posicaoX
    end

    if parseInt(data.posicaoY) then
        posY = data.posicaoY
    end

    if parseInt(data.posicaoZ) then
        posZ = data.posicaoZ
    end

    if parseInt(data.rotacaoX) then
        rotX = data.rotacaoX
    end

    if parseInt(data.rotacaoY) then
        rotY = data.rotacaoY
    end

    if parseInt(data.rotacaoZ) then
        rotZ = data.rotacaoZ
    end

    if parseInt(data.direcaoX) then
        dirX = data.direcaoX
    end

    if parseInt(data.direcaoY) then
        dirY = data.direcaoY
    end

    if parseInt(data.direcaoZ) then
        dirZ = data.direcaoZ
    end
    
    if data.blipId then
        _type = parseInt(data.blipId)
    end
    
    if (data.escalaX) then
        scaleX = parseInt(data.escalaX)
    end
    
    if (data.escalaY) then
        scaleY = parseInt(data.escalaY)
    end
    
    if (data.escalaZ) then
        scaleZ = parseInt(data.escalaZ)
    end
    
    if data.corVermelha then
        red = parseInt(data.corVermelha)
    end

    if data.corVermelha then
        green = parseInt(data.corVerde)
    end

    if data.corAzul then
        blue = parseInt(data.corAzul)
    end
    
    if data.corAlpha then
        alpha = parseInt(data.corAlpha)
    end
   
    if data.rotate then
        rotate = data.rotate
    end
    cb("ok")
end)

function CreateMarker()
    SendNUIMessage({
        fecharGui = true
    })
    local meta = string.format("DrawMarker(%d, coordX, coordY,  coordZ, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %d, %d, %d, %d, 0, 0, 0, %d)", 
        _type, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, rotate)
    TriggerServerEvent("suel::drawmarkercallback", meta)
end

RegisterNUICallback('criarblip', function(data, cb)
    CreateMarker()
end)


Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Citizen.Wait(5)
        if IsOpenGui == true then
            local player = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(player))
            local fv = GetEntityForwardVector(player)
            local vr = vector3( x, y, z ) + (fv * 2)  
            DrawMarker(_type, vr.x-0.38, vr.y+0.38, vr.z, dirX,dirY,dirZ, rotX,rotY,rotZ, scaleX ,scaleY, scaleZ, red, green, blue, alpha, 0,0,0, rotate)
        end
    end
end)
