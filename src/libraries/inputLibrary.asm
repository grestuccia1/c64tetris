
// ----------------------------------- INPUT LIBRARY -----------------------------------

INPUT:
{
	readJoystick_2:

		
		lda #SPACE
		sta SCREEN_RAM + 85
		sta SCREEN_RAM + 44
		sta SCREEN_RAM + 46
		sta SCREEN_RAM + 5
		sta SCREEN_RAM + 52
		sta SCREEN_RAM + 45
	

		lda JOYSTICK_2
		cmp #JOY_2_IDLE
		bne joy2notIdle
			ClearTetriminoDirection(FIRE)
			SetTetriminoDirection(FIRE_RELEASE)
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

					lda #ARROW_DOWN
					sta SCREEN_RAM + 85

			checkJoy2left:
				lda JOYSTICK_2
				and #JOY_LEFT
				beq joy2left
					ClearTetriminoDirection(LEFT)
					jmp checkJoy2right
				joy2left:
					SetTetriminoDirection(LEFT)

					lda #ARROW_LEFT
					sta SCREEN_RAM + 44

			checkJoy2right:
				lda JOYSTICK_2
				and #JOY_RIGHT
				beq joy2right
					ClearTetriminoDirection(RIGHT)
					jmp checkJoy2up
				joy2right:
					SetTetriminoDirection(RIGHT)

					lda #ARROW_RIGHT
					sta SCREEN_RAM + 46

			checkJoy2up:
				lda JOYSTICK_2
				and #JOY_UP
				beq joy2up
					ClearTetriminoDirection(UP)
					jmp checkJoy2fire
				joy2up:
					SetTetriminoDirection(UP)

					lda #ARROW_UP
					sta SCREEN_RAM + 5

			checkJoy2fire:
				lda JOYSTICK_2
				and #JOY_FIRE
				beq joy2fire
					ClearTetriminoDirection(FIRE)
					SetTetriminoDirection(FIRE_RELEASE)
					jmp doneReadJoystick_2
				joy2fire:
					SetTetriminoDirection(FIRE)
						jmp doneReadJoystick_2

					lda #BUTTON_PRESS
					sta SCREEN_RAM + 52	

		doneReadJoystick_2:
			lda #BUTTON_RELEASE
			sta SCREEN_RAM + 45
			rts
}
