// ----------------------------------- GAME VARIABLES -----------------------------------

currentLevel: .byte 0

linesForLevel: .byte 0
linesNeededForNextLevel: .byte 0

tetriminoPerLevel: .byte 0

transitionRow: .byte 0
transitionRowDelayTimer: .byte 0
transitionRowDelay: .byte 2
transitionRowFinalDelay: .byte 40
transitionRowMax: .byte 23
