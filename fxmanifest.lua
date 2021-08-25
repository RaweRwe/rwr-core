fx_version "bodacious"

game "gta5"
author "rawe"

client_scripts {
    "config.lua",
    "client/rwr_*.lua",
    "commands/rwr_main.lua",
    
}

server_scripts {
    "config.lua",
    "server/rwr_*.lua",
    "commands/rwr_main.lua",
}

ui_page {
    'html/index.html'
}

files {
	'html/index.html',
	'html/main.js', 
	'html/style.css'
}