-- moonloader spec admin + rapidfire + gui + save settings example

local json = require('json')
local sampev = require('sampev')
local encoding = require('encoding')
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local settings_path = 'moonloader/modpack_settings.json'
local settings = {
    rapidfire = true,
    spec_detect = true,
    -- تقدر تزيد إعدادات هنا
}

local is_speced = false
local spec_admin_id = nil

-- تحميل وحفظ الإعدادات من ملف JSON
local function loadSettings()
    local file = io.open(settings_path, "r")
    if file then
        local content = file:read("*a")
        file:close()
        local data = json.decode(content)
        if data then
            settings = data
        end
    end
end

local function saveSettings()
    local file = io.open(settings_path, "w+")
    if file then
        file:write(json.encode(settings))
        file:close()
    end
end

-- كشف إذا أدمين يتابعك
local function checkSpecAdmin()
    if not settings.spec_detect then return end
    local localId = sampGetPlayerId()
    for i = 0, 1000 do
        if sampev.isPlayerStreamedIn(i) and i ~= localId then
            local isSpec = sampev.isPlayerSpectating(i)
            local target = sampev.getSpectateTarget(i)
            if isSpec and target == localId then
                if not is_speced then
                    is_speced = true
                    spec_admin_id = i
                    sampAddChatMessage(u8:encode("[ModPack] Admin ID " .. i .. " started spectating you!"), 0xFF00FF00)
                end
                return
            end
        end
    end
    if is_speced then
        is_speced = false
        spec_admin_id = nil
        sampAddChatMessage(u8:encode("[ModPack] Admin stopped spectating."), 0xFFFFFF00)
    end
end

-- تفعيل rapid fire
local function rapidFire()
    if not settings.rapidfire then return end
    -- شفنا rapid fire بتغيير سرعة ضغط زر النار على كل السلاح
    if isSampAvailable() and sampIsLocalPlayerSpawned() then
        local weapon = sampGetLocalPlayerWeapon()
        if weapon > 0 then
            -- هنا نضغط زر إطلاق النار بسرعة (مثلاً بإرسال نقرات متتالية)
            -- مثال: محاكاة ضغط مستمر على زر الماوس الأيسر
            if not isKeyDown(VK_LBUTTON) then
                keyPress(VK_LBUTTON)
                wait(10)
                keyRelease(VK_LBUTTON)
            end
        end
    end
end

-- GUI مبسط بالـ imgui
local imgui = require('imgui')

local show_menu = false

function main()
    loadSettings()
    while true do
        wait(0)
        if wasKeyPressed(VK_F10) then
            show_menu = not show_menu
        end

        checkSpecAdmin()
        rapidFire()
    end
end

function imgui.OnDrawFrame()
    if not show_menu then return end
    imgui.Begin(u8:encode("ModPack Xtv - Menu"), true, imgui.WindowFlags.AlwaysAutoResize)

    local changed1, rapidfire_new = imgui.Checkbox(u8:encode("Rapid Fire"), settings.rapidfire)
    if changed1 then
        settings.rapidfire = rapidfire_new
        saveSettings()
    end

    local changed2, spec_new = imgui.Checkbox(u8:encode("Detect Spec Admin"), settings.spec_detect)
    if changed2 then
        settings.spec_detect = spec_new
        saveSettings()
    end

    imgui.Text(u8:encode("Press F10 to toggle this menu"))
    imgui.End()
end
