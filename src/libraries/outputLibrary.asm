
// ----------------------------------- OUTPUT LIBRARY -----------------------------------

OUTPUT:
{

	drawChar:
		PushToStack()

		ldx charRow
		cpx #TETROMINO_ROW_OOR
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

	drawCharNoColor:
		PushToStack()

		ldx charRow
		cpx #TETROMINO_ROW_OOR
		bcs drawCharNoColorOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy charCol

		lda charId
		sta (ZP_ROW_LO),y

		drawCharNoColorOOR:
			PopFromStack()
			rts

	rowIsComplete:
		PushToStack()

		ldx charRow
		cpx #TETROMINO_ROW_OOR
		bcs setPositionInRowOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy charCol

		moveNextPositionInRow:
		cpy tetrominoDynamicLastCol
		beq setPositionInRowOOR

		lda (ZP_ROW_LO),y

		iny
		cmp	#SPACE
		bne moveNextPositionInRow 

		setPositionInRowOOR:
		
			sta charCollision

			PopFromStack()
			rts


	getCharNoColor:
		PushToStack()

		ldx charRow
		cpx #TETROMINO_ROW_OOR
		bcs getCharOORNoColor

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy charCol

		lda (ZP_ROW_LO),y
		sta charCollision

		getCharOORNoColor:

			PopFromStack()
			rts

	getChar:
		PushToStack()

		ldx charRow
		cpx #TETROMINO_ROW_OOR
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
		cpx #TETROMINO_ROW_OOR
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
		cpx #TETROMINO_ROW_OOR
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

	animateBlock:
		PushToStack()

		lda blockCharsetAnimationIndex
		cmp #BLOCK_CHARSET_ANIMATION_MAX
		bne animateBlockContinue

		lda #0
		sta blockCharsetAnimationIndex

		animateBlockContinue:
		jsr MATH.multiplyBy8

		tay
		ldx #0
		animateBlockLoop:
			lda BLOCK_CHARACTER_ORIGIN, y
			sta BLOCK_CHARACTER_TARGET, x   
			inx
			iny 
			cpx #8
			bne animateBlockLoop

		inc blockCharsetAnimationIndex

		PopFromStack()
		rts

	animateArrow:
		PushToStack()

		lda arrowCharsetAnimationIndex
		cmp #ARROW_CHARSET_ANIMATION_MAX
		bne animateArrowContinue

		lda #0
		sta arrowCharsetAnimationIndex

		animateArrowContinue:
		jsr MATH.multiplyBy8

		tay
		ldx #0
		animateArrowLoop:
			lda ARROW_CHARACTER_ORIGIN, y
			sta ARROW_CHARACTER_TARGET, x   
			inx
			iny 
			cpx #8
			bne animateArrowLoop

		inc arrowCharsetAnimationIndex

		PopFromStack()
		rts

	drawCursor:
		PushToStack()

		lda drawCursorIdle
		bne resetDrawCursorIdle

		lda tetrominoDirection
		and #DOWN
		beq noDrawCursorDown

			lda drawCursorRow
			cmp #DRAW_CURSOR_ROW_LEVEL
			beq noDrawCursorDown

			jsr clearCursor
			inc drawCursorRow
			inc drawCursorRow
			jmp drawCursorContinue

		noDrawCursorDown:
		lda tetrominoDirection
		and #UP
		beq noDrawCursorUp

			lda drawCursorRow
			cmp #DRAW_CURSOR_ROW_START
			beq noDrawCursorUp

			jsr clearCursor
			dec drawCursorRow
			dec drawCursorRow
			jmp drawCursorContinue

		noDrawCursorUp:
			jmp noDrawCursor

		drawCursorContinue:

		lda #1
		sta drawCursorIdle

        lda drawCursorRow
        sta charRow

        lda #HUD_TETRIS_TITLE_OPTIONS_X_POS - 1
        sta charCol

        lda #ARROW_RIGHT  
        sta charId

        lda #WHITE_COLOR
        sta charColor
        jsr OUTPUT.drawChar 

		resetDrawCursorIdle:
			lda tetrominoDirection
			and #DOWN
			beq noDrawCursorDownIdle

		jmp noDrawCursor
		noDrawCursorDownIdle:

			lda tetrominoDirection
			and #UP
			beq noDrawCursorUpIdle

		jmp noDrawCursor

		noDrawCursorUpIdle:
			lda #0
			sta drawCursorIdle

		noDrawCursor:
        	PopFromStack()
        	rts  

	clearCursor:
        lda drawCursorRow
        sta charRow

        lda #HUD_TETRIS_TITLE_OPTIONS_X_POS - 1
        sta charCol

        lda #SPACE  
        sta charId

        lda #WHITE_COLOR
        sta charColor
        jsr OUTPUT.drawChar 
		rts
}
