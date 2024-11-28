
// ----------------------------------- SCREEN CONSTANTS -----------------------------------

.label SCREEN_RAM = $0400
.label SCREEN_COLOR_RAM = $d800

.label SCREEN_CONTROL_1 = $d011
.label SCREEN_CONTROL_2 = $d016
.label SCREEN_MEMORY_SETUP = $d018

.label SCREEN_BORDER_COLOR = $d020
.label SCREEN_BACKGROUND_COLOR = $d021
.label SCREEN_EXTRA_COLOR_1 = $d022
.label SCREEN_EXTRA_COLOR_2 = $d023

.label SCREEN_CLEAR = $e544

.label SCREEN_RAM_HIGH_BYTE = $0288

START_MESSAGE: 
.encoding "screencode_upper"
.text "START" 
.byte 0

TETROMINO_MESSAGE: 
.encoding "screencode_upper"
.text "CHANGE TETROMINO: 4X4" 
.byte 0

CHANGE_MODE_MESSAGE: 
.encoding "screencode_upper"
.text "CHANGE MODE: NORMAL" 
.byte 0

WIDE_MODE_MESSAGE: 
.encoding "screencode_upper"
.text "WIDE   " 
.byte 0

NORMAL_MODE_MESSAGE: 
.encoding "screencode_upper"
.text "NORMAL" 
.byte 0

TETROMINO_4X4_MESSAGE: 
.encoding "screencode_upper"
.text "4X4" 
.byte 0

TETROMINO_5X5_MESSAGE: 
.encoding "screencode_upper"
.text "5X5" 
.byte 0

CHANGE_LEVEL_MESSAGE: 
.encoding "screencode_upper"
.text "CHANGE LEVEL: 01" 
.byte 0


START_LEVEL_NUMBER: 
.encoding "screencode_upper"
.text "LEVEL: 01" 
.byte 0

REX_MESSAGE: 
.encoding "screencode_upper"
.text "REX 2024 V1'0" 
.byte 0



GAME_OVER_MESSAGE: 
.encoding "screencode_upper"
.text "FIRE TO CONTINUE" 
.byte 0

.const MAX_COLOR_TRANSITION = 29
