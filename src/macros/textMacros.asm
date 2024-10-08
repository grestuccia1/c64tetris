
// ----------------------------------- TEXT MACROS -----------------------------------

.macro WriteText(text,col,row,color)
{
	lda #<text
	sta ZP_TEXT_LO
	lda #>text
	sta ZP_TEXT_HI

	lda #row
	sta textRow
	lda #col
	sta textCol
	lda #color
	sta textColor

	jsr OUTPUT.writeText
}

.macro SetTextColor(col,row,height,length,colorVariable)
{
	lda #row
	sta tileRow
	lda #col
	sta tileCol
	lda #length
	sta textLength
	lda #height
	sta textHeight
	lda #colorVariable
	sta textColor
	
	jsr OUTPUT.setTextColor
}
