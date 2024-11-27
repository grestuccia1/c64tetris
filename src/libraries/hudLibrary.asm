
// ----------------------------------- HUD LIBRARY -----------------------------------

HUD:
{
	
	loadCharMap:
		PushToStack()

		lda #HUD_RESET_COUNTER
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

		lda #HUD_RESET_COUNTER
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
			adc #HUD_CHAR_ZERO
			sta (ZP_ROW_LO),y
			iny

			inx
			cpx #HUD_SCORE_DIGITS
			bne updateScoreLoop

		PopFromStack()	
		rts


	resetScore:
		PushToStack()

		lda #HUD_RESET_COUNTER
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
			adc #HUD_CHAR_ZERO
			sta (ZP_ROW_LO),y
			iny

			inx
			cpx #HUD_LINES_DIGITS
			bne updateLinesCounterLoop

		PopFromStack()	
		rts


	resetLinesCounter:
		PushToStack()

		lda #HUD_RESET_COUNTER
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
		cmp #0
		beq infiniteLevelCounter

		jsr MATH.divideBy10
		iny

		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y

		dey

		txa
		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y
		jmp endUpdateLevelCounter

		infiniteLevelCounter:
		jsr drawInfinity

		endUpdateLevelCounter:

		PopFromStack()	
		rts

	startLevelCounter:
		PushToStack()	

		ldx #HUD_START_LEVEL_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_START_LEVEL_X_POS

		lda currentLevel
		cmp #0
		beq infiniteLevel
		jsr MATH.divideBy10
		iny

		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y

		dey

		txa
		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y

		jmp endstartLevelCounter
		infiniteLevel:
		jsr drawInfinity

		endstartLevelCounter:
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

		lda currentLevel
		cmp #0
		beq infiniteLevelLeftCounter

		lda linesNeededForNextLevel
		sec
		sbc linesForLevel

		cmp #99
		bcc needShowLinesLeft
		lda #HUD_RESET_COUNTER
		ldx #HUD_RESET_COUNTER
		jmp showLinesLeft
	needShowLinesLeft:
		jsr MATH.divideBy10
	showLinesLeft:		
		iny

		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y

		dey

		txa
		clc
		adc #HUD_CHAR_ZERO
		sta (ZP_ROW_LO),y
		jmp endUpdateLinesLeftCounter

		infiniteLevelLeftCounter:
		jsr drawInfinity
		
		endUpdateLinesLeftCounter:

		PopFromStack()	
		rts

	drawInfinity:
		lda #217
		sta (ZP_ROW_LO),y
		iny
		lda #218
		sta (ZP_ROW_LO),y
		rts
}
