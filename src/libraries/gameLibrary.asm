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
		LoadFullScreen(HUD_MENU_ADDRESS)

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
        LoadFullScreen(HUD_GAME_OVER_ADDRESS)
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
		pla
		tay
		pla
		tax
        rts

    noGameOver:
        jsr TETRIMINO.draw

        jsr TETRIMINO.checkCompleteLines

        jsr STATS.increaseTetrimino

        NewTetrimino()    

		pla
		tay
		pla
		tax
        rts
}
