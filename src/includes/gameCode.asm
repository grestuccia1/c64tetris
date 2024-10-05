
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	NewTetrimino()

	jsr SYSTEM.setup

	sei
	LoadCharMap(HUD_CHAR_LEFT_MAP_ADDRESS,HUD_START_POS_X_LEFT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	LoadCharMap(HUD_CHAR_RIGHT_MAP_ADDRESS,HUD_START_POS_X_RIGHT,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	LoadCharMap(HUD_CHAR_CENTRAL_MAP_ADDRESS,HUD_CENTRAL_POS_X,HUD_CENTRAL_POS_Y,HUD_CENTRAL_WIDTH,HUD_CENTRAL_HEIGHT)
	LoadCharMap(HUD_STATS_ADDRESS,HUD_STATS_POS_X,HUD_STATS_POS_Y,HUD_STATS_WIDTH,HUD_STATS_HEIGHT)
	jsr STATS.applyColors
	NewTetrimino()
	cli

gameLoop:
	jsr INPUT.readJoystick_2

 	jmp gameLoop
