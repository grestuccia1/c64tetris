
// ----------------------------------- SYSTEM VARIABLES -----------------------------------

delayTimer1: .byte 0
delayTimer2: .byte 0

frameCounter: .byte 0

playMusic: .byte 0

cooldown_duration_value: .word (cooldown_duration * 1000 / 1024)  
