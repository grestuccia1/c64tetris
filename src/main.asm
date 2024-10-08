#import "system/memoryMap.asm"
#import "system/config.asm"
#import "includes/constants.asm"
#import "includes/macros.asm"

BasicUpstart2(main)

*=TABLES_ADDRESS "Tables"
#import "includes/tables.asm"

*=VARIABLES_ADDRESS "Variables"
#import "includes/variables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "includes/libraries.asm"

*=GAME_CODE "Game Code"
#import "includes/gameCode.asm"

*=CHARSET_ADDRESS "Charset"
.import binary "charset/charset.bin"

*=HUD_GAMEPLAY_ADDRESS "HUD gameplay"
.import binary "hud/hudgameplay.bin"

*=HUD_TETRIS_TITLE_ADDRESS "HUD Tetris Title"
.import binary "hud/tetrisTitle.bin"

*=HUD_TETRIS_TITLE_COLORS_ADDRESS "HUD Tetris Title Colors"
.import binary "hud/tetrisTitleColors.bin"

*=HUD_GAME_OVER_ADDRESS "HUD gameover"
.import binary "hud/hudgameover.bin"