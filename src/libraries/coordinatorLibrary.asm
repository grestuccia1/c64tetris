// ----------------------------------- COORDINATOR LIBRARY -----------------------------------

COORDINATOR: {

    gamePlay:
        lda gameMode
		cmp #GAME_MODE_MENU
		bne noGameModeMenu

		jsr GAME.goToMenu
		jmp noGameModeEnd

		noGameModeMenu:
			cmp #GAME_MODE_MENU_READY
			bne noGameModeMenuReady

			jsr GAME.inMenuMode
			jmp noGameModeEnd
			
		noGameModeMenuReady:
			cmp #GAME_MODE_PLAYING
			bne noGameModePlaying

			jsr GAME.goToPlaying
			jmp noGameModeEnd
			
		noGameModePlaying:
			cmp #GAME_MODE_PLAYING_READY
			bne noGameModePlayingReady

			jsr GAME.inPlayingMode
			jmp noGameModeEnd

		noGameModePlayingReady:
            cmp #GAME_MODE_CHANGE_LEVEL
			bne noGameModeChangeLevel

			lda tempTransitionRowDelayTimer
			cmp transitionRowDelay
				beq transitionRowDelayTimerReached
				bcs transitionRowDelayTimerReached
				inc tempTransitionRowDelayTimer
				jmp noGameModeEnd
			transitionRowDelayTimerReached:
				lda #0
				sta tempTransitionRowDelayTimer

				AddToScore(1,4)

				lda transitionRow
				cmp transitionRowMax
				bne changeLevelTransition

				lda #GAME_MODE_CHANGE_LEVEL_DELAY
				sta gameMode
				
			changeLevelTransition:
				lda transitionRow
				sta charRow
				lda #TETRIMINO_COL_FIRST
				sta charCol
				lda #TETRIMINO_ROW_LENGHT
				sta textLength
				lda #TETRIMINO_COL_FIRST
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
			cmp #GAME_MODE_CHANGE_LEVEL_DELAY
			bne noGameModeChangeLevelDelay

			lda transitionRowDelayTimer
			cmp transitionRowFinalDelay
				beq transitionRowDelayTimerReachedInDelay
				bcs transitionRowDelayTimerReachedInDelay
				inc transitionRowDelayTimer
				jmp noGameModeEnd
			transitionRowDelayTimerReachedInDelay:
				lda #0
				sta transitionRowDelayTimer

			jsr GAME.changeLevel

			jmp noGameModeEnd

        noGameModeChangeLevelDelay:
            cmp #GAME_MODE_CHANGE_LEVEL_READY
            bne noGameModeChangeLevelReady

            jsr GAME.inChangeLevelMode
			jmp noGameModeEnd

		noGameModeChangeLevelReady:
            cmp #GAME_MODE_GAME_OVER
			bne noGameModeGameOver

			jsr GAME.goToGameOver
			jmp noGameModeEnd

        noGameModeGameOver:
            cmp #GAME_MODE_GAME_OVER_READY
            bne noGameModeGameOverReady

            jsr GAME.inGameOverMode
			jmp noGameModeEnd

		noGameModeGameOverReady:
        noGameModeEnd: 
        rts
}