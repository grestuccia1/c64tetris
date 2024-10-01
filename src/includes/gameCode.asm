
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	jsr MATH.generate_random
	lda RANDOM_NUMBER
	sta tetriminoNr
	jsr TETRIMINO.change

	ClearTetriminoDirection(ALL_DIRECTIONS)

	jsr SYSTEM.setup

	sei
	LoadCharMap(HUD_CHAR_LEFT_MAP_ADDRESS,HUD_START_POS_X_LEFT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	LoadCharMap(HUD_CHAR_RIGHT_MAP_ADDRESS,HUD_START_POS_X_RIGHT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)

	DrawTetrimino(21, 1)
	DrawTetrimino(21, 2)
	DrawTetrimino(21, 3)
	DrawTetrimino(21, 4)
	DrawTetrimino(21, 5)
	DrawTetrimino(21, 6)
	DrawTetrimino(21, 7)

	SelectTetrimino(0, 4, 0)
	cli

gameLoop:
	jsr INPUT.readJoystick_2
	
 	jmp gameLoop
