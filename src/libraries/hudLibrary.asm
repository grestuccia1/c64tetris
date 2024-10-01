
// ----------------------------------- HUD LIBRARY -----------------------------------

HUD:
{
	
	loadCharMap:
		txa
		pha
		tya
		pha

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
				//lda CHARSET_ATTRIB_ADDRESS,y
				lda #12
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

		pla
		tay
		pla
		tax
		rts

}
