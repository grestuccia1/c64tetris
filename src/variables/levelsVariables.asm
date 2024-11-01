// ----------------------------------- GAME VARIABLES -----------------------------------

currentLevel: .byte 0

linesForLevel: .byte 0
linesNeededForNextLevel: .byte 0

tetrominoPerLevelSpeedUp: .byte 0
tetrominoPerLevelMoveLinesUpClean: .byte 0
tetrominoPerLevelNewRandomTopBlock: .byte 0

transitionRow: .byte 0
transitionRowDelay: .byte 2
transitionRowMax: .byte 23
transitionCol: .byte 0