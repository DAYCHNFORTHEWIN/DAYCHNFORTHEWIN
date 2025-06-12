{$CLEO}
0000:  

repeat
    wait 0
until 0AFA:  is_samp_available

while true
    wait 0
    if 0ADC:   test_cheat "GETID" : /getid name
    then
        0AD4: 1@ = scan_string "%s"
        for 2@ = 0 to 999
            if 0A8C:  3@ = allocate_memory_size 260
            then
                0B36: samp 3@ = get_player_nickname 2@
                if 0C29: strcmp string1 3@ string2 1@  
                then
                    0AF8: "Player %s has ID: %d" 1@ 2@
                    0AB1: call_scm_func @FreeMem 1 3@
                    break
                end
                0AB1: call_scm_func @FreeMem 1 3@
            end
        end
    end
end

:FreeMem
0A8D: free_memory 0@ 
0AB2: ret 0
