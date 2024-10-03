// ----------------------------------- TETRIMINO TABLES -----------------------------------

TETRIMINO_I_X:
.byte 0, 1, 2, 3, 1, 1, 1, 1, 0, 1, 2, 3, 1, 1, 1, 1

TETRIMINO_I_Y:
.byte 1, 1, 1, 1, 0, 1, 2, 3, 1, 1, 1, 1, 0, 1, 2, 3

TETRIMINO_J_X:
.byte 0, 1, 2, 2, 1, 1, 0, 1, 0, 0, 1, 2, 1, 2, 1, 1

TETRIMINO_J_Y:
.byte 1, 1, 1, 2, 0, 1, 2, 2, 0, 1, 1, 1, 0, 0, 1, 2

TETRIMINO_L_X:
.byte 2, 0, 1, 2, 1, 1, 1, 2, 0, 1, 2, 0, 0, 1, 1, 1

TETRIMINO_L_Y:
.byte 0, 1, 1, 1, 0, 1, 2, 2, 1, 1, 1, 2, 0, 0, 1, 2

TETRIMINO_O_X:
.byte 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2

TETRIMINO_O_Y:
.byte 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2

TETRIMINO_S_X:
.byte 1, 2, 0, 1, 0, 0, 1, 1, 1, 2, 0, 1, 0, 0, 1, 1

TETRIMINO_S_Y:
.byte 0, 0, 1, 1, 0, 1, 1, 2, 0, 0, 1, 1, 0, 1, 1, 2

TETRIMINO_T_X:
.byte 1, 0, 1, 2, 1, 0, 1, 1, 0, 1, 2, 1, 1, 1, 2, 1

TETRIMINO_T_Y:
.byte 0, 1, 1, 1, 0, 1, 1, 2, 1, 1, 1, 2, 0, 1, 1, 2

TETRIMINO_Z_X:
.byte 0, 1, 1, 2, 1, 0, 1, 0, 0, 1, 1, 2, 1, 0, 1, 0

TETRIMINO_Z_Y:
.byte 0, 0, 1, 1, 0, 1, 1, 2, 0, 0, 1, 1, 0, 1, 1, 2

tetriminoColors:
    .byte TETRIMINO_I_COLOR
    .byte TETRIMINO_J_COLOR
    .byte TETRIMINO_L_COLOR
    .byte TETRIMINO_O_COLOR
    .byte TETRIMINO_S_COLOR
    .byte TETRIMINO_T_COLOR
    .byte TETRIMINO_Z_COLOR

tetriminoPositionsX_LO:
    .byte <TETRIMINO_I_X, <TETRIMINO_J_X, <TETRIMINO_L_X, <TETRIMINO_O_X, <TETRIMINO_S_X, <TETRIMINO_T_X, <TETRIMINO_Z_X 

tetriminoPositionsX_HI:
    .byte >TETRIMINO_I_X, >TETRIMINO_J_X, >TETRIMINO_L_X, >TETRIMINO_O_X, >TETRIMINO_S_X, >TETRIMINO_T_X, >TETRIMINO_Z_X 

tetriminoPositionsY_LO:
    .byte <TETRIMINO_I_Y, <TETRIMINO_J_Y, <TETRIMINO_L_Y, <TETRIMINO_O_Y, <TETRIMINO_S_Y, <TETRIMINO_T_Y, <TETRIMINO_Z_Y  

tetriminoPositionsY_HI:
    .byte >TETRIMINO_I_Y, >TETRIMINO_J_Y, >TETRIMINO_L_Y, >TETRIMINO_O_Y, >TETRIMINO_S_Y, >TETRIMINO_T_Y, >TETRIMINO_Z_Y 