
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

.const NUM_BYTES = 1000