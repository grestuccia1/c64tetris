
// ----------------------------------- INPUT LIBRARY -----------------------------------

INPUT:
{
	readJoystick_2:
		lda JOYSTICK_2
		cmp #JOY_2_IDLE
		bne joy2notIdle
			//ClearTetrominoDirection(FIRE)
			ClearTetrominoDirection(ALL_DIRECTIONS)
			SetTetrominoDirection(FIRE_RELEASE)
			jmp doneReadJoystick_2
		joy2notIdle:

			checkJoy2down:
				lda JOYSTICK_2
				and #JOY_DOWN
				beq joy2down
					ClearTetrominoDirection(DOWN)
					jmp checkJoy2left
				joy2down:
					SetTetrominoDirection(DOWN)

			checkJoy2left:
				lda JOYSTICK_2
				and #JOY_LEFT
				beq joy2left
					ClearTetrominoDirection(LEFT)
					jmp checkJoy2right
				joy2left:
					SetTetrominoDirection(LEFT)

			checkJoy2right:
				lda JOYSTICK_2
				and #JOY_RIGHT
				beq joy2right
					ClearTetrominoDirection(RIGHT)
					jmp checkJoy2up
				joy2right:
					SetTetrominoDirection(RIGHT)

			checkJoy2up:
				lda JOYSTICK_2
				and #JOY_UP
				beq joy2up
					ClearTetrominoDirection(UP)
					jmp checkJoy2fire
				joy2up:
					SetTetrominoDirection(UP)

			checkJoy2fire:
				lda JOYSTICK_2
				and #JOY_FIRE
				beq joy2fire
					ClearTetrominoDirection(FIRE)
					SetTetrominoDirection(FIRE_RELEASE)
					jmp doneReadJoystick_2
				joy2fire:
					SetTetrominoDirection(FIRE)
						jmp doneReadJoystick_2

		doneReadJoystick_2:
			rts
}
