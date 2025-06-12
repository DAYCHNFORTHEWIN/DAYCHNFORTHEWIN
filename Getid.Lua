local samp = require 'samp.events'

function getPlayerIdByName(name)
    for i = 0, 1000 do
        local playerName = samp.getPlayerName(i)
        if playerName and playerName:lower() == name:lower() then
            return i
        end
    end
    return -1
end

function main()
    while true do
        local id = getPlayerIdByName("playerNameHere")
        if id ~= -1 then
            print(("ID for player is %d"):format(id))
        else
            print("Player not found.")
        end
        wait(5000)
    end
end
