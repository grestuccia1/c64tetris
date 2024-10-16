
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

		inc $D020
		inc $D021
	
	noGameStartUpInLoop:
	
	jsr INPUT.readJoystick_2

 	jmp gameLoop
