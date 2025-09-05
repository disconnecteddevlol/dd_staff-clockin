fx_version 'cerulean'
game 'gta5'

author 'disconnected Dev'
description 'Staff Duty System | https://github.com/disconnecteddevlol'
version '1.0.0'

lua54 'yes'

-- ox_lib dependency
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
