
STATS:
{
	init:
		PushToStack()

		ldy #0

        initStatsLoop:
            lda #0
            sta statsTetriminoTotal, y
            sta statsTetriminoSubTotal,y 
            lda #HUD_STATS_POS_Y - 1
            sta statsTetriminoRow, y

            iny
            cpy #TETRIMINO_MAX
            bne initStatsLoop
			
		PopFromStack()
		rts
        
    increaseTetrimino:
        PushToStack()

        ldy tetriminoNr
        lda statsTetriminoTotal, y
        clc
        adc #1
        sta statsTetriminoTotal, y

        lda statsTetriminoSubTotal,y 
        clc
        adc #1
        sta statsTetriminoSubTotal,y 
        cmp #MAX_STATS_BY_LINE
        beq increaseTetriminoReachMaxLine

        jsr STATS.draw

        jmp increaseTetriminoEnd  

    increaseTetriminoReachMaxLine:
        lda #0
        sta statsTetriminoSubTotal,y 
        lda statsTetriminoRow, y
        sec
        sbc #1
        sta statsTetriminoRow, y

    increaseTetriminoEnd:

        PopFromStack()
        rts

    applyColors:
        PushToStack()

        ldy #0

        applyColorsRow:

            ldx statsTetriminoCol, y
            stx tileCol

            ldx #0
            stx tileRow

            applyColorsColumn:

                lda tetriminoColors, y
                sta tileColor
                jsr TILE.changeColor

                inx
                stx tileRow
                cpx #HUD_STATS_POS_Y + 1
                bne applyColorsColumn

            iny
            cpy #TETRIMINO_MAX
            bne applyColorsRow

        PopFromStack()
        rts

    draw:
        PushToStack()

        ldy tetriminoNr
        
        lda statsTetriminoRow, y
        sta tileRow

        lda statsTetriminoCol, y
        sta tileCol

        lda statsTetriminoSubTotal,y 
        clc
        adc #STATS_CHARSET
        sta tileNr

        jsr TILE.drawChar

        PopFromStack()
        rts    
}