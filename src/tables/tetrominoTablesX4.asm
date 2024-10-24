// ----------------------------------- TETROMINO TABLES -----------------------------------

TETROMINO_I_X:
.byte 0, 1, 2, 3, 1, 1, 1, 1, 0, 1, 2, 3, 1, 1, 1, 1

TETROMINO_I_Y:
.byte 1, 1, 1, 1, 0, 1, 2, 3, 1, 1, 1, 1, 0, 1, 2, 3

TETROMINO_J_X:
.byte 0, 1, 2, 2, 1, 1, 0, 1, 0, 0, 1, 2, 1, 2, 1, 1

TETROMINO_J_Y:
.byte 1, 1, 1, 2, 0, 1, 2, 2, 0, 1, 1, 1, 0, 0, 1, 2

TETROMINO_L_X:
.byte 2, 0, 1, 2, 1, 1, 1, 2, 0, 1, 2, 0, 0, 1, 1, 1

TETROMINO_L_Y:
.byte 0, 1, 1, 1, 0, 1, 2, 2, 1, 1, 1, 2, 0, 0, 1, 2

TETROMINO_O_X:
.byte 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2

TETROMINO_O_Y:
.byte 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2

TETROMINO_S_X:
.byte 1, 2, 0, 1, 0, 0, 1, 1, 1, 2, 0, 1, 0, 0, 1, 1

TETROMINO_S_Y:
.byte 0, 0, 1, 1, 0, 1, 1, 2, 0, 0, 1, 1, 0, 1, 1, 2

TETROMINO_T_X:
.byte 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 1, 1, 1, 2, 1

TETROMINO_T_Y:
.byte 0, 1, 1, 1, 0, 1, 1, 2, 1, 1, 1, 2, 0, 1, 1, 2

TETROMINO_Z_X:
.byte 0, 1, 1, 2, 1, 0, 1, 0, 0, 1, 1, 2, 1, 0, 1, 0

TETROMINO_Z_Y:
.byte 0, 0, 1, 1, 0, 1, 1, 2, 0, 0, 1, 1, 0, 1, 1, 2

tetrominoPositionsX_LO:
    .byte <TETROMINO_I_X, <TETROMINO_J_X, <TETROMINO_L_X, <TETROMINO_O_X, <TETROMINO_S_X, <TETROMINO_T_X, <TETROMINO_Z_X 

tetrominoPositionsX_HI:
    .byte >TETROMINO_I_X, >TETROMINO_J_X, >TETROMINO_L_X, >TETROMINO_O_X, >TETROMINO_S_X, >TETROMINO_T_X, >TETROMINO_Z_X 

tetrominoPositionsY_LO:
    .byte <TETROMINO_I_Y, <TETROMINO_J_Y, <TETROMINO_L_Y, <TETROMINO_O_Y, <TETROMINO_S_Y, <TETROMINO_T_Y, <TETROMINO_Z_Y  

tetrominoPositionsY_HI:
    .byte >TETROMINO_I_Y, >TETROMINO_J_Y, >TETROMINO_L_Y, >TETROMINO_O_Y, >TETROMINO_S_Y, >TETROMINO_T_Y, >TETROMINO_Z_Y 