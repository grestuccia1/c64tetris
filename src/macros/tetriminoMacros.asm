// ----------------------------------- TETRIMINO MACROS -----------------------------------

.macro ClearTetriminoDirection(direction)
{
	lda tetriminoDirection
	and #%11111111 - direction
	sta tetriminoDirection
}

.macro SetTetriminoDirection(direction)
{
	lda tetriminoDirection
	ora #direction
	sta tetriminoDirection
}

.macro ChangeTetrimino(px,py) {
	lda #<px          
	sta ZP_PX_LO          

	lda #>px          
	sta ZP_PX_HI   

	lda #<py          
	sta ZP_PY_LO          

	lda #>py          
	sta ZP_PY_HI       
}

.macro DrawTetrimino(nro, row, col, rot) {
	lda #row
	sta tetriminoRow
	lda #col
	sta tetriminoCol
	lda #rot
	sta tetriminoRot
	lda #nro
	sta tetriminoNr
	jsr TETRIMINO.change
	jsr TETRIMINO.draw
}

.macro NewTetrimino() {
	ClearTetriminoDirection(ALL_DIRECTIONS)
	
	//Clear tetrimino
	ldy #HUD_CENTRAL_NEXT_POS_Y
	clearNextTetriminoRow:
	sty charRow

		ldx #HUD_CENTRAL_NEXT_POS_X
		clearNextTetriminoCol:
			stx charCol

			lda #SPACE
			sta charId

			jsr OUTPUT.drawChar

			inx
			cpx #HUD_CENTRAL_NEXT_POS_X_END
			bne clearNextTetriminoCol

		iny
		cpy #HUD_CENTRAL_NEXT_POS_Y_END
		bne clearNextTetriminoRow		

	//Draw next tetrimino
	lda #RESET_ROTATION
	sta tetriminoRot
	
	lda #HUD_CENTRAL_NEXT_POS_X
	sta tetriminoCol

	lda #HUD_CENTRAL_NEXT_POS_Y
	sta tetriminoRow

	jsr MATH.generateRandomBelow7
	lda ZP_RANDOM_NUMBER
	sta tetriminoNr
	jsr TETRIMINO.change
	jsr TETRIMINO.draw

	//Draw current tetrimino
	lda #TETRIMINO_ROW_START
	sta tetriminoRow
	lda #TETRIMINO_COL_START
	sta tetriminoCol

	lda tetriminoNext
	sta tetriminoNr
	jsr TETRIMINO.change

	lda ZP_RANDOM_NUMBER
	sta tetriminoNext

}