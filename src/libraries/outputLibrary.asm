
// ----------------------------------- OUTPUT LIBRARY -----------------------------------

OUTPUT:
{
	writeText:
		txa
		pha
		tya
		pha

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
		
		pla
		tay
		pla
		tax
		rts

	setTextColor:
		txa
		pha
		tya
		pha

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

		pla
		tay
		pla
		tax
		rts
}
