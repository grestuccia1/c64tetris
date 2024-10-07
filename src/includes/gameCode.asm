
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	jsr GAME.init

	jsr SYSTEM.setup

gameLoop:
	jsr INPUT.readJoystick_2

 	jmp gameLoop
