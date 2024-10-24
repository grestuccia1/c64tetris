
// ----------------------------------- COLLITION LIBRARY -----------------------------------

COLLITION:
{

    init:
        lda tetrominoRow
        sta collitionRow

        lda tetrominoCol
        sta collitionCol

        lda tetrominoRot
        sta collitionRot

        rts

    pass:    
        lda collitionRow
        sta tetrominoRow

        lda collitionCol
        sta tetrominoCol

        lda collitionRot
        sta tetrominoRot

        rts

	check:
		PushToStack()

		lda #SPACE
		sta charCollision

		lda collitionRot 
		ldx tetrominoHeight
		cpx #TETROMINO_HEIGHT_4X4
		bne mustMultiplyBy5Init
		jsr MATH.multiplyBy4
		jmp collitionInitContinue
		mustMultiplyBy5Init:
		jsr MATH.multiplyBy5
		collitionInitContinue:
		sta collitionInit

		lda collitionRot 
		clc
		adc #1
		ldx tetrominoHeight
		cpx #TETROMINO_HEIGHT_4X4
		bne mustMultiplyBy5End
		jsr MATH.multiplyBy4
		jmp collitionEndContinue
		mustMultiplyBy5End:
		jsr MATH.multiplyBy5
		collitionEndContinue:
		sta collitionEnd

		ldy collitionInit
		
		checkPiece:
			
				lda (ZP_PX_LO), y
				clc
				adc collitionCol
				sta charCol

				lda (ZP_PY_LO), y
				clc
				adc collitionRow
				sta charRow

				jsr OUTPUT.getCharNoColor

				lda charCollision
				cmp	#SPACE
				bne checkDone

				iny
				cpy collitionEnd
				bne checkPiece
		checkDone:
				PopFromStack()
				rts


	lineColition:
		PushToStack()

		lda #TETROMINO_ROW_FIRST
		sta charRow
		
		lda #TETROMINO_COL_FIRST
		sta charCol

		lda #SPACE
		sta charCollision

		nextCharInLine:
			jsr OUTPUT.getCharNoColor

			lda charCollision
			cmp	#SPACE
			bne lineColitionDone

			inc charCol
			lda charCol
			cmp tetrominoDynamicLastCol
			bne nextCharInLine

			lda #TETROMINO_COL_FIRST
			sta charCol

			inc charRow
			lda charRow
			cmp #TETROMINO_ROW_LAST
			bne nextCharInLine

		lineColitionDone:
			dec charRow
			lda charRow
			sta transitionRowMax

			cmp #TETROMINO_ROW_LAST
			bcs greaterThan23 
			jmp endLineColitionDone
			greaterThan23:
				lda #TETROMINO_ROW_LAST
				sta transitionRowMax
			endLineColitionDone:
				PopFromStack()
				rts
}