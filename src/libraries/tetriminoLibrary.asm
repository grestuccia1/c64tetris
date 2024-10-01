// ----------------------------------- TETRIMINO LIBRARY -----------------------------------

TETRIMINO:
{
	paint:
		txa
		pha
		tya
		pha

		lda tetriminoRot 
		asl
		asl
		sta tetriminoInit

		lda tetriminoRot 
		clc
		adc #1
		asl
		asl
		sta tetriminoEnd

		ldy tetriminoInit
		
		piece:
			
				lda (ZP_PX_LO), y
				clc
				adc tetriminoCol
				sta tileCol

				lda (ZP_PY_LO), y
				clc
				adc tetriminoRow
				sta tileRow

				jsr TILE.drawChar

				iny
				cpy tetriminoEnd
				bne piece

				pla
				tay
				pla
				tax
				rts

	draw:
		lda #BLOCK
		sta tileNr

		jsr TETRIMINO.paint
		rts

	remove:
		lda #SPACE
		sta tileNr

		jsr TETRIMINO.paint
		rts

	handle:
		txa
		pha
		tya
		pha

		jsr COLLITION.init	

		lda #0
		sta tetriminoMustFall

		checkTetriminoFallSpeedTimer:
		lda Tetrimino_Fall_Speed_Timer
		cmp Tetrimino_Fall_Speed
			beq tetriminoFallSpeedTimerReached
			inc Tetrimino_Fall_Speed_Timer
			jmp checkDownDirection
		tetriminoFallSpeedTimerReached:
			lda #1
			sta tetriminoMustFall
			lda #0
			sta Tetrimino_Fall_Speed_Timer
			jmp moveSpriteDown

		checkDownDirection:
			lda Tetrimino_Direction
			and #DOWN
			bne moveSpriteDown
				jmp checkLeftDirection
			moveSpriteDown:
				inc collitionRow

				jsr COLLITION.check
				lda charCollision
				cmp	#SPACE
				beq checkLeftDirection

				lda tetriminoMustFall
				cmp #1
				bne cancelDownDirection

				jsr TETRIMINO.draw

				NewTetrimino()

				pla
				tay
				pla
				tax
				rts

		cancelDownDirection:		
				dec collitionRow
				
				jmp checkLeftDirection
		
		checkLeftDirection:

			checkTetriminoHSpeedTimer:
			lda Tetrimino_H_Speed_Timer
			cmp Tetrimino_H_Speed
				beq tetriminoHSpeedTimerReached
				inc Tetrimino_H_Speed_Timer
				jmp checkRotate
			tetriminoHSpeedTimerReached:
				lda #0
				sta Tetrimino_H_Speed_Timer

			lda Tetrimino_Direction
			and #LEFT
			bne moveSpriteLeft
				jmp checkRightDirection
			moveSpriteLeft:
				dec collitionCol

				jsr COLLITION.check
				lda charCollision
				cmp	#SPACE
				beq checkRightDirection

				inc collitionCol

				jmp checkRightDirection

		checkRightDirection:
			lda Tetrimino_Direction
			and #RIGHT
			bne moveSpriteRight
				jmp checkRotate
			moveSpriteRight:
				inc collitionCol

				jsr COLLITION.check
				lda charCollision
				cmp	#SPACE
				beq checkRotate

				dec collitionCol

				jmp checkRotate

		checkRotate:
			lda Tetrimino_Direction
			and #FIRE_AND_RELEASE
			cmp #FIRE_AND_RELEASE
			beq rotateTetrimino
				jmp endCheckDirection
			rotateTetrimino:
				ClearTetriminoDirection(FIRE_RELEASE)		
				inc collitionRot
				lda collitionRot
				cmp #MAX_ROTATION
				beq resetRotateTetrimino
				jmp endCheckDirection
			resetRotateTetrimino:			
				lda #0
				sta collitionRot
				jmp endCheckDirection	

		endCheckDirection:

			jsr COLLITION.check
			lda charCollision
			cmp	#SPACE
			beq endCheckFinal

			lda tetriminoRot
			sta collitionRot

		endCheckFinal:

			jsr COLLITION.pass

		pla
		tay
		pla
		tax
		rts

	change:
		txa
		pha
		tya
		pha

		ldy #2
		sty tileColor

		lda tetriminoNr
		cmp #0
		beq change_to_p0

		ldy #7
		sty tileColor

		cmp #1
		beq change_to_p1

		ldy #4
		sty tileColor

		cmp #2
		beq change_to_p2

		ldy #6
		sty tileColor

		cmp #3
		beq change_to_p3

		ldy #3
		sty tileColor

		cmp #4
		beq change_to_p4

		ldy #13
		sty tileColor

		cmp #5
		beq change_to_p5

		ldy #8
		sty tileColor

		cmp #6
		beq change_to_p6

		jmp done_change

		change_to_p0:
			ChangeTetrimino(P0_X, P0_Y)
			jmp done_change

		change_to_p1:
			ChangeTetrimino(P1_X, P1_Y)
			jmp done_change

		change_to_p2:
			ChangeTetrimino(P2_X, P2_Y)
			jmp done_change

		change_to_p3:
			ChangeTetrimino(P3_X, P3_Y)
			jmp done_change

		change_to_p4:
			ChangeTetrimino(P4_X, P4_Y)
			jmp done_change
		
		change_to_p5:
			ChangeTetrimino(P5_X, P5_Y)
			jmp done_change

		change_to_p6:
			ChangeTetrimino(P6_X, P6_Y)
			jmp done_change
			
		done_change:

				pla
				tay
				pla
				tax
				rts
}
