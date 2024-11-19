// ----------------------------------- COORDINATOR LIBRARY -----------------------------------

COORDINATOR: {

    gamePlay:
        lda gameMode

		cmp #GAME_START_UP
		bne noGameStartUp

			ldx #RASTER_TICK_10
			jsr CLOCK.tickStatus
			bne gamePlayEnd

			lda #GAME_MODE_MENU
			sta gameMode
		
		gamePlayEnd:
			lda gameMode
			jmp noGameModeEnd
		noGameStartUp:
			lda gameMode
			cmp #GAME_MODE_MENU
			bne noGameModeMenu

			lda #BLACK_COLOR
			sta SCREEN_BORDER_COLOR
			sta SCREEN_BACKGROUND_COLOR

			jsr GAME.goToMenu
			jmp noGameModeEnd

		noGameModeMenu:
			cmp #GAME_MODE_MENU_READY
			bne noGameModeMenuReady

			jsr GAME.inMenuMode
			jmp noGameModeEnd
			
		noGameModeMenuReady:
			lda gameMode
			cmp #GAME_MODE_PLAYING
			bne noGameModePlaying

			jsr GAME.goToPlaying
			jmp noGameModeEnd
			
		noGameModePlaying:
			lda gameMode
			cmp #GAME_MODE_PLAYING_READY
			bne noGameModePlayingReady

			jsr GAME.inPlayingMode
			jmp noGameModeEnd

		noGameModePlayingReady:
			lda gameMode
            cmp #GAME_MODE_CHANGE_LEVEL
			bne noGameModeChangeLevel

			ldx #RASTER_TICK_2
			jsr CLOCK.tickStatus
			bne noGameModeChangeLevel

			AddToScore(1,4)

			lda transitionRow
			cmp transitionRowMax
			bne changeLevelTransition

			lda #GAME_MODE_CHANGE_LEVEL_DELAY
			sta gameMode
				
			jsr CLOCK.resetTicks

			changeLevelTransition:
				lda transitionRow
				sta charRow
				lda #TETROMINO_COL_FIRST
				sta charCol
				lda tetrominoDynamicRowLength
				sta textLength
				lda #TETROMINO_COL_FIRST
				sta textHeight
				lda #BLOCK
				sta textChar
				ldx charRow
				lda rowTransitionColor, x
				sta textColor

				jsr OUTPUT.fillTextColor

				inc transitionRow

				jmp noGameModeEnd

		noGameModeChangeLevel:
			lda gameMode
			cmp #GAME_MODE_CHANGE_LEVEL_DELAY
			bne noGameModeChangeLevelDelay

			ldx #RASTER_TICK_40
			jsr CLOCK.tickStatus
			bne noGameModeChangeLevelDelay

			jsr GAME.changeLevel

			jmp noGameModeEnd

        noGameModeChangeLevelDelay:
			lda gameMode
            cmp #GAME_MODE_CHANGE_LEVEL_READY
            bne noGameModeChangeLevelReady

            jsr GAME.inChangeLevelMode
			jmp noGameModeEnd

		noGameModeChangeLevelReady:
			lda gameMode
            cmp #GAME_MODE_GAME_OVER
			bne noGameModeGameOver

			jsr GAME.goToGameOver
			jmp noGameModeEnd

        noGameModeGameOver:
			lda gameMode
            cmp #GAME_MODE_GAME_OVER_READY
            bne noGameModeGameOverReady

            jsr GAME.inGameOverMode
			jmp noGameModeEnd

		noGameModeGameOverReady:
			lda gameMode
 			cmp #GAME_MODE_DELELE_LINE
            bne noGameModeDeleteLine

 			jsr TETROMINO.completedLines

			lda tetrominoCompletedLinesIndex
			cmp #0
			beq noGameModeToDeleteLines

			jsr CLOCK.resetTicks

			lda #GAME_MODE_DELELE_LINE_ANIMATED
			sta gameMode
			jmp noGameModeDeleteLine
		noGameModeToDeleteLines:
 			lda #GAME_MODE_DELELE_LINE_READY
			sta gameMode
			jmp noGameModeDeleteLineMove

		noGameModeDeleteLine:
			lda gameMode
 			cmp #GAME_MODE_DELELE_LINE_ANIMATED
            bne noGameModeDeleteLineAnimated

			jsr TETROMINO.changeColorLineToDelete

			ldx #RASTER_TICK_10
			jsr CLOCK.tickStatus
			bne noGameModeDeleteLineAnimated
	
			lda #GAME_MODE_DELELE_LINE_MOVE
			sta gameMode

		noGameModeDeleteLineAnimated:
			lda gameMode
 			cmp #GAME_MODE_DELELE_LINE_MOVE
            bne noGameModeDeleteLineMove

			lda #GAME_MODE_DELELE_LINE_READY
			sta gameMode

			jsr TETROMINO.checkCompleteLines

			lda gameMode
			cmp #GAME_MODE_DELELE_LINE_READY
			beq noGameModeDeleteLineAnimated

			jsr GAME.nextTetromino

		noGameModeDeleteLineMove:
			lda gameMode
 			cmp #GAME_MODE_DELELE_LINE_READY
            bne noGameModeDeleteLineReady

            jsr GAME.nextTetromino

			lda #GAME_MODE_PLAYING_READY
			sta gameMode

		noGameModeDeleteLineReady:
        noGameModeEnd: 
        rts
}