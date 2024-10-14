#import "system/memoryMap.asm"
#import "system/config.asm"
#import "includes/constants.asm"
#import "includes/macros.asm"

.var music = LoadSid("music/racer_x.sid")

BasicUpstart2(main)

*=TABLES_ADDRESS "Tables"
#import "includes/tables.asm"

*=VARIABLES_ADDRESS "Variables"
#import "includes/variables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "includes/libraries.asm"

*=GAME_CODE "Game Code"
#import "includes/gameCode.asm"

*=music.location "Music"
.fill music.size, music.getData(i)

*=CHARSET_ADDRESS "Charset"
.import binary "charset/charset.bin"

*=HUD_GAMEPLAY_ADDRESS "HUD gameplay"
.import binary "hud/hudgameplay.bin"

*=HUD_TETRIS_TITLE_ADDRESS "HUD Tetris Title"
.import binary "hud/tetrisTitle.bin"

*=HUD_TETRIS_TITLE_COLORS_ADDRESS "HUD Tetris Title Colors"
.import binary "hud/tetrisTitleColors.bin"

*=HUD_GAME_OVER_TITLE_ADDRESS "HUD Game Over"
.import binary "hud/gameOverTitle.bin"

*=HUD_GAME_OVER_TITLE_COLORS_ADDRESS "HUD Game Over Title Colors"
.import binary "hud/gameOverTitleColors.bin"

*=SPRITES_ADDRESS "Sprites"
.import binary "sprites/dancer.bin"
