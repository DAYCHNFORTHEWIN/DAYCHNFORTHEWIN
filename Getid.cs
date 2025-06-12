{$CLEO}
0000:

repeat
    wait 0
until 0AFA: is_samp_available

while true
    wait 0
    if 0ADC: test_cheat "GETID"
    then
        0AD1: show_formatted_text "Type: /getid [PlayerName]" time 3000
        wait 3000
        0AD4: 1@ = scan_string "%s"        0AD2: 0@ = get_label_pointer @InputName
        0AD3: 1@ = format "getid %s"
        0B6B: samp cmd_ret = register_client_command "getid" @FindID
    end
end

:FindID
0AD4: 31@ = scan_string "%s"
for 2@ = 0 to 999
    if 0A8C: 3@ = allocate_memory_size 260
    then
        0B36: samp 3@ = get_player_nickname 2@
        if 0C29: strcmp string1 3@ string2 31@
        then
            0AF8: "Player %s has ID: %d" 31@ 2@
            0AB1: call_scm_func @FreeMem 1 3@
            0AB2: ret 1
        end
        0AB1: call_scm_func @FreeMem 1 3@
    end
end
0AF8: "Player %s not found." 31@
0AB2: ret 1

:FreeMem
0A8D: free_memory 0@
0AB2: ret 0
