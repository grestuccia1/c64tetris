
// ----------------------------------- INPUT LIBRARY -----------------------------------

INPUT:
{
	readJoystick_2:

		
		lda #32
		sta SCREEN_RAM + 85
		sta SCREEN_RAM + 44
		sta SCREEN_RAM + 46
		sta SCREEN_RAM + 5
		sta SCREEN_RAM + 52
		sta SCREEN_RAM + 45
	

		lda JOYSTICK_2
		cmp #JOY_2_IDLE
		bne joy2notIdle
			jmp doneReadJoystick_2
		joy2notIdle:

			checkJoy2down:
				lda JOYSTICK_2
				and #JOY_DOWN
				beq joy2down
					ClearTetriminoDirection(DOWN)
					jmp checkJoy2left
				joy2down:
					SetTetriminoDirection(DOWN)

					lda #22
					sta SCREEN_RAM + 85

			checkJoy2left:
				lda JOYSTICK_2
				and #JOY_LEFT
				beq joy2left
					ClearTetriminoDirection(LEFT)
					jmp checkJoy2right
				joy2left:
					SetTetriminoDirection(LEFT)

					lda #60
					sta SCREEN_RAM + 44

			checkJoy2right:
				lda JOYSTICK_2
				and #JOY_RIGHT
				beq joy2right
					ClearTetriminoDirection(RIGHT)
					jmp checkJoy2up
				joy2right:
					SetTetriminoDirection(RIGHT)

					lda #62
					sta SCREEN_RAM + 46

			checkJoy2up:
				lda JOYSTICK_2
				and #JOY_UP
				beq joy2up
					ClearTetriminoDirection(UP)
					jmp checkJoy2fire
				joy2up:
					SetTetriminoDirection(UP)

					lda #1
					sta SCREEN_RAM + 5

			checkJoy2fire:
				lda JOYSTICK_2
				and #JOY_FIRE
				beq joy2fire
					ClearTetriminoDirection(FIRE)
					jmp doneReadJoystick_2
				joy2fire:
					SetTetriminoDirection(FIRE)

					lda #81
					sta SCREEN_RAM + 52

		doneReadJoystick_2:
			lda #65
			sta SCREEN_RAM + 45
			rts
}
