script_name("GetPlayerID")
script_author("ChatGPT")

require "sampfuncs"
require "samp.events"

function main()
    repeat wait(100) until isSampAvailable()

    sampRegisterChatCommand("getid", getPlayerIdCommand)
end

function getPlayerIdCommand(playerName)
    if playerName == nil or playerName == "" then
        sampAddChatMessage("Usage: /getid [playername]", 0xFFFF0000)
        return
    end

    for i = 0, 1000 do
        if sampIsPlayerConnected(i) then
            local name = sampGetPlayerNickname(i)
            if name:lower() == playerName:lower() then
                sampAddChatMessage(string.format("Player %s has ID: %d", name, i), 0x00FF00)
                return
            end
        end
    end

    sampAddChatMessage("Player not found!", 0xFF0000)
end
