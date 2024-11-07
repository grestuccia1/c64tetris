
// ----------------------------------- OUTPUT MACROS -----------------------------------

.macro DrawChar(char,row,col,color)
{
	lda #char
	sta charId
	lda #row
	sta charRow
	lda #col
	sta charCol
	lda #color
	sta charColor

	jsr OUTPUT.drawChar
}


.macro DebugBorder(color) {
	.if (DEBUG) {
    	lda #color         
    	sta SCREEN_BORDER_COLOR
	}
}