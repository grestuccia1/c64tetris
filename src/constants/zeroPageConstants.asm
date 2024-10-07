
// ----------------------------------- ZERO PAGE CONSTANTS -----------------------------------

.label ZP_ROW_LO			    = ZERO_PAGE_ADDRESS + 0
.label ZP_ROW_HI			    = ZERO_PAGE_ADDRESS + 1
.label ZP_ROW_COLOR_LO		    = ZERO_PAGE_ADDRESS + 2
.label ZP_ROW_COLOR_HI		    = ZERO_PAGE_ADDRESS + 3
.label ZP_PX_LO			        = ZERO_PAGE_ADDRESS + 4
.label ZP_PX_HI			        = ZERO_PAGE_ADDRESS + 5
.label ZP_PY_LO			        = ZERO_PAGE_ADDRESS + 6
.label ZP_PY_HI			        = ZERO_PAGE_ADDRESS + 7
.label ZP_RANDOM_NUMBER         = ZERO_PAGE_ADDRESS + 8
.label ZP_HUD_LO			    = ZERO_PAGE_ADDRESS + 9
.label ZP_HUD_HI			    = ZERO_PAGE_ADDRESS + 10
.label ZP_ROW_PREVIOUS_LO		= ZERO_PAGE_ADDRESS + 11
.label ZP_ROW_PREVIOUS_HI		= ZERO_PAGE_ADDRESS + 12
.label ZP_ROW_COLOR_PREVIOUS_LO	= ZERO_PAGE_ADDRESS + 13
.label ZP_ROW_COLOR_PREVIOUS_HI	= ZERO_PAGE_ADDRESS + 14

.label ZP_SOURCE_LO             = ZERO_PAGE_ADDRESS + 15
.label ZP_SOURCE_HI             = ZERO_PAGE_ADDRESS + 16
.label ZP_TARGET_LO             = ZERO_PAGE_ADDRESS + 17
.label ZP_TARGET_HI             = ZERO_PAGE_ADDRESS + 18
.label ZP_COLOR_TARGET_LO       = ZERO_PAGE_ADDRESS + 19
.label ZP_COLOR_TARGET_HI       = ZERO_PAGE_ADDRESS + 20