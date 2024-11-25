.const DEBUG = false

#import "system/memoryMap.asm"
#import "system/config.asm"
#import "includes/constants.asm"
#import "includes/macros.asm"

.var music_game_over = LoadSid("assets/music/muse_menu.sid")
.var music_in_game_one = LoadSid("assets/music/racer_x_one.sid")
.var music_in_game_two = LoadSid("assets/music/racer_x_two.sid")
.var music_in_game_three = LoadSid("assets/music/racer_x_three.sid")
.var music_in_game_four = LoadSid("assets/music/racer_x_four.sid")

BasicUpstart2(main)

*=TABLES_ADDRESS "Tables"
#import "includes/tables.asm"

*=VARIABLES_ADDRESS "Variables"
#import "includes/variables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "includes/libraries.asm"

*=GAME_CODE "Game Code"
#import "includes/gameCode.asm"

*=music_game_over.location "Music menu and game over"
.fill music_game_over.size, music_game_over.getData(i)

*=music_in_game_one.location "Music in game one"
.fill music_in_game_one.size, music_in_game_one.getData(i)

*=music_in_game_two.location "Music in game two"
.fill music_in_game_two.size, music_in_game_two.getData(i)

*=music_in_game_three.location "Music in game three"
.fill music_in_game_three.size, music_in_game_three.getData(i)

*=music_in_game_four.location "Music in game four"
.fill music_in_game_four.size, music_in_game_four.getData(i)

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
