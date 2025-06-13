local imgui = require('imgui')
local encoding = require('encoding')
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local show_menu = false

function main()
    while not isSampAvailable() do wait(100) end
    while not sampIsLocalPlayerSpawned() do wait(100) end
    sampAddChatMessage(u8:encode("[TestGUI] Script loaded! اضغط F10 لفتح القائمة."), 0xFF00FF00)

    while true do
        wait(0)
        if wasKeyPressed(0x79) then -- F10
            show_menu = not show_menu
        end
    end
end

function imgui.OnDrawFrame()
    if not show_menu then return end
    imgui.Begin(u8:encode("Test GUI"), true, imgui.WindowFlags.AlwaysAutoResize)
    imgui.Text(u8:encode("إذا شفت هالقائمة، كل شيء شغال!"))
    imgui.End()
end
