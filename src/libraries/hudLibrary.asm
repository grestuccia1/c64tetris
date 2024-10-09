
// ----------------------------------- HUD LIBRARY -----------------------------------

HUD:
{
	
	loadCharMap:
		PushToStack()

		lda #0
		sta tileCounter

		lda charMapWidth
		clc
		adc charMapStartX
		sta charMapWidth

		lda charMapHeight
		clc
		adc charMapStartY
		sta charMapHeight

		ldx charMapStartY
		stx tileRow

		loadCharMapRow:

			ldy charMapStartX
			sty tileCol
			
			loadCharMapCol:
				tya
				pha

				ldy tileCounter
				lda (ZP_HUD_LO),y
				sta tileNr
				tay
			
				lda #FONT_COLOR
				sta tileColor
				
				pla
				tay

				jsr TILE.drawChar
				inc tileCounter

				iny
				sty tileCol
				cpy charMapWidth
				bne loadCharMapCol

			inx
			stx tileRow
			cpx charMapHeight
			bne loadCharMapRow

		PopFromStack()
		rts

	loadCharMapColor:
		PushToStack()

		lda #0
		sta tileCounter

		lda charMapWidth
		clc
		adc charMapStartX
		sta charMapWidth

		lda charMapHeight
		clc
		adc charMapStartY
		sta charMapHeight

		ldx charMapStartY
		stx tileRow

		loadCharMapRowColor:

			ldy charMapStartX
			sty tileCol
			
			loadCharMapColColor:
				tya
				pha

				ldy tileCounter
				lda (ZP_HUD_LO),y
				sta tileNr

				lda (ZP_HUD_COLOR_LO),y
				sta tileColor

				tay
			
				pla
				tay

				jsr TILE.drawChar
				inc tileCounter

				iny
				sty tileCol
				cpy charMapWidth
				bne loadCharMapColColor

			inx
			stx tileRow
			cpx charMapHeight
			bne loadCharMapRowColor

		PopFromStack()
		rts
}
