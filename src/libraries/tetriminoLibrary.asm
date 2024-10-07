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

		lda #TETRIMINO_NOT_FALL
		sta tetriminoMustFall

		checkTetriminoFallSpeedTimer:
		lda tetriminoFallSpeedTimer
		cmp tetriminoFallSpeed
			beq tetriminoFallSpeedTimerReached
			inc tetriminoFallSpeedTimer
			jmp checkDownDirection
		tetriminoFallSpeedTimerReached:
			lda #TETRIMINO_MUST_FALL
			sta tetriminoMustFall
			lda #TETRIMINO_NOT_FALL
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

				jsr GAME.createNewTestTetrimino

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
				lda #RESET_SPEED
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
				lda #RESET_ROTATION
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

		ldx tetriminoNr
		lda tetriminoColors,x
		sta tileColor

		lda tetriminoPositionsX_LO,x  
		ldy tetriminoPositionsX_HI,x  
		sta ZP_PX_LO                  
		sty ZP_PX_HI                  

		lda tetriminoPositionsY_LO,x  
		ldy tetriminoPositionsY_HI,x  
		sta ZP_PY_LO                  
		sty ZP_PY_HI                  

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
