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
        WriteText(TETROMINO_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, WHITE_COLOR)
        WriteText(CHANGE_MODE_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, WHITE_COLOR)
        WriteText(CHANGE_LEVEL_MESSAGE, HUD_TETRIS_TITLE_OPTIONS_X_POS, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 6, WHITE_COLOR)

        DrawChar(ARROW_RIGHT,HUD_TETRIS_TITLE_OPTIONS_Y_POS,HUD_TETRIS_TITLE_OPTIONS_X_POS-1,WHITE_COLOR)

        lda tetrominoWideMode
        cmp #1
        bne noWideModeStartUp
        WriteText(WIDE_MODE_MESSAGE, 18, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1)
        noWideModeStartUp:
        
        lda tetrominoHeight
        cmp #TETROMINO_HEIGHT_5X5
        bne no5X5ModeStartUp
        WriteText(TETROMINO_5X5_MESSAGE, 23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, 1)
        no5X5ModeStartUp:

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

        WriteText(REX_MESSAGE, 26, 24, 1)
        SetTextColor(32,14,10,8, WHITE_COLOR)

        jsr LEVELS.init
        jsr STATS.init

        //Turn on music
        lda #1
        sta playMusic

        PopFromStack()
        rts

    inMenuMode:
        PushToStack()

        jsr OUTPUT.drawCursor

        ldx #RASTER_TICK_2
        jsr CLOCK.tickStatus
        bne animatesFolkRussianDancer

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
            
        animatesFolkRussianDancer:
            ldx #RASTER_TICK_10
            jsr CLOCK.tickStatus
            bne noChangeColorInMenu

            AnimatesFolkRussianDancer()

        noChangeColorInMenu: 
            SetTextColorStored(23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, 1, 3)
            SetTextColorStored(18, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1, 6)
            SetTextColorStored(19, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 6, 1, 2)
            SetTextColorStored(25, 24, 1, 14)

            //Bottom right

            ldx #RASTER_TICK_5
            jsr CLOCK.tickStatus
            beq inMenuActionFire
            jmp inMenuNoLevel
            

            inMenuActionFire:

            jsr OUTPUT.animateArrow

            lda tetrominoDirection
			and #FIRE_AND_RELEASE
			cmp #FIRE_AND_RELEASE
            beq inMenuAction

            jmp inMenuNoLevel

            inMenuAction:
            ClearTetrominoDirection(FIRE_RELEASE)		

            lda drawCursorRow
			cmp #DRAW_CURSOR_ROW_START
            bne inMenuNoStart

            jsr TETROMINO.resetTetromino

            lda #GAME_MODE_PLAYING
            sta gameMode
            
            HideFolkRussianDancer()

            inMenuNoStart:

                lda drawCursorRow
                cmp #DRAW_CURSOR_ROW_TETROMINO
                bne inMenuNoTetromino

                lda tetrominoHeight
                cmp #TETROMINO_HEIGHT_4X4
                beq changeTo5X5

                lda #TETROMINO_HEIGHT_4X4
                sta tetrominoHeight

                lda #TETROMINO_MAX_4X4
                sta tetrominoMax

                WriteText(TETROMINO_4X4_MESSAGE, 23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, 1)

                jmp inMenuNoTetromino
                changeTo5X5:

                    lda #TETROMINO_HEIGHT_5X5
                    sta tetrominoHeight

                    lda #TETROMINO_MAX_5X5
                    sta tetrominoMax

                    WriteText(TETROMINO_5X5_MESSAGE, 23, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 2, 1)

            inMenuNoTetromino:
                lda drawCursorRow
                cmp #DRAW_CURSOR_ROW_MODE
                bne inMenuNoMode

                lda tetrominoWideMode
                eor #1
                sta tetrominoWideMode
                bne changeToWideMode

                lda #TETROMINO_COL_LAST
                sta tetrominoDynamicLastCol

                lda #TETROMINO_ROW_LENGTH
                sta tetrominoDynamicRowLength

                WriteText(NORMAL_MODE_MESSAGE, 18, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1)

                jmp inMenuNoMode
                changeToWideMode:

                    lda #TETROMINO_COL_LAST_WIDE_MODE
                    sta tetrominoDynamicLastCol

                    lda #TETROMINO_ROW_LENGTH_WIDE_MODE
                    sta tetrominoDynamicRowLength

                    WriteText(WIDE_MODE_MESSAGE, 18, HUD_TETRIS_TITLE_OPTIONS_Y_POS + 4, 1)

            inMenuNoMode:

                lda drawCursorRow
                cmp #DRAW_CURSOR_ROW_LEVEL
                bne inMenuNoLevel

            increaseLevelMenu:
                jsr LEVELS.increaseLevel

                lda currentLevel
                cmp #CHANGE_MAX_LEVEL
                bne drawCurrentLevel
                lda #0
                sta currentLevel
                jsr LEVELS.setLinesNeededForNextLevel

            drawCurrentLevel:    
                jsr HUD.startLevelCounter

            inMenuNoLevel:

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

        DebugBorder(GREY_COLOR)

        jsr TETROMINO.remove

        DebugBorder(ORANGE_COLOR)

        jsr TETROMINO.handle

        DebugBorder(YELLOW_COLOR)

        ClearTetrominoDirection(ALL_DIRECTIONS_NO_FIRE)
        lda gameMode
        cmp #GAME_MODE_PLAYING_READY
        bne justGameOver

        DebugBorder(BLUE_COLOR)

        jsr TETROMINO.change
        DebugBorder(GREEN_COLOR)
        jsr TETROMINO.draw

        DebugBorder(PURPLE_COLOR)

        ldx #RASTER_TICK_5
        jsr CLOCK.tickStatus
        bne justGameOver
        
        DebugBorder(CYAN_COLOR)

        jsr OUTPUT.animateBlock

        DebugBorder(WHITE_COLOR)

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

        lda tetrominoDirection
        and #FIRE_AND_RELEASE
        cmp #FIRE_AND_RELEASE
        bne inGameOverNoF1

        ClearTetrominoDirection(FIRE_RELEASE)		

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

        // Level post conditions
        jsr TETROMINO.postConditionsNewRandomTopBlock
        jsr TETROMINO.postConditionsMoveLinesUpClean
        
        NewTetromino()
        rts

}
