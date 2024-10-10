// ----------------------------------- LEVELS LIBRARY -----------------------------------

LEVELS: {
    init:
        lda #0
        sta currentLevel
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
            jsr GAME.changeLevel
            jmp LevelNotComplete

        LevelNotComplete:
        PopFromStack()
        rts
}