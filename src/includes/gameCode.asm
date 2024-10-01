
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	NewTetrimino()
	
	jsr SYSTEM.setup

	sei
	LoadCharMap(HUD_CHAR_LEFT_MAP_ADDRESS,HUD_START_POS_X_LEFT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	LoadCharMap(HUD_CHAR_RIGHT_MAP_ADDRESS,HUD_START_POS_X_RIGHT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	cli

gameLoop:
	jsr INPUT.readJoystick_2
	
 	jmp gameLoop
