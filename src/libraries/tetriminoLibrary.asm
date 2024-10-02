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
		lda tetriminoFallSpeedTimer
		cmp tetriminoFallSpeed
			beq tetriminoFallSpeedTimerReached
			inc tetriminoFallSpeedTimer
			jmp checkDownDirection
		tetriminoFallSpeedTimerReached:
			lda #1
			sta tetriminoMustFall
			lda #0
			sta tetriminoFallSpeedTimer
			jmp moveSpriteDown

		checkDownDirection:
			lda tetriminoDirection
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

				jsr TETRIMINO.checkCompleteLines

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
			lda tetriminoHSpeedTimer
			cmp tetriminoHSpeed
				beq tetriminoHSpeedTimerReached
				inc tetriminoHSpeedTimer
				jmp checkRotate
			tetriminoHSpeedTimerReached:
				lda #0
				sta tetriminoHSpeedTimer

			lda tetriminoDirection
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
			lda tetriminoDirection
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

			checkTetriminoRotateCooldownTimer:
			lda tetriminoRotateCooldownTimer
			cmp #0
				beq handleRotate
				dec tetriminoRotateCooldownTimer
				jmp endCheckDirection

		handleRotate:

			lda tetriminoDirection
			and #FIRE_AND_RELEASE
			cmp #FIRE_AND_RELEASE
			beq rotateTetrimino
				jmp endCheckDirection
			rotateTetrimino:
				ClearTetriminoDirection(FIRE_RELEASE)		

				lda tetriminoRotateCooldown
				sta tetriminoRotateCooldownTimer

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

	checkCompleteLines:

		txa
		pha
		tya
		pha

		lda #TETRIMINO_ROW_LAST
		sta tileRow
		ldx tileRow
		
		lda #TETRIMINO_COL_FIRST
		sta tileCol

		movePreviousLine:
			lda #BLOCK
			sta charCollision

			ldy #TETRIMINO_COL_FIRST

			moveNextPosition:		
				sty tileCol
				cpy #TETRIMINO_COL_LAST
				beq removeLine

				jsr TILE.getChar

				iny
				lda charCollision
				cmp	#SPACE
				bne moveNextPosition 
				
				jmp previewsLine

			removeLine:
				jsr TETRIMINO.moveLines
				jmp keepInSameLine
			previewsLine:
				dex
			keepInSameLine:	
				stx tileRow
				cpx tetriminoRow
				bne movePreviousLine

		pla
		tay
		pla
		tax
		rts

	moveLines:
		txa
		pha
		tya
		pha

		ldx tileRow

		moveLinePrevious:
			lda Row_LO,x
			sta ZP_ROW_LO
			lda Row_HI,x
			sta ZP_ROW_HI
			lda Row_Color_LO,x
			sta ZP_ROW_COLOR_LO
			lda Row_Color_HI,x
			sta ZP_ROW_COLOR_HI

			dex
			lda Row_LO,x
			sta ZP_ROW_PREVIOUS_LO
			lda Row_HI,x
			sta ZP_ROW_PREVIOUS_HI
			lda Row_Color_LO,x
			sta ZP_ROW_COLOR_PREVIOUS_LO
			lda Row_Color_HI,x
			sta ZP_ROW_COLOR_PREVIOUS_HI

			ldy #TETRIMINO_COL_FIRST

			moveNextChar:
				lda (ZP_ROW_PREVIOUS_LO),y
				sta (ZP_ROW_LO), y

				lda (ZP_ROW_COLOR_PREVIOUS_LO), y
				sta (ZP_ROW_COLOR_LO), y

				iny
				cpy #TETRIMINO_COL_LAST
				bne moveNextChar

			cpx #TETRIMINO_ROW_FIRST //TODO: OPTIMIZE
	 		bcs moveLinePrevious

		pla
		tay
		pla
		tax
		rts	
}
