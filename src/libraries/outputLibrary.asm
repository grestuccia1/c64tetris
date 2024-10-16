
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

		ldx textRow
		cpx #TETRIMINO_ROW_OOR
		bcs drawTextOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda #0
		sta temp

		textWriteLoop:
			ldy temp
			lda (ZP_TEXT_LO),y
			beq drawTextOOR
			
		    cmp #64    
    		bcc no_restar
    
		    sec 
    		sbc #64

		no_restar:
			sta textChar

			ldy textCol
			
			lda textChar
			sta (ZP_ROW_LO),y

			lda textColor
			sta (ZP_ROW_COLOR_LO),y

			inc textCol
			inc temp

			jmp textWriteLoop

		drawTextOOR:
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
