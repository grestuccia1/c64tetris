// ----------------------------------- TETROMINO MACROS -----------------------------------

.macro ClearTetrominoDirection(direction)
{
 	lda tetrominoDirection
	and #%11111111 - direction
	sta tetrominoDirection
}

.macro SetTetrominoDirection(direction)
{
	lda tetrominoDirection
	ora #direction
	sta tetrominoDirection
}

.macro ChangeTetromino(px,py) {
	lda #<px          
	sta ZP_PX_LO          

	lda #>px          
	sta ZP_PX_HI   

	lda #<py          
	sta ZP_PY_LO          

	lda #>py          
	sta ZP_PY_HI       
}

.macro DrawTetromino(nro, row, col, rot) {
	lda #row
	sta tetrominoRow
	lda #col
	sta tetrominoCol
	lda #rot
	sta tetrominoRot
	lda #nro
	sta tetrominoNr
	jsr TETROMINO.change
	jsr TETROMINO.draw
}

.macro NewTetromino() {
	ClearTetrominoDirection(ALL_DIRECTIONS)
	
	//Clear tetromino
 	ldy #HUD_CENTRAL_NEXT_POS_Y
	
	ldx tetrominoHeight
	cpx #TETROMINO_HEIGHT_4X4
	beq noNeedDecrementPositionNewTetromino
	dey
	noNeedDecrementPositionNewTetromino:

	clearNextTetrominoRow:
	sty charRow

		ldx #HUD_CENTRAL_NEXT_POS_X
		clearNextTetrominoCol:
			stx charCol

			lda #SPACE
			sta charId

			jsr OUTPUT.drawChar

			inx
			cpx #HUD_CENTRAL_NEXT_POS_X_END
			bne clearNextTetrominoCol

		iny
		cpy #HUD_CENTRAL_NEXT_POS_Y_END
		bne clearNextTetrominoRow		

	//Draw next tetromino
	lda #RESET_ROTATION
	sta tetrominoRot
	
	lda #HUD_CENTRAL_NEXT_POS_X
	sta tetrominoCol

	ldy #HUD_CENTRAL_NEXT_POS_Y
	sty tetrominoRow

	ldx tetrominoHeight
	cpx #TETROMINO_HEIGHT_4X4
	bne mustGenerateByX5
	jsr MATH.generateRandomBelow7
	jmp randomContinue
	mustGenerateByX5:
	jsr MATH.generateRandomBelow18
	randomContinue:

	lda ZP_RANDOM_NUMBER
	sta tetrominoNr
	jsr TETROMINO.change
	jsr TETROMINO.draw

	//Draw current tetromino
	lda #TETROMINO_ROW_START
	sta tetrominoRow
	ldy #TETROMINO_COL_START
	ldx tetrominoHeight
	cpx #TETROMINO_HEIGHT_4X4
	beq moveXStartPosition
	iny
	moveXStartPosition:
	tya

	sta tetrominoCol

	lda tetrominoWideMode
	beq noWideMode
	inc tetrominoCol
	inc tetrominoCol

    noWideMode:

		lda tetrominoNext
		sta tetrominoNr
		jsr TETROMINO.change

		lda ZP_RANDOM_NUMBER
		sta tetrominoNext

}