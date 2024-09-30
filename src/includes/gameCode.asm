
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

	ClearTetriminoDirection(ALL_DIRECTIONS)

	jsr MATH.generate_random
	lda RANDOM_NUMBER
	sta tetriminoNr
	jsr TETRIMINO.change

	jsr SYSTEM.setup
	
gameLoop:
	jsr INPUT.readJoystick_2
	
	lda Tetrimino_Direction
	ldx #8
	
read_bits_msb:
    asl              
    bcs bit_is_1     
    
	tay
    lda #'0'            
    sta SCREEN_RAM + 160, x
	tya
    jmp next_bit

bit_is_1:
	tay
    lda #'1'         
    sta SCREEN_RAM + 160, x
	tya

next_bit:
    dex                  // Decrement X (loop counter)
    bne read_bits_msb 

	// lda JOYSTICK_2
	//sta SCREEN_RAM + 1

	//Delay(100, 100)

/*

		jsr MATH.generate_random
		lda RANDOM_NUMBER
		sta tetriminoNr
		sta SCREEN_RAM + 3

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
