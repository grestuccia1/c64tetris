// ----------------------------------- COORDINATOR LIBRARY -----------------------------------

COORDINATOR: {

    gamePlay:
        lda gameMode
		cmp #GAME_MODE_MENU
		bne noGameModeMenu

		jsr GAME.goToMenu
		jmp noGameModePlayingReady

		noGameModeMenu:
            lda gameMode
			cmp #GAME_MODE_MENU_READY
			bne noGameModeMenuReady

			jsr GAME.inMenuMode

			jmp noGameModePlayingReady
			
		noGameModeMenuReady:
            lda gameMode
			cmp #GAME_MODE_PLAYING
			bne noGameModePlaying

			jsr GAME.goToPlaying

			jmp noGameModePlayingReady
			
		noGameModePlaying:
            lda gameMode
			cmp #GAME_MODE_PLAYING_READY
			bne noGameModePlayingReady

			jsr GAME.inPlayingMode

		noGameModePlayingReady:
            lda gameMode
            cmp #GAME_MODE_GAME_OVER
			bne noGameModeGameOver

			jsr GAME.goToGameOver

        noGameModeGameOver:
            lda gameMode
            cmp #GAME_MODE_GAME_OVER_READY
            bne noGameModeGameOverReady

            jsr GAME.inGameOverMode

        noGameModeGameOverReady: 
        rts
}