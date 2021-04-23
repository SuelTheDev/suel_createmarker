fx_version "adamant"
game "gta5"

name "Suel DrawMaker GUI"
description "Permite a criação de Marker com GUI"
author "Swellington Soares (swellington.santos@gmail.com)"
version "1.0"

ui_page "nui/index.html"

files {
    "nui/index.html",
    "nui/style.css",
    "nui/vue.js",
}

client_scripts {
    '@vrp/lib/utils.lua',
    "client.lua",
}

server_scripts {
    '@vrp/lib/utils.lua',
    "server.lua",
}