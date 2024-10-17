// ----------------------------------- TETRIMINO LIBRARY -----------------------------------

TETRIMINO:
{
	paint:
		PushToStack()

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
				sta charCol

				lda (ZP_PY_LO), y
				clc
				adc tetriminoRow
				sta charRow

				jsr OUTPUT.drawChar

				iny
				cpy tetriminoEnd
				bne piece

				PopFromStack()
				rts

	
	draw:
		lda #BLOCK
		sta charId

		jsr TETRIMINO.paint
		rts

	remove:
		lda #SPACE
		sta charId

		jsr TETRIMINO.paint
		rts

	handle:
		PushToStack()

		jsr COLLITION.init	

		lda #TETRIMINO_NOT_FALL
		sta tetriminoMustFall

		checktetriminoFallDelayTimer:
		
			ldx tetriminoFallDelayTimer
			beq tetriminoFallDelayTimerReached
			dec tetriminoFallDelayTimer
			jmp checkDownDirection
						
			tetriminoFallDelayTimerReached:
	            jsr TETRIMINO.resetFall

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

				PopFromStack()
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

		PopFromStack()
		rts

	change:
		PushToStack()

		ldx tetriminoNr
		lda tetriminoColors,x
		sta charColor

		lda tetriminoPositionsX_LO,x  
		ldy tetriminoPositionsX_HI,x  
		sta ZP_PX_LO                  
		sty ZP_PX_HI                  

		lda tetriminoPositionsY_LO,x  
		ldy tetriminoPositionsY_HI,x  
		sta ZP_PY_LO                  
		sty ZP_PY_HI                  

		PopFromStack()
		rts

	checkCompleteLines:
		PushToStack()

		clc
		lda tetriminoRow

		cmp tetriminoLowRowPosition
		bcs continueTetriminoLowRowPosition
		sta tetriminoLowRowPosition
		dec tetriminoLowRowPosition

	continueTetriminoLowRowPosition:
		adc #TETRIMINO_HEIGHT
		cmp #TETRIMINO_ROW_LAST
		bcc continueCheckCompleteLines
		lda #TETRIMINO_ROW_LAST

	continueCheckCompleteLines:
		sta charRow
		ldx charRow
		
		lda #TETRIMINO_COL_FIRST
		sta charCol

		movePreviousLine:
			lda #BLOCK
			sta charCollision

			ldy #TETRIMINO_COL_FIRST
			sty charCol

  			jsr OUTPUT.rowIsComplete

 			lda charCollision
			cmp	#SPACE
			bne removeLine 
			
			jmp previewsLine

		removeLine:
			AddToScore(1,3)
			jsr OUTPUT.moveLines
			// inc tetriminoLowRowPosition
			jmp addLineCounter
		previewsLine:
			dex
		keepInSameLine:	
			stx charRow
			cpx tetriminoRow
			bcs movePreviousLine
			jmp endCheckCompleteLines

		addLineCounter:
			AddLineCounter()
			jmp keepInSameLine

		endCheckCompleteLines:
 			jsr LEVELS.checkCompleteLevel
			jsr HUD.updateLinesLeftCounter

			PopFromStack()
			rts

	speedUp:
		PushToStack()

		inc tetriminoPerLevel

		ldx currentLevel
		lda tetriminoCountPerLevelToSpeedUp, x
		cmp tetriminoPerLevel
		beq speedUpTetrimino
		jmp speedUpTetriminoDone

		speedUpTetrimino:
			lda tetriminoFallDelay
			beq speedUpTetriminoDone

			lda #0
			sta tetriminoPerLevel
			
			lda tetriminoFallDelay
			sec
			sbc #1
			cmp #1
			beq speedUpTetriminoDone
			sta tetriminoFallDelay

		speedUpTetriminoDone:
			PopFromStack()
			rts

	resetFall:
		lda #TETRIMINO_MUST_FALL
		sta tetriminoMustFall
		lda tetriminoFallDelay
		sta tetriminoFallDelayTimer
		rts
}
