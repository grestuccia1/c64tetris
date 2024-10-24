
STATS:
{
	init:
		PushToStack()

		ldy #0

        initStatsLoop:
            lda #0
            sta statsTetrominoTotal, y
            sta statsTetrominoSubTotal,y 
            lda #HUD_STATS_POS_Y - 1
            sta statsTetrominoRow, y

            iny
            cpy tetrominoMax
            bne initStatsLoop
			
		PopFromStack()
		rts
        
    increaseTetromino:
        PushToStack()

        ldy tetrominoNr
        lda statsTetrominoTotal, y
        clc
        adc #1
        sta statsTetrominoTotal, y

        lda statsTetrominoSubTotal,y 
        clc
        adc #1
        sta statsTetrominoSubTotal,y 
        cmp #MAX_STATS_BY_LINE
        beq increaseTetrominoReachMaxLine

        jsr STATS.draw

        jmp increaseTetrominoEnd  

    increaseTetrominoReachMaxLine:
        lda #0
        sta statsTetrominoSubTotal,y 
        lda statsTetrominoRow, y
        sec
        sbc #1
        sta statsTetrominoRow, y

    increaseTetrominoEnd:

        PopFromStack()
        rts

    calculatePositionCol:
        PushToStack()
        lda tetrominoHeight
		cmp #TETROMINO_HEIGHT_4X4
		bne positionColEnd
		//4 x 4
        tya 
        jsr MATH.multiplyBy2
        clc
        adc #HUD_STATS_POS_X_X4

		jmp positionColContinue
		positionColEnd:
		//5 x 5
        tya
        clc
        adc #HUD_STATS_POS_X_X5
		positionColContinue:    

        sta charCol

        PopFromStack()
        rts

    applyColors:
        PushToStack()

        ldy #0

        applyColorsRow:

            jsr calculatePositionCol
            //ldx statsTetrominoCol, y
            //stx charCol

            ldx #0
            stx charRow

            applyColorsColumn:

                lda tetrominoColors, y
                sta charColor
                jsr OUTPUT.changeColor

                inx
                stx charRow
                cpx #HUD_STATS_POS_Y + 1
                bne applyColorsColumn

            iny
            cpy tetrominoMax
            bne applyColorsRow

        PopFromStack()
        rts

    draw:
        PushToStack()

        ldy tetrominoNr
        
        lda statsTetrominoRow, y
        sta charRow

        jsr calculatePositionCol
        //lda statsTetrominoCol, y
        //sta charCol

        lda statsTetrominoSubTotal,y 
        clc
        adc #STATS_CHARSET
        sta charId

        jsr OUTPUT.drawChar

        PopFromStack()
        rts    
}