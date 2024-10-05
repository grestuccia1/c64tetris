// ----------------------------------- HUD MACROS -----------------------------------

.macro DrawTetrimino(row, col)
{
    jsr MATH.generate_random
	lda ZP_RANDOM_NUMBER
	sta tetriminoNr
	SelectTetrimino(row, col, 0)
	jsr TETRIMINO.change
	jsr TETRIMINO.draw
}