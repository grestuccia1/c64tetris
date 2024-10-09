
// ----------------------------------- TILE LIBRARY -----------------------------------

TILE:
{
	drawChar:
		PushToStack()

		ldx tileRow
		cpx #TETRIMINO_ROW_OOR
		bcs drawCharOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy tileCol

		lda tileNr
		sta (ZP_ROW_LO),y

		lda tileColor
		sta (ZP_ROW_COLOR_LO),y

		drawCharOOR:
			PopFromStack()
			rts

	getChar:
		PushToStack()

		ldx tileRow
		cpx #TETRIMINO_ROW_OOR
		bcs getCharOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy tileCol

		lda (ZP_ROW_LO),y
		sta charCollision

		lda (ZP_ROW_COLOR_LO), y
		sta colorCollision

		getCharOOR:

			PopFromStack()
			rts

	changeColor:
		PushToStack()

		ldx tileRow
		cpx #TETRIMINO_ROW_OOR
		bcs changeColorOOR

		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy tileCol

		lda tileColor
		sta (ZP_ROW_COLOR_LO),y

		changeColorOOR:
			PopFromStack()
			rts

	drawTile:
		PushToStack()

		lda tileRow
		asl
		tax
		cpx #TETRIMINO_ROW_OOR
		bcs drawTileOOR

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda tileCol
		asl
		tay

		lda tileNr
		asl
		asl
		tax

		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		stx tempX
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		iny

		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		stx tempX
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		tya
		clc
		adc #SCREEN_WIDTH - 1
		tay

		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		stx tempX
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		iny

		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y

		drawTileOOR:
			PopFromStack()
			rts

}
