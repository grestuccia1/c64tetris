// ----------------------------------- TETRIMINO MACROS -----------------------------------

.macro ClearTetriminoDirection(direction)
{
	lda Tetrimino_Direction,x
	and #%11111111 - direction
	sta Tetrimino_Direction,x
}

.macro SetTetriminoDirection(direction)
{
	lda Tetrimino_Direction,x
	ora #direction
	sta Tetrimino_Direction,x
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