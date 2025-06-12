local sampev = require 'lib.samp.events'
local memory = require 'memory'
local inicfg = require 'inicfg'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local isAdmin = false -- لازم تحدد متى اللاعب admin (ممكن عن طريق امر او check حساب)

-- استدعاء امر getid
function onChatCommand(cmd)
    local args = {}
    for word in cmd:gmatch("%S+") do table.insert(args, word) end
    if args[1] == "getid" and args[2] then
        if not isAdmin then
            sampAddChatMessage("{FF0000}انت مش أدمن!", -1)
            return true
        end

        local playerName = args[2]
        sampSendChat("/id " .. playerName)
        return true
    end
    return false
end

-- رصد الرد على /id
function onChatMessage(color, text)
    -- مثال الرد: "[SERVER]: Player Ahmed has ID 12."
    -- لازم تضبطها حسب رد السيرفر عندك
    if text:find("has ID") then
        -- نبحث على ID داخل النص
        local id = text:match("ID (%d+)")
        if id then
            sampAddChatMessage("{00FF00}ID اللاعب هو: " .. id, -1)
        end
        return true
    end
    return false
end

function main()
    -- هنا تعيين isAdmin على حسب حالتك (ممكن تركبها بناء على nick، او check rank...)
    isAdmin = true -- فقط لتجربة

    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("{00FFFF}GetID script loaded! اكتب /getid اسم_اللاعب", -1)

    while true do
        wait(0)
        sampProcessChatCommand("getid", onChatCommand)
    end
end

-- تعاريف حدث الشات
function sampev.onChatMessage(color, text)
    return onChatMessage(color, text)
end
