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

			jsr GAME.changeLevel
			jmp noGameModeEnd

        noGameModeChangeLevel:
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