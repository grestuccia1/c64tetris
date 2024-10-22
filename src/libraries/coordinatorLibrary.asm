// ----------------------------------- COORDINATOR LIBRARY -----------------------------------

COORDINATOR: {

    gamePlay:
        lda gameMode

		cmp #GAME_START_UP
		bne noGameStartUp

			ldx tempStartUpDelayTimer
				beq startUpDelayTimerReached 
				dec tempStartUpDelayTimer    
				jmp noGameModeEnd                  

			startUpDelayTimerReached:
				lda #START_UP_DELAY_TIMER_REACHED
				sta tempStartUpDelayTimer 

				lda #GAME_MODE_MENU
				sta gameMode

			jmp noGameModeEnd
		noGameStartUp:
			
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

			ldx tempTransitionRowDelayTimer
			beq transitionRowDelayTimerReached 
			dec tempTransitionRowDelayTimer    
			jmp noGameModeEnd                  

			transitionRowDelayTimerReached:
				lda #TRANSITION_ROW_DELAY_TIMER_REACHED
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
				lda tetriminoDynamicRowLENGTH
				sta textLENGTH
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

			lda tempTransitionBetweenLevelsDelay
			beq transitionBetweenLevelsDelayTimerReached
			dec tempTransitionBetweenLevelsDelay
			jmp noGameModeEnd
			transitionBetweenLevelsDelayTimerReached:
				lda #TRANSITION_BETWEEN_LEVELS_DELAY_TIMER_REACHED
				sta tempTransitionBetweenLevelsDelay

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