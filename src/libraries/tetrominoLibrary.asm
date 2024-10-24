// ----------------------------------- TETROMINO LIBRARY -----------------------------------

TETROMINO:
{
	paint:
		PushToStack()

		lda tetrominoRot 
		ldx tetrominoHeight
		cpx #TETROMINO_HEIGHT_4X4
		bne mustMultiplyBy5Init
		jsr MATH.multiplyBy4
		jmp tetrominoInitContinue
		mustMultiplyBy5Init:
		jsr MATH.multiplyBy5
		tetrominoInitContinue:
		sta tetrominoInit

		lda tetrominoRot 
		clc
		adc #1
		ldx tetrominoHeight
		cpx #TETROMINO_HEIGHT_4X4
		bne mustMultiplyBy5End
		jsr MATH.multiplyBy4
		jmp tetrominoEndContinue
		mustMultiplyBy5End:
		jsr MATH.multiplyBy5
		tetrominoEndContinue:
		sta tetrominoEnd

		ldy tetrominoInit
		
		piece:
			
				lda (ZP_PX_LO), y
				clc
				adc tetrominoCol
				sta charCol

				lda (ZP_PY_LO), y
				clc
				adc tetrominoRow
				sta charRow

				jsr OUTPUT.drawChar

				iny
				cpy tetrominoEnd
				bne piece

				endDraw:

				PopFromStack()
				rts

	
	draw:
		lda #BLOCK
		sta charId

		jsr TETROMINO.paint
		rts

	remove:
		lda #SPACE
		sta charId

		jsr TETROMINO.paint
		rts

	handle:
		PushToStack()

		jsr COLLITION.init	

		lda #TETROMINO_NOT_FALL
		sta tetrominoMustFall

		checktetrominoFallDelayTimer:
		
			ldx tetrominoFallDelayTimer
			beq tetrominoFallDelayTimerReached
			dec tetrominoFallDelayTimer
			jmp checkDownDirection
						
			tetrominoFallDelayTimerReached:
	            jsr TETROMINO.resetFall

				jmp moveSpriteDown

		checkDownDirection:
			lda tetrominoDirection
			and #DOWN
			bne moveSpriteDown
				jmp checkLeftDirection
			moveSpriteDown:
				inc collitionRow

				jsr COLLITION.check
				lda charCollision
				cmp	#SPACE
				beq checkLeftDirection

				lda tetrominoMustFall
				cmp #1
				bne cancelDownDirection

				jsr GAME.createNewTestTetromino

				PopFromStack()
				rts

		cancelDownDirection:		
				dec collitionRow
				
				jmp checkLeftDirection
		
		checkLeftDirection:

			checkTetrominoHSpeedTimer:
			lda tetrominoHSpeedTimer
			cmp tetrominoHSpeed
				beq tetrominoHSpeedTimerReached
				inc tetrominoHSpeedTimer
				jmp checkRotate
			tetrominoHSpeedTimerReached:
				lda #RESET_SPEED
				sta tetrominoHSpeedTimer

			lda tetrominoDirection
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
			lda tetrominoDirection
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

			checkTetrominoRotateCooldownTimer:
			lda tetrominoRotateCooldownTimer
			cmp #0
				beq handleRotate
				dec tetrominoRotateCooldownTimer
				jmp endCheckDirection

		handleRotate:

			lda tetrominoDirection
			and #FIRE_AND_RELEASE
			cmp #FIRE_AND_RELEASE
			beq rotateTetromino
				jmp endCheckDirection
			rotateTetromino:
				ClearTetrominoDirection(FIRE_RELEASE)		

				lda tetrominoRotateCooldown
				sta tetrominoRotateCooldownTimer

				inc collitionRot
				lda collitionRot
				cmp #MAX_ROTATION
				beq resetRotateTetromino
				jmp endCheckDirection
			resetRotateTetromino:			
				lda #RESET_ROTATION
				sta collitionRot
				jmp endCheckDirection	

		endCheckDirection:

			jsr COLLITION.check
			lda charCollision
			cmp	#SPACE
			beq endCheckFinal

			lda tetrominoRot
			sta collitionRot

		endCheckFinal:

			jsr COLLITION.pass

		PopFromStack()
		rts

	change:
		PushToStack()

		ldx tetrominoNr
		lda tetrominoColors,x
		sta charColor

	
		ldy tetrominoHeight
		cpy #TETROMINO_HEIGHT_4X4
		bne mustTetrominoBy5
		
			lda tetrominoPositionsX_LO,x  
			ldy tetrominoPositionsX_HI,x  
			sta ZP_PX_LO                  
			sty ZP_PX_HI                  

			lda tetrominoPositionsY_LO,x  
			ldy tetrominoPositionsY_HI,x  
			sta ZP_PY_LO                  
			sty ZP_PY_HI  

		jmp endChange
		mustTetrominoBy5:
		
			lda tetrominoPositionsX_5_LO,x  
			ldy tetrominoPositionsX_5_HI,x  
			sta ZP_PX_LO                  
			sty ZP_PX_HI                  

			lda tetrominoPositionsY_5_LO,x  
			ldy tetrominoPositionsY_5_HI,x  
			sta ZP_PY_LO                  
			sty ZP_PY_HI  

		endChange:

		PopFromStack()
		rts

	completedLines:
		PushToStack()

   		lda #0
		sta tetrominoCompletedLinesIndex
		ldy #4
		clearCompletedLines:
			sta tetrominoCompletedLines, y
			dey                           
			bpl clearCompletedLines  

			lda #TETROMINO_ROW_LAST

		continueCheckCompleteLinesCompletedLines:
			sta charRow
			ldx charRow
			
			lda #TETROMINO_COL_FIRST
			sta charCol

			movePreviousLineCompletedLines:
				lda #BLOCK
				sta charCollision

				ldy #TETROMINO_COL_FIRST
				sty charCol

				jsr OUTPUT.rowIsComplete

				lda charCollision
				cmp	#SPACE
				bne removeLineCompletedLines 
				
				jmp previewsLineCompletedLines

			removeLineCompletedLines:

				ldy tetrominoCompletedLinesIndex
				lda charRow
				sta tetrominoCompletedLines, y
				inc tetrominoCompletedLinesIndex

			previewsLineCompletedLines:
				
				dex

			keepInSameLineCompletedLines:	
				stx charRow
				cpx tetrominoRow
				bcs movePreviousLineCompletedLines
				jmp endCheckCompleteLinesCompletedLines

			endCheckCompleteLinesCompletedLines:

		lda tetrominoCompletedLinesIndex
		cmp #5
		bne no5CompletedLines
		// add 2000 points
		AddToScore(2,2)
		jmp completedLinesDone
			no5CompletedLines:
			cmp #4
			bne no4CompletedLines
			// add 900 points
			AddToScore(9,3)
			jmp completedLinesDone
				no4CompletedLines:
				cmp #3
				bne no3CompletedLines
				// add 400 points
				AddToScore(4,3)
				jmp completedLinesDone

					no3CompletedLines:
					cmp #2
					bne no2CompletedLines
					// add 150 points
					AddToScore(1,3)
					AddToScore(5,4)
					jmp completedLinesDone

						no2CompletedLines:
						cmp #1
						bne completedLinesDone
						// add 50 points
						AddToScore(5,4)

		completedLinesDone:

		PopFromStack()
		rts

	checkCompleteLines:
		PushToStack()

		lda #TETROMINO_ROW_LAST

	continueCheckCompleteLines:
		sta charRow
		ldx charRow
		
		lda #TETROMINO_COL_FIRST
		sta charCol

		movePreviousLine:
			lda #BLOCK
			sta charCollision

			ldy #TETROMINO_COL_FIRST
			sty charCol

  			jsr OUTPUT.rowIsComplete

 			lda charCollision
			cmp	#SPACE
			bne removeLine 
			
			jmp previewsLine

		removeLine:
			jsr OUTPUT.moveLines
			jmp addLineCounter
 		previewsLine:
			dex
		keepInSameLine:	
			stx charRow
			cpx tetrominoRow
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

		inc tetrominoPerLevel

		ldx currentLevel
		lda tetrominoCountPerLevelToSpeedUp, x
		cmp tetrominoPerLevel
		beq speedUpTetromino
		jmp speedUpTetrominoDone

		speedUpTetromino:
			lda tetrominoFallDelay
			beq speedUpTetrominoDone

			lda #0
			sta tetrominoPerLevel
			
			lda tetrominoFallDelay
			sec
			sbc #1
			cmp #1
			beq speedUpTetrominoDone
			sta tetrominoFallDelay

		speedUpTetrominoDone:
			PopFromStack()
			rts

	resetFall:
		lda #TETROMINO_MUST_FALL
		sta tetrominoMustFall
		lda tetrominoFallDelay
		sta tetrominoFallDelayTimer
		rts

	changeColorLineToDelete:
		PushToStack()

		ldy tetrominoCompletedLinesIndex 
		dey
		changeColorLineToDeleteLoop:
			lda tetrominoCompletedLines, y
			
			sta charRow
			lda #TETROMINO_COL_FIRST
			sta charCol
			lda tetrominoDynamicRowLength
			sta textLength
			lda #TETROMINO_COL_FIRST
			sta textHeight
			lda #BLOCK
			sta textChar
			ldx charRow

			jsr MATH.generateRandomBelow10
			tax
			
			lda rowTransitionColor, x
			sta textColor

			jsr OUTPUT.fillTextColor

			dey                             
			bpl changeColorLineToDeleteLoop  

			changeColorLineToDeleteDone:
				PopFromStack()
				rts	


	createNewTetromino:
			NewTetromino()
			rts
}
