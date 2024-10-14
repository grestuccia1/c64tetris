
// ----------------------------------- SPRITE CONSTANTS -----------------------------------

.label SPRITE_X = $d000
.label SPRITE_Y = $d001

.label SPRITE_X_EXTENDED = $d010

.label SPRITE_ENABLE = $d015

.label SPRITE_MULTICOLOR = $d01c

.label SPRITE_BACKGROUND = $d021
.label SPRITE_EXTRA_COLOR_1 = $d025
.label SPRITE_EXTRA_COLOR_2 = $d026
.label SPRITE_COLOR = $d027

.label SPRITE_POINTER = SCREEN_RAM + $03f8
.label SPRITE_POINTER_INDEX = SPRITES_ADDRESS / 64

.label DEFAULT_SPRITE_EXTRA_COLOR_1 = $1
.label DEFAULT_SPRITE_EXTRA_COLOR_2 = $2