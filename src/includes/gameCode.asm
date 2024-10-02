
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	NewTetrimino()
	
	jsr SYSTEM.setup

	sei
	LoadCharMap(HUD_CHAR_LEFT_MAP_ADDRESS,HUD_START_POS_X_LEFT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	LoadCharMap(HUD_CHAR_RIGHT_MAP_ADDRESS,HUD_START_POS_X_RIGHT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)

/*
	DrawTetrimino(18,1)
	DrawTetrimino(18,2)
	DrawTetrimino(18,3)
	DrawTetrimino(18,4)
	DrawTetrimino(18,5)
	DrawTetrimino(18,6)
	DrawTetrimino(18,7)
	DrawTetrimino(18,8)
	DrawTetrimino(18,9)

	DrawTetrimino(19,1)
	DrawTetrimino(19,2)
	DrawTetrimino(19,3)
	DrawTetrimino(19,4)
	DrawTetrimino(19,5)
	DrawTetrimino(19,6)
	DrawTetrimino(19,7)
	DrawTetrimino(19,8)
	DrawTetrimino(19,9)

	DrawTetrimino(21,1)
	DrawTetrimino(21,2)
	DrawTetrimino(21,3)
	DrawTetrimino(21,4)
	DrawTetrimino(21,5)
	DrawTetrimino(21,6)
	DrawTetrimino(21,7)
	DrawTetrimino(21,8)
	DrawTetrimino(21,9)

	DrawTetrimino(17,4)

	jsr TETRIMINO.checkCompleteLines

	NewTetrimino()
*/

	cli

gameLoop:
	jsr INPUT.readJoystick_2
	
 	jmp gameLoop
