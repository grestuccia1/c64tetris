// ----------------------------------- GAME LIBRARY -----------------------------------

GAME:
{
    init:
        lda #GAME_START_UP
        sta gameMode
        rts

    startGameMenu:
        lda #GAME_MODE_MENU
        sta gameMode
        rts

    goToMenu:
        PushToStack()

        lda #GAME_MODE_MENU_READY
        sta gameMode

        jsr SCREEN_CLEAR
        LoadCharColorMap(HUD_TETRIS_TITLE_ADDRESS, HUD_TETRIS_TITLE_COLORS_ADDRESS, 3, 6, 35, 7)

        WriteText(START_MESSAGE, 4, 16, 1)
        WriteText(MUSIC_ON_OFF_MESSAGE, 4, 18, 1)
        WriteText(WIDE_MODE_MESSAGE, 4, 20, 1)
        WriteText(CHANGE_LEVEL_MESSAGE, 4, 22, 1)
        WriteText(START_LEVEL_NUMBER, 4, 24, 1)

        ShowFolkRussianDancer(77, 100)

        //Top left
        DrawTetrimino(1, 0, -1, 3)
        DrawTetrimino(5, 0, 1, 0)

        //Bottom left
        DrawTetrimino(2, 22, -1, 1)
        DrawTetrimino(4, 22, 1, 1)
        
        //Top right        
        DrawTetrimino(3, -1, 37, 0)
        DrawTetrimino(0, 1, 36, 0)

        //Bottom right
        LoadCharMap(HUD_REX_ADDRESS,31,14,9,10)

        WriteText(REX_MESSAGE, 32, 24, 1)
        SetTextColor(32,14,10,8, WHITE_COLOR)

        jsr LEVELS.init
        jsr STATS.init

        lda #1
        sta playMusic

        PopFromStack()
        rts

    inMenuMode:
        PushToStack()

        ldx tempTransitionColorDelayTimer
        beq inMenuModeTransitionRowDelayTimerReached
        dec tempTransitionColorDelayTimer
        jmp noChangeColorInMenu

            inMenuModeTransitionRowDelayTimerReached:
                lda #TRANSITION_COLOR_DELAY
                sta tempTransitionColorDelayTimer
            
        AnimatesFolkRussianDancer()

continueColorTransition:
        inc tempColorTransition
        ldx tempColorTransition
        cpx #MAX_COLOR_TRANSITION
        bne nextColorTransitionInMenu
        lda #0
        sta tempColorTransition

        nextColorTransitionInMenu:
	    lda rowTransitionColor, x
	    sta textColor
        
        noChangeColorInMenu: 
        SetTextColorStored(32, 24, 1, 8)

        //Bottom right

        jsr SCNKEY
        jsr GETIN
        cmp #KEY_F1
        bne inMenuNoF1

        lda #GAME_MODE_PLAYING
        sta gameMode
        
        HideFolkRussianDancer()

        inMenuNoF1:

            cmp #KEY_F3
            bne inMenuNoF3

            lda playMusic
            eor #1
            sta playMusic
            bne turnOffMusic
            lda #IS_VOLUME_OFF
            sta MUSIC_VOLUME
            jmp inMenuNoF3

            turnOffMusic:
                    lda #IS_VOLUME_ON
                    sta MUSIC_VOLUME


        inMenuNoF3:

            cmp #KEY_F5
            bne inMenuNoF5

            lda tetriminoWideMode
            eor #1
            sta tetriminoWideMode
            bne changeToWideMode

            lda #TETRIMINO_COL_LAST
            sta tetriminoDynamicLastCol

            lda #TETRIMINO_ROW_LENGTH
            sta tetriminoDynamicRowLENGTH

            WriteText(WIDE_MODE_MESSAGE, 4, 20, 1)

            jmp inMenuNoF5
            changeToWideMode:

                lda #TETRIMINO_COL_LAST_WIDE_MODE
                sta tetriminoDynamicLastCol

                lda #TETRIMINO_ROW_LENGTH_WIDE_MODE
                sta tetriminoDynamicRowLENGTH

                WriteText(NORMAL_MODE_MESSAGE, 4, 20, 1)

        inMenuNoF5:

            cmp #KEY_F7
            bne inMenuNoF7

        increaseLevelMenu:
            jsr LEVELS.increaseLevel

            lda currentLevel
            cmp #CHANGE_MAX_LEVEL
            bne drawCurrentLevel
            lda #0
            sta currentLevel
            jmp increaseLevelMenu

        drawCurrentLevel:    
            jsr HUD.startLevelCounter

        inMenuNoF7:

        PopFromStack()
        rts

    goToPlaying:
        PushToStack()

        lda #GAME_MODE_PLAYING_READY
        sta gameMode
        LoadFullScreen(HUD_GAMEPLAY_ADDRESS)
        SetTextColor(17,12,1,6,1)
        SetTextColor(17,16,1,6,1)
        SetTextColor(19,20,1,2,1)
        SetTextColor(19,24,1,2,1)

        lda tetriminoWideMode
        beq noWideMode
        FillRectangle(11,0,24,1,SPACE)
        FillRectangle(TETRIMINO_COL_LAST_WIDE_MODE,0,24,1,WALL)
        FillRectangle(0,24,1,TETRIMINO_COL_LAST_WIDE_MODE + 1,WALL)
        
        noWideMode:
        
        jsr STATS.applyColors
        jsr HUD.updateLevelCounter
        jsr HUD.updateLinesLeftCounter
        jsr LEVELS.preloadLevel
        
        NewTetrimino()
        
        PopFromStack()
        rts

    inPlayingMode:
        PushToStack()

        jsr TETRIMINO.remove
        jsr TETRIMINO.handle
        ClearTetriminoDirection(ALL_DIRECTIONS_NO_FIRE)
        lda gameMode
        cmp #GAME_MODE_PLAYING_READY
        bne justGameOver

        jsr TETRIMINO.change
        jsr TETRIMINO.draw

        justGameOver:
        
        PopFromStack()
        rts

    goToGameOver:
        PushToStack()

        lda #GAME_MODE_GAME_OVER_READY
        sta gameMode
        
        jsr SCREEN_CLEAR
        LoadCharColorMap(HUD_GAME_OVER_TITLE_ADDRESS, HUD_GAME_OVER_TITLE_COLORS_ADDRESS, 1, 3, 39, 5)
        WriteText(GAME_OVER_MESSAGE, 9, 20, 1)

        PopFromStack()
        rts

    changeLevel:
        PushToStack() 

        jsr LEVELS.increaseLevel
        jsr HUD.updateLevelCounter
        jsr HUD.updateLinesLeftCounter

        lda #GAME_MODE_CHANGE_LEVEL_READY
        sta gameMode

        PopFromStack()
        rts

    inChangeLevelMode:
        PushToStack()

        jsr GAME.clearContainer
        //TODO: reset stats? (by level or by game over)

        jsr LEVELS.preloadLevel
        
        lda #GAME_MODE_PLAYING_READY
        sta gameMode

        PopFromStack()
        rts    

    clearContainer:
        PushToStack()

        lda #TETRIMINO_COL_FIRST
        sta charCol
        lda #TETRIMINO_ROW_FIRST
        sta charRow
        lda tetriminoDynamicRowLENGTH
        sta textLENGTH
        lda #TETRIMINO_CONTAINER_HEIGHT
        sta textHeight
        lda #SPACE
        sta textChar

        jsr OUTPUT.fillText

        PopFromStack()
        rts    

    inGameOverMode:
        PushToStack()

        jsr SCNKEY
        jsr GETIN
        cmp #KEY_F1
        bne inGameOverNoF1

        lda #GAME_MODE_MENU
        sta gameMode

inGameOverNoF1:

        PopFromStack()
        rts


    createNewTestTetrimino:
        PushToStack()

        lda tetriminoRow
        cmp #TETRIMINO_ROW_START
        bne noGameOver

        jsr GAME.goToGameOver
        jmp createNewTestTetriminoDone

        noGameOver:
            jsr TETRIMINO.draw

            jsr TETRIMINO.checkCompleteLines

            jsr STATS.increaseTetrimino

            jsr MATH.generateRandomBelow10
            sta tempScore
            UpdateScore(5)

            jsr TETRIMINO.speedUp

            jsr TETRIMINO.resetFall
            
            NewTetrimino()

        createNewTestTetriminoDone:
            
            PopFromStack()
            rts
}
