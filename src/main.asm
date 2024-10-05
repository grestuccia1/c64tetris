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

*=HUD_CHAR_LEFT_MAP_ADDRESS "HUD left"
.import binary "hud/hudleft.bin"

*=HUD_CHAR_RIGHT_MAP_ADDRESS "HUD right"
.import binary "hud/hudright.bin"

*=HUD_CHAR_CENTRAL_MAP_ADDRESS "HUD central"
.import binary "hud/hudcentral.bin"

*=HUD_STATS_ADDRESS "HUD stats"
.import binary "hud/hudstats.bin"
