local sampev = require 'samp.events'
local sampfuncs = require 'sampfuncs'

function main()
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("getid", function(args)
        local playerName = args
        if playerName == "" then
            sampAddChatMessage("Usage: /getid [playername]", 0xFFFF0000)
            return
        end

        local playerId = -1
        for i = 0, 1000 do
            local name = sampGetPlayerNickname(i)
            if name and name:lower() == playerName:lower() then
                playerId = i
                break
            end
        end

        if playerId == -1 then
            sampAddChatMessage("Player not found!", 0xFFFF0000)
        else
            sampAddChatMessage(("Player %s has ID: %d"):format(playerName, playerId), 0xFF00FF00)
        end
    end)
end
