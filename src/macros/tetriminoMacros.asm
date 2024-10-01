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

.macro SelectTetrimino(row, col, rot) {
	lda #row
	sta tetriminoRow
	lda #col
	sta tetriminoCol
	lda #rot
	sta tetriminoRot
}

.macro NewTetrimino() {
	ClearTetriminoDirection(ALL_DIRECTIONS)
	lda #0
	sta tetriminoRow
	lda #4
	sta tetriminoCol
	lda #0
	sta tetriminoRot
	jsr MATH.generate_random
	lda RANDOM_NUMBER
	sta tetriminoNr
	jsr TETRIMINO.change
}