script_name('AntiDamage')
script_author('YourName')

function main()
    while not isSampAvailable() do wait(100) end

    while true do
        wait(100)
        if isCharOnFoot(PLAYER_PED) and isCharPlaying(PLAYER_PED) then
            setCharHealth(PLAYER_PED, 100.0)
        end
    end
end
