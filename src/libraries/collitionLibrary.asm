
// ----------------------------------- COLLITION LIBRARY -----------------------------------

COLLITION:
{

    init:
        lda tetriminoRow
        sta collitionRow

        lda tetriminoCol
        sta collitionCol

        lda tetriminoRot
        sta collitionRot

        rts

    pass:    
        lda collitionRow
        sta tetriminoRow

        lda collitionCol
        sta tetriminoCol

        lda collitionRot
        sta tetriminoRot

        rts

	check:
		PushToStack()

		lda #SPACE
		sta charCollision

		lda collitionRot 
		asl
		asl
		sta collitionInit

		lda collitionRot 
		clc
		adc #1
		asl
		asl
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

				jsr OUTPUT.getChar

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

		lda #TETRIMINO_ROW_FIRST
		sta charRow
		
		lda #TETRIMINO_COL_FIRST
		sta charCol

		lda #SPACE
		sta charCollision

nextCharInLine:
		jsr OUTPUT.getChar

		lda charCollision
		cmp	#SPACE
		bne lineColitionDone

		inc charCol
		lda charCol
		cmp #TETRIMINO_COL_LAST
		bne nextCharInLine

		lda #TETRIMINO_COL_FIRST
		sta charCol

		inc charRow
		lda charRow
		cmp #TETRIMINO_ROW_LAST
		bne nextCharInLine

lineColitionDone:
		dec charRow
		lda charRow
		sta transitionRowMax

		PopFromStack()
		rts
}