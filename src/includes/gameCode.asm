
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	jsr GAME.init

	jsr SYSTEM.setup

gameLoop:

        lda gameMode
		cmp #GAME_START_UP
		bne noGameStartUpInLoop

		inc SCREEN_BORDER_COLOR
		inc SCREEN_BACKGROUND_COLOR
	
	noGameStartUpInLoop:
	
	jsr INPUT.readJoystick_2

 	jmp gameLoop
