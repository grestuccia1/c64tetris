// ----------------------------------- LEVELS LIBRARY -----------------------------------

LEVELS: {
    init:
        lda #LEVEL_RESET
        sta currentLevel

        jsr LEVELS.increaseLevel
        jsr HUD.resetScore
        jsr HUD.resetLinesCounter
        rts

    increaseLevel:
        lda currentLevel
        clc
        adc #MOVE_NEXT_LEVEL_FACTOR
        sta currentLevel
        jsr setLinesNeededForNextLevel
        rts

    setLinesNeededForNextLevel:
        PushToStack()

        ldx currentLevel

        lda linesGoalPerLevel, x
        sta linesNeededForNextLevel

        lda tetrominoFallDelayPerLevel, x
        sta tetrominoFallDelay

        lda #RESET_LINES_FOR_LEVEL
        sta linesForLevel
        sta transitionRow

        PopFromStack()
        rts

    checkCompleteLevel:
        PushToStack()
            lda linesForLevel

            lda linesNeededForNextLevel
            cmp linesForLevel
            beq LevelIsComplete
            bcc LevelIsComplete 
            jmp LevelNotComplete

        LevelIsComplete:
            jsr COLLITION.lineColition

            lda #GAME_MODE_CHANGE_LEVEL
            sta gameMode

            jmp LevelNotComplete

        LevelNotComplete:
        PopFromStack()
        rts

    preloadLevel:
        PushToStack()

        lda currentLevel
        cmp #4
        beq preloadLevel4_Intermediate

        cmp #5
        beq preloadLevel5_Intermediate

        cmp #6
        beq preloadLevel6_Intermediate

        cmp #7
        beq preloadLevel7_Intermediate

        cmp #8
        beq preloadLevel8_Intermediate

        cmp #9
        beq preloadLevel9_Intermediate

        cmp #10
        beq preloadLevel10_Intermediate

        cmp #11
        beq preloadLevel11_Intermediate

        cmp #12
        beq preloadLevel12_Intermediate

        jmp preloadLevelEnd

        preloadLevel4_Intermediate:
            jmp preloadLevel4

        preloadLevel5_Intermediate:
            jmp preloadLevel5

        preloadLevel6_Intermediate:
            jmp preloadLevel6

        preloadLevel7_Intermediate:
            jmp preloadLevel7

        preloadLevel8_Intermediate:
            jmp preloadLevel8

        preloadLevel9_Intermediate:
            jmp preloadLevel9

        preloadLevel10_Intermediate:
            jmp preloadLevel10

        preloadLevel11_Intermediate:
            jmp preloadLevel11

        preloadLevel12_Intermediate:
            jmp preloadLevel12

        preloadLevelEnd:
            
            jsr COLLITION.lineColition
            
            PopFromStack()
            rts
        
        preloadLevel4:
            LoadLevel(level4Length, level4X, level4Y, level4Color)
            jmp preloadLevelEnd

        preloadLevel5:
            LoadLevel(level5Length, level5X, level5Y, level5Color)
            jmp preloadLevelEnd

        preloadLevel6:
            LoadLevel(level6Length, level6X, level6Y, level6Color)
            jmp preloadLevelEnd

        preloadLevel7:
            LoadLevel(level7Length, level7X, level7Y, level7Color)
            jmp preloadLevelEnd

        preloadLevel8:
            LoadLevel(level8Length, level8X, level8Y, level8Color)
            jmp preloadLevelEnd

        preloadLevel9:
            LoadLevel(level9Length, level9X, level9Y, level9Color)
            jmp preloadLevelEnd

        preloadLevel10:
            LoadLevel(level10Length, level10X, level10Y, level10Color)
            jmp preloadLevelEnd

        preloadLevel11:
            LoadLevel(level11Length, level11X, level11Y, level11Color)
            jmp preloadLevelEnd

        preloadLevel12:
            LoadLevel(level12Length, level12X, level12Y, level12Color)
            jmp preloadLevelEnd
}