// ----------------------------------- GAME LIBRARY -----------------------------------

GAME:
{
    init:
        lda #GAME_MODE_MENU
        sta gameMode
    rts

    goToMenu:
        PushToStack()

        lda #GAME_MODE_MENU_READY
        sta gameMode

        jsr SCREEN_CLEAR
        LoadCharColorMap(HUD_TETRIS_TITLE_ADDRESS, HUD_TETRIS_TITLE_COLORS_ADDRESS, 3, 1, 35, 7)
        WriteText(START_MESSAGE, 9, 21, 1)

        PopFromStack()
        rts

    inMenuMode:
        PushToStack()

        jsr SCNKEY
        jsr GETIN
        cmp #KEY_F1
        bne inMenuNoF1

        lda #GAME_MODE_PLAYING
        sta gameMode

        inMenuNoF1:

        PopFromStack()
        rts

    goToPlaying:
        PushToStack()

        lda #GAME_MODE_PLAYING_READY
        sta gameMode
        LoadFullScreen(HUD_GAMEPLAY_ADDRESS)
        jsr STATS.applyColors
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

            NewTetrimino()

        createNewTestTetriminoDone:
            
            PopFromStack()
            rts
}
