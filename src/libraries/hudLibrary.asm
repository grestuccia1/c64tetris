
// ----------------------------------- HUD LIBRARY -----------------------------------

HUD:
{
	
	loadCharMap:
		PushToStack()

		lda #0
		sta charCounter

		lda charMapWidth
		clc
		adc charMapStartX
		sta charMapWidth

		lda charMapHeight
		clc
		adc charMapStartY
		sta charMapHeight

		ldx charMapStartY
		stx charRow

		loadCharMapRow:

			ldy charMapStartX
			sty charCol
			
			loadCharMapCol:
				tya
				pha

				ldy charCounter
				lda (ZP_HUD_LO),y
				sta charId
				tay
			
				lda #FONT_COLOR
				sta charColor
				
				pla
				tay

				jsr OUTPUT.drawChar
				inc charCounter

				iny
				sty charCol
				cpy charMapWidth
				bne loadCharMapCol

			inx
			stx charRow
			cpx charMapHeight
			bne loadCharMapRow

		PopFromStack()
		rts

	loadCharMapColor:
		PushToStack()

		lda #0
		sta charCounter

		lda charMapWidth
		clc
		adc charMapStartX
		sta charMapWidth

		lda charMapHeight
		clc
		adc charMapStartY
		sta charMapHeight

		ldx charMapStartY
		stx charRow

		loadCharMapRowColor:

			ldy charMapStartX
			sty charCol
			
			loadCharMapColColor:
				tya
				pha

				ldy charCounter
				lda (ZP_HUD_LO),y
				sta charId

				lda (ZP_HUD_COLOR_LO),y
				sta charColor

				tay
			
				pla
				tay

				jsr OUTPUT.drawChar
				inc charCounter

				iny
				sty charCol
				cpy charMapWidth
				bne loadCharMapColColor

			inx
			stx charRow
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
