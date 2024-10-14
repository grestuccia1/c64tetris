// ----------------------------------- LEVELS LIBRARY -----------------------------------

LEVELS: {
    init:
        lda #0
        sta currentLevel
        sta transitionRowDelayTimer
        sta tempTransitionRowDelayTimer
        sta tempTransitionRowDelayTimerInMenu
        jsr LEVELS.increaseLevel
        jsr HUD.resetScore
        jsr HUD.resetLinesCounter
        rts

    increaseLevel:
        lda currentLevel
        clc
        adc #1
        sta currentLevel
        jsr setLinesNeededForNextLevel
        rts

    setLinesNeededForNextLevel:
        PushToStack()

        ldx currentLevel

        lda linesGoalPerLevel, x
        sta linesNeededForNextLevel

        lda tetriminoFallDelayPerLevel, x
        sta tetriminoFallDelay

        lda #0
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

    calculareTransitionRowMax:
        PushToStack()

        ldx #0

        jsr OUTPUT.getChar

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

        preloadLevelEnd:
            PopFromStack()
            rts
        
        preloadLevel4:
            LoadLevel(level4Length, level4X, level4Y, level4Color)
            PopFromStack()
            rts

        preloadLevel5:
            LoadLevel(level5Length, level5X, level5Y, level5Color)
            PopFromStack()
            rts

        preloadLevel6:
            LoadLevel(level6Length, level6X, level6Y, level6Color)
            PopFromStack()
            rts

        preloadLevel7:
            LoadLevel(level7Length, level7X, level7Y, level7Color)
            PopFromStack()
            rts

        preloadLevel8:
            LoadLevel(level8Length, level8X, level8Y, level8Color)
            PopFromStack()
            rts

        preloadLevel9:
            LoadLevel(level9Length, level9X, level9Y, level9Color)
            PopFromStack()
            rts

        preloadLevel10:
            LoadLevel(level10Length, level10X, level10Y, level10Color)
            PopFromStack()
            rts
}