// ----------------------------------- HUD MACROS -----------------------------------

.macro LoadCharMap(charMap,startX,startY,width,height)
{
	lda #<charMap
	sta ZP_HUD_LO
	lda #>charMap
	sta ZP_HUD_HI

	lda #startX
	sta charMapStartX
	lda #startY
	sta charMapStartY
	lda #width
	sta charMapWidth
	lda #height
	sta charMapHeight

	jsr HUD.loadCharMap
}