
// ----------------------------------- OUTPUT LIBRARY -----------------------------------

OUTPUT:
{
	writeText:
		PushToStack()

		lda textColor
		sta TEXT_COLOR

		clc // Set cursor position
		ldy textCol
		ldx textRow
		jsr PLOT

		ldy #0 // First char in specified text

		textLoop:
			lda (ZP_TEXT_LO),y
			cmp #STOP_CHAR
			beq doneWriteText
				cmp #NEW_ROW_CHAR
				bne notNewRow
					sty tempY

					inc textRow

					clc
					ldy textCol
					ldx textRow
					jsr PLOT

					ldy tempY

					iny // Next char
					jmp textLoop
				notNewRow:
				jsr CHAROUT
				iny // Next char
				jmp textLoop

		doneWriteText:
		
		PopFromStack()
		rts

	setTextColor:
		PushToStack()

		lda tileRow
		clc 
		adc textHeight
		sta textHeight

		lda tileCol
		clc
		adc textLength
		sta textLength
		
		ldx tileRow

		textColorRowLoop:
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy tileCol

		lda textColor

		textColorColLoop:
			sta (ZP_ROW_COLOR_LO),y
			iny
			cpy textLength
			bne textColorColLoop

			inx
			cpx textHeight
			bne textColorRowLoop

		PopFromStack()
		rts
	
	moveLines:
		PushToStack()

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

		PopFromStack()
		rts		
}
