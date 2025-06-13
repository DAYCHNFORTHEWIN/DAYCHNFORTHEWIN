script_name("Spec Detector + Danger Alarm")
script_author("ChatGPT")

require 'sampfuncs'
require 'samp.events'

local spectatingPlayers = {}
local detectionRange = 50.0 -- meters

function main()
    repeat wait(100) until isSampAvailable() and isSampLoaded()

    sampAddChatMessage("{FF4444}[ALERT] Spec Detector with Danger Sound Loaded!", 0xFF4444)

    while true do
        wait(1000)
        local myChar = PLAYER_PED
        local myX, myY, myZ = getCharCoordinates(myChar)

        for i = 0, sampGetMaxPlayerId() do
            if sampIsPlayerConnected(i) and not sampIsPlayerNpc(i) then
                local isStreamed, playerPed = sampGetCharHandleBySampPlayerId(i)
                if isStreamed and playerPed ~= 0 then
                    local x, y, z = getCharCoordinates(playerPed)
                    local dist = getDistanceBetweenCoords3d(myX, myY, myZ, x, y, z)

                    if dist <= detectionRange and not isCharInAnyCar(playerPed) then
                        if isCharStopped(playerPed) and not isCharOnScreen(playerPed) then
                            local name = sampGetPlayerNickname(i)
                            if not spectatingPlayers[i] then
                                spectatingPlayers[i] = true
                                sampAddChatMessage(string.format("{FF0000}[SPEC ALERT]{FFFFFF} Player may be specting you: %s (ID %d)", name, i), 0xFF0000)
                                playSound("C:\\Windows\\Media\\spec_alert.wav") -- استبدل المسار إذا لازم
                            end
                        end
                    else
                        spectatingPlayers[i] = nil
                    end
                end
            end
        end
    end
end
