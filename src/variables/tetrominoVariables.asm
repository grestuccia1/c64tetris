
// ----------------------------------- TETROMINO VARIABLES -----------------------------------

tetrominoNr:                .byte 0
tetrominoRow:               .byte 0
tetrominoCol:               .byte 0
tetrominoRot:               .byte 0

tetrominoInit:              .byte 0
tetrominoEnd:               .byte 4

tetrominoPX:                .byte 0
tetrominoPY:                .byte 0

tetrominoDirection:         .byte 0

tetrominoHSpeedTimer:       .byte 0
tetrominoHSpeed:            .byte 2

tetrominoRotateCooldownTimer: .byte 0
tetrominoRotateCooldown:    .byte 6

tetrominoFallDelayTimer:    .byte 40
tetrominoFallDelay:         .byte 40
tetrominoMustFall:          .byte 0

tetrominoNext:              .byte 0


tetrominoDynamicLastCol:    .byte TETROMINO_COL_LAST
tetrominoDynamicRowLength:  .byte TETROMINO_ROW_LENGTH

tetrominoWideMode:          .byte 0

tetrominoCompletedLines:    .byte 0
                            .byte 0
                            .byte 0 
                            .byte 0
                            .byte 0

tetrominoCompletedLinesIndex: .byte 0

tetrominoHeight:            .byte TETROMINO_HEIGHT_4X4 
tetrominoMax:               .byte TETROMINO_MAX_4X4