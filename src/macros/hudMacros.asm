// ----------------------------------- HUD MACROS -----------------------------------

.macro LoadFullScreen(source) {
    
    jsr SCREEN_CLEAR

    lda #<source
    sta ZP_SOURCE_LO
    lda #>source
    sta ZP_SOURCE_HI
    
    lda #<SCREEN_RAM
    sta ZP_TARGET_LO
    lda #>SCREEN_RAM
    sta ZP_TARGET_HI

    lda #<SCREEN_COLOR_RAM
    sta ZP_COLOR_TARGET_LO
    lda #>SCREEN_COLOR_RAM
    sta ZP_COLOR_TARGET_HI

    ldx #4
    ldy #0
    loopLoadFullScreen:
    lda (ZP_SOURCE_LO),y
    sta (ZP_TARGET_LO),y
    lda #FONT_COLOR
    sta (ZP_COLOR_TARGET_LO),y
    iny
    bne loopLoadFullScreen        
    inc ZP_SOURCE_HI
    inc ZP_TARGET_HI
    inc ZP_COLOR_TARGET_HI
    dex                 
    bne loopLoadFullScreen 
}

.macro LoadCharMap(charMap,startX,startY,width,height)
{
	lda #<charMap
	sta ZP_HUD_LO
	lda #>charMap
	sta ZP_HUD_HI

	lda #startX
	sta charMapStartX
	lda #startY
	sta charMapStartY
	lda #width
	sta charMapWidth
	lda #height
	sta charMapHeight

	jsr HUD.loadCharMap
}

.macro LoadCharColorMap(charMap, charColorMap, startX,startY,width,height)
{
	lda #<charMap
	sta ZP_HUD_LO
	lda #>charMap
	sta ZP_HUD_HI

	lda #<charColorMap
	sta ZP_HUD_COLOR_LO
	lda #>charColorMap
	sta ZP_HUD_COLOR_HI

	lda #startX
	sta charMapStartX
	lda #startY
	sta charMapStartY
	lda #width
	sta charMapWidth
	lda #height
	sta charMapHeight

	jsr HUD.loadCharMapColor
}

.macro AddToScore(value,place)
{
	lda #value
	sta tempScore

	UpdateScore(place)	
}

.macro UpdateScore(place)
{
	txa
	pha

	ldx #place

	lda score100000,x
	clc
	adc tempScore
	sta score100000,x

	verifyNextScoreValue:
		lda score100000,x
		cmp #10
		bcs incNextScoreValue
			jmp updateHUDscore
		incNextScoreValue:
			sec
			sbc	#10
			sta score100000,x
			dex
			inc score100000,x
			jmp verifyNextScoreValue

		updateHUDscore:
			jsr HUD.updateScore

			pla
			tax
}


.macro AddLineCounter()
{
	txa
	pha

	ldx #5

	lda lines100000,x
	clc
	adc #1
	sta lines100000,x

	verifyNextLinesValue:
		lda lines100000,x
		cmp #10
		bcs incNextLinesValue
			jmp updateHUDLines
		incNextLinesValue:
			sec
			sbc	#10
			sta lines100000,x
			dex
			inc lines100000,x
			jmp verifyNextLinesValue

		updateHUDLines:
			jsr HUD.updateLinesCounter

			pla
			tax
}