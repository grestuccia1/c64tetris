
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	lda #10
	sta tetriminoRow
	lda #5
	sta tetriminoCol

	lda #0
	sta tetriminoRot

	jsr MATH.generate_random
	lda RANDOM_NUMBER
	sta tetriminoNr
	jsr TETRIMINO.change

	jsr SYSTEM.setup
	
gameLoop:
	jsr INPUT.readJoystick_2
	
	//ldx #7
	//lda Tetrimino_Direction, x
	//sta SCREEN_RAM 

	lda JOYSTICK_2
	sta SCREEN_RAM + 1

	ClearTetriminoDirection(ALL_DIRECTIONS)

	Delay(100, 100)

		jsr MATH.generate_random
		lda RANDOM_NUMBER
		sta tetriminoNr
		sta SCREEN_RAM + 3
/*

		inc tetriminoRot
		lda tetriminoRot
		cmp #4
		beq cambiar

		jmp dibujar
cambiar:			
		lda #0
		sta tetriminoRot
dibujar:
*/
 	jmp gameLoop
