
// ----------------------------------- OUTPUT VARIABLES -----------------------------------

charId: .byte 0
charRow: .byte 0
charCol: .byte 0
charColor: .byte 0

charCounter: .byte 0
charMapWidth: .byte 0
charMapHeight: .byte 0
charMapStartX: .byte 0
charMapStartY: .byte 0

charCounterHigh: .byte 0

charCounterLow: .byte 0

colorCycle: .byte 0, 11, 15, 1, 15, 11, 1

drawCursorRow: .byte HUD_TETRIS_TITLE_OPTIONS_Y_POS
drawCursorIdle: .byte 0

screenControl2: .byte 0