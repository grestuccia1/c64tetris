// ----------------------------------- LEVELS TABLES -----------------------------------

linesGoalPerLevel:
    .byte 0
    .byte 1     // Level: 1
    .byte 2    
    .byte 5    
    .byte 10    
    .byte 12    // Level: 5
    .byte 10    
    .byte 13    
    .byte 16    
    .byte 12    
    .byte 15    // Level: 10
    .byte 18    
    .byte 12

tetriminoFallDelayPerLevel:
    .byte 0    
    .byte 50    // Level: 1
    .byte 50
    .byte 50    
    .byte 45    
    .byte 40    // Level: 5    
    .byte 35    
    .byte 35    
    .byte 35    
    .byte 35    
    .byte 35    // Level: 10  
    .byte 20    
    .byte 20

tetriminoCountPerLevelToSpeedUp:
    .byte 0    
    .byte 20    // Level: 1
    .byte 20    
    .byte 20    
    .byte 20    
    .byte 20    // Level: 5 
    .byte 20
    .byte 20
    .byte 10    
    .byte 10    
    .byte 10    // Level: 10    
    .byte 10    
    .byte 10