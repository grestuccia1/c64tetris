
// ----------------------------------- TETRIMINO VARIABLES -----------------------------------

tetriminoNr: .byte 0
tetriminoRow: .byte 0
tetriminoCol: .byte 0
tetriminoRot: .byte 0

tetriminoInit: .byte 0
tetriminoEnd: .byte 4

tetriminoPX: .byte 0
tetriminoPY: .byte 0

tetriminoDirection: .byte 0

tetriminoHSpeedTimer: .byte 0
tetriminoHSpeed: .byte 2

tetriminoRotateCooldownTimer: .byte 0
tetriminoRotateCooldown: .byte 6

tetriminoFallDelayTimer: .byte 40
tetriminoFallDelay: .byte 40
tetriminoMustFall: .byte 0

tetriminoNext: .byte 0

tetriminoLowRowPosition: .byte TETRIMINO_ROW_LAST

