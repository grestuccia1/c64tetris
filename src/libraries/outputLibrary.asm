
// ----------------------------------- OUTPUT LIBRARY -----------------------------------

OUTPUT:
{

	drawChar:
		PushToStack()

		ldx charRow
		cpx #TETRIMINO_ROW_OOR
		bcs drawCharOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy charCol

		lda charId
		sta (ZP_ROW_LO),y

		lda charColor
		sta (ZP_ROW_COLOR_LO),y

		drawCharOOR:
			PopFromStack()
			rts

	getChar:
		PushToStack()

		ldx charRow
		cpx #TETRIMINO_ROW_OOR
		bcs getCharOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy charCol

		lda (ZP_ROW_LO),y
		sta charCollision

		lda (ZP_ROW_COLOR_LO), y
		sta colorCollision

		getCharOOR:

			PopFromStack()
			rts

	changeColor:
		PushToStack()

		ldx charRow
		cpx #TETRIMINO_ROW_OOR
		bcs changeColorOOR

		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy charCol

		lda charColor
		sta (ZP_ROW_COLOR_LO),y

		changeColorOOR:
			PopFromStack()
			rts

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

		lda charRow
		clc 
		adc textHeight
		sta textHeight

		lda charCol
		clc
		adc textLength
		sta textLength
		
		ldx charRow

		textColorRowLoop:
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy charCol

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
	
	fillText:
		PushToStack()

		lda charRow
		clc 
		adc textHeight
		sta textHeight

		lda charCol
		clc
		adc textLength
		sta textLength
		
		ldx charRow

		textFillRowLoop:
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy charCol

		lda textChar

		textFillColLoop:
			sta (ZP_ROW_LO),y
			iny
			cpy textLength
			bne textFillColLoop

			inx
			cpx textHeight
			bne textFillRowLoop

		PopFromStack()
		rts

	fillTextColor:
		PushToStack()

		lda charRow
		clc 
		adc textHeight
		sta textHeight

		lda charCol
		clc
		adc textLength
		sta textLength
		
		ldx charRow

		fillTextColorRowLoop:
			lda Row_LO,x
			sta ZP_ROW_LO
			lda Row_HI,x
			sta ZP_ROW_HI
			lda Row_Color_LO,x
			sta ZP_ROW_COLOR_LO
			lda Row_Color_HI,x
			sta ZP_ROW_COLOR_HI

			ldy charCol

			lda textChar

			fillTextColorColLoop:
				lda textChar
				sta (ZP_ROW_LO),y
				lda textColor
				sta (ZP_ROW_COLOR_LO),y
				iny
				cpy textLength
				bne fillTextColorColLoop

				inx
				cpx textHeight
				bne fillTextColorRowLoop

			PopFromStack()
			rts

	moveLines:
		PushToStack()

		ldx charRow

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
	 		bne moveLinePrevious

		PopFromStack()
		rts		
}
