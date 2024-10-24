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

        WriteText(START_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS, WHITE_COLOR)
        WriteText(MUSIC_ON_OFF_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, WHITE_COLOR)
        WriteText(CHANGE_MODE_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, WHITE_COLOR)
        WriteText(CHANGE_LEVEL_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 6, WHITE_COLOR)

        ShowFolkRussianDancer(77, 100)

        //Top left
        DrawTetromino(1, 0, -1, 3)
        DrawTetromino(5, 0, 1, 0)

        //Bottom left
        DrawTetromino(2, 22, -1, 1)
        DrawTetromino(4, 22, 1, 1)
        
        //Top right        
        DrawTetromino(3, -1, 37, 0)
        DrawTetromino(0, 1, 36, 0)

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
        SetTextColorStored(23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1, 6)
        SetTextColorStored(24, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 6, 1, 2)
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

            lda tetrominoWideMode
            eor #1
            sta tetrominoWideMode
            bne changeToWideMode

            lda #TETROMINO_COL_LAST
            sta tetrominoDynamicLastCol

            lda #TETROMINO_ROW_LENGTH
            sta tetrominoDynamicRowLength

            WriteText(NORMAL_MODE_MESSAGE, 23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1)

            jmp inMenuNoF5
            changeToWideMode:

                lda #TETROMINO_COL_LAST_WIDE_MODE
                sta tetrominoDynamicLastCol

                lda #TETROMINO_ROW_LENGTH_WIDE_MODE
                sta tetrominoDynamicRowLength

                WriteText(WIDE_MODE_MESSAGE, 23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1)

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
        SetTextColor(HUD_CLOCK_X_POS,HUD_CLOCK_Y_POS,1,6,WHITE_COLOR)

        SetTextColor(HUD_SCORE_X_POS,HUD_SCORE_Y_POS,1,HUD_SCORE_DIGITS,WHITE_COLOR)
        SetTextColor(HUD_LINES_X_POS,HUD_LINES_Y_POS,1,HUD_LINES_DIGITS,WHITE_COLOR)
        SetTextColor(HUD_LEVEL_X_POS,HUD_LEVEL_Y_POS,1,HUD_LEVEL_DIGITS,WHITE_COLOR)
        SetTextColor(HUD_LINES_LEFT_X_POS,HUD_LINES_LEFT_Y_POS,1,HUD_LINES_LEFT_DIGITS,WHITE_COLOR)

        lda tetrominoWideMode
        beq noWideMode
        FillRectangle(11,0,24,1,SPACE)
        FillRectangle(TETROMINO_COL_LAST_WIDE_MODE,0,HUD_STATS_POS_Y,1,WALL)
        FillRectangle(0,24,1,TETROMINO_COL_LAST_WIDE_MODE + 1,WALL)
        
        noWideMode:
        
        ldx tetrominoHeight
		cpx #TETROMINO_HEIGHT_4X4
		beq endLoad5X5HudStats
            LoadCharMap(HUD_5X5_STATS_ADDRESS,HUD_STATS_POS_X_X5,HUD_STATS_POS_Y,TETROMINO_MAX_5X5,1)
        endLoad5X5HudStats:

        jsr STATS.applyColors
        jsr HUD.updateLevelCounter
        jsr HUD.updateLinesLeftCounter
        jsr LEVELS.preloadLevel
        jsr CLOCK.start

        NewTetromino()
        
        PopFromStack()
        rts

    inPlayingMode:
        PushToStack()

        jsr TETROMINO.remove
        jsr TETROMINO.handle
        ClearTetrominoDirection(ALL_DIRECTIONS_NO_FIRE)
        lda gameMode
        cmp #GAME_MODE_PLAYING_READY
        bne justGameOver

        jsr TETROMINO.change
        jsr TETROMINO.draw

        justGameOver:
        
        PopFromStack()
        rts

    goToGameOver:
        PushToStack()

        jsr CLOCK.stop

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

        lda #TETROMINO_COL_FIRST
        sta charCol
        lda #TETROMINO_ROW_FIRST
        sta charRow
        lda tetrominoDynamicRowLength
        sta textLength
        lda #TETROMINO_CONTAINER_HEIGHT
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

nextTetromino:
        jsr STATS.increaseTetromino
        jsr MATH.generateRandomBelow10
        sta tempScore
        UpdateScore(5)

        jsr TETROMINO.speedUp

        jsr TETROMINO.resetFall
        
        NewTetromino()
        rts

    createNewTestTetromino:
        PushToStack()

        lda tetrominoRow
        cmp #TETROMINO_ROW_START
        bne noGameOver

        jsr GAME.goToGameOver
        jmp createNewTestTetrominoDone

        noGameOver:
            jsr TETROMINO.draw

            lda #GAME_MODE_DELELE_LINE
            sta gameMode
            
        createNewTestTetrominoDone:
            
            PopFromStack()
            rts
}
