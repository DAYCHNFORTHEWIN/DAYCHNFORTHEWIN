local moonloader = require('moonloader')
local sampfuncs = require('sampfuncs')

local soundPath = 'spec_alert.mp3' -- لازم تحط ملف الصوت بنفس الاسم

function main()
    if not isSampfuncsLoaded() then
        sampAddChatMessage('sampfuncs not loaded.', 0xFF0000)
        return
    end

    while true do
        wait(1000)
        if sampIsPlayerSpectating() then
            sampAddChatMessage('{FF0000}⚠ شخص قاعد يعمللك spectate ⚠', 0xFF0000)
            if doesFileExist(soundPath) then
                playSound(soundPath)
            else
                sampAddChatMessage('{FF0000}⚠ الصوت spec_alert.mp3 مفقود!', 0xFF0000)
            end
            wait(10000)
        end
    end
end
