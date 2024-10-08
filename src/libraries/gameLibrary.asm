// ----------------------------------- GAME LIBRARY -----------------------------------

GAME:
{
    init:
        lda #GAME_MODE_MENU
        sta gameMode
    rts

    goToMenu:
        txa
        pha
        tya
        pha

        lda #GAME_MODE_MENU_READY
        sta gameMode

        jsr SCREEN_CLEAR
        LoadCharColorMap(HUD_TETRIS_TITLE_ADDRESS, HUD_TETRIS_TITLE_COLORS_ADDRESS, 3, 1, 35, 7)
        WriteText(START_MESSAGE, 9, 21, 1)
        
        pla
        tay
        pla
        tax
        rts

    inMenuMode:
        txa
        pha
        tya
        pha

        jsr SCNKEY
        jsr GETIN
        cmp #KEY_F1
        bne inMenuNoF1

        lda #GAME_MODE_PLAYING
        sta gameMode

        inMenuNoF1:

        pla
        tay
        pla
        tax
        rts

    goToPlaying:
        txa
        pha
        tya
        pha

        lda #GAME_MODE_PLAYING_READY
        sta gameMode
        LoadFullScreen(HUD_GAMEPLAY_ADDRESS)
        jsr STATS.applyColors
        NewTetrimino()
        pla
        tay
        pla
        tax
        rts

    inPlayingMode:
        txa
        pha
        tya
        pha

        jsr TETRIMINO.remove
        jsr TETRIMINO.handle
        ClearTetriminoDirection(ALL_DIRECTIONS_NO_FIRE)
        lda gameMode
        cmp #GAME_MODE_PLAYING_READY
        bne justGameOver

        jsr TETRIMINO.change
        jsr TETRIMINO.draw

        justGameOver:
        pla
        tay
        pla
        tax
        rts

    goToGameOver:
        txa
        pha
        tya
        pha

        lda #GAME_MODE_GAME_OVER_READY
        sta gameMode
        
        jsr SCREEN_CLEAR
        LoadCharColorMap(HUD_GAME_OVER_TITLE_ADDRESS, HUD_GAME_OVER_TITLE_COLORS_ADDRESS, 1, 3, 39, 5)
        WriteText(GAME_OVER_MESSAGE, 9, 20, 1)

        pla
        tay
        pla
        tax
        rts

    inGameOverMode:
        txa
        pha
        tya
        pha

        jsr SCNKEY
        jsr GETIN
        cmp #KEY_F1
        bne inGameOverNoF1

        lda #GAME_MODE_MENU
        sta gameMode

        inGameOverNoF1:
        pla
        tay
        pla
        tax
        rts


    createNewTestTetrimino:
        txa
        pha
        tya
        pha

        lda tetriminoRow
        cmp #TETRIMINO_ROW_START
        bne noGameOver

        jsr GAME.goToGameOver
        jmp createNewTestTetriminoDone

        noGameOver:
            jsr TETRIMINO.draw

            jsr TETRIMINO.checkCompleteLines

            jsr STATS.increaseTetrimino

            NewTetrimino()

        createNewTestTetriminoDone:
            pla
            tay
            pla
            tax
            rts
}
