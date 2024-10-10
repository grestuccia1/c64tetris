
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


	updateScore:
		PushToStack()	

		ldx #HUD_SCORE_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_SCORE_X_POS

		ldx #0
		updateScoreLoop:
			lda score100000,x
			clc
			adc #$30 // Screen code for the 0 char
			sta (ZP_ROW_LO),y
			iny

			inx
			cpx #HUD_SCORE_DIGITS
			bne updateScoreLoop

		PopFromStack()	
		rts


	resetScore:
		PushToStack()

		lda #0
		tax
		resetScoreLoop:
			sta score100000,x
			inx
			cpx #HUD_SCORE_DIGITS
			bne resetScoreLoop
		
		PopFromStack()
		rts

	updateLinesCounter:
		PushToStack()	

		ldx #HUD_LINES_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_LINES_X_POS

		ldx #0
		updateLinesCounterLoop:
			lda lines100000,x
			clc
			adc #$30 // Screen code for the 0 char
			sta (ZP_ROW_LO),y
			iny

			inx
			cpx #HUD_LINES_DIGITS
			bne updateLinesCounterLoop

		PopFromStack()	
		rts


	resetLinesCounter:
		PushToStack()

		lda #0
		tax
		resetLinesCounterLoop:
			sta lines100000,x
			inx
			cpx #HUD_LINES_DIGITS
			bne resetLinesCounterLoop
		
		PopFromStack()
		rts

	updateLevelCounter:
		PushToStack()	

		ldx #HUD_LEVEL_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_LEVEL_X_POS

		lda currentLevel
		jsr MATH.divideBy10
		iny

		clc
		adc #$30 
		sta (ZP_ROW_LO),y

		dey

		txa
		clc
		adc #$30
		sta (ZP_ROW_LO),y

		PopFromStack()	
		rts

	updateLinesLeftCounter:
		PushToStack()	

		ldx #HUD_LINES_LEFT_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_LINES_LEFT_X_POS

		lda linesNeededForNextLevel
		sec
		sbc linesForLevel

		cmp #99
		bcc needShowLinesLeft
		lda #0
		ldx #0
		jmp showLinesLeft
	needShowLinesLeft:
		jsr MATH.divideBy10
	showLinesLeft:		
		iny

		clc
		adc #$30 
		sta (ZP_ROW_LO),y

		dey

		txa
		clc
		adc #$30
		sta (ZP_ROW_LO),y

		PopFromStack()	
		rts
}
