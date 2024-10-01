// ----------------------------------- TETRIMINO MACROS -----------------------------------

.macro ClearTetriminoDirection(direction)
{
	lda Tetrimino_Direction
	and #%11111111 - direction
	sta Tetrimino_Direction
}

.macro SetTetriminoDirection(direction)
{
	lda Tetrimino_Direction
	ora #direction
	sta Tetrimino_Direction
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