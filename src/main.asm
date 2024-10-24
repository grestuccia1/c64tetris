.const DEBUG = false

#import "system/memoryMap.asm"
#import "system/config.asm"
#import "includes/constants.asm"
#import "includes/macros.asm"

.var music = LoadSid("assets/music/racer_x.sid")

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
.import binary "assets/charset/charset.bin"

*=HUD_REX_ADDRESS "HUD rex"
.import binary "assets/hud/rex.bin"

*=HUD_GAMEPLAY_ADDRESS "HUD gameplay"
.import binary "assets/hud/hudgameplay.bin"

*=HUD_TETRIS_TITLE_ADDRESS "HUD Tetris Title"
.import binary "assets/hud/tetrisTitle.bin"

*=HUD_5X5_STATS_ADDRESS "HUD 5x5 Stats"
.import binary "assets/hud/5x5Stats.bin"

*=HUD_TETRIS_TITLE_COLORS_ADDRESS "HUD Tetris Title Colors"
.import binary "assets/hud/tetrisTitleColors.bin"

*=HUD_GAME_OVER_TITLE_ADDRESS "HUD Game Over"
.import binary "assets/hud/gameOverTitle.bin"

*=HUD_GAME_OVER_TITLE_COLORS_ADDRESS "HUD Game Over Title Colors"
.import binary "assets/hud/gameOverTitleColors.bin"

*=SPRITES_ADDRESS "Sprites"
.import binary "assets/sprites/dancer.bin"
