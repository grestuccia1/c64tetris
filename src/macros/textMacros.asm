
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
	sta charRow
	lda #col
	sta charCol
	lda #length
	sta textLENGTH
	lda #height
	sta textHeight
	lda #colorVariable
	sta textColor
	
	jsr OUTPUT.setTextColor
}

.macro SetTextColorStored(col,row,height,length)
{
	lda #row
	sta charRow
	lda #col
	sta charCol
	lda #length
	sta textLENGTH
	lda #height
	sta textHeight
	
	jsr OUTPUT.setTextColor
}

.macro FillRectangle(col,row,height,length,char) {

	lda #row
	sta charRow
	lda #col
	sta charCol
	lda #length
	sta textLENGTH
	lda #height
	sta textHeight
	lda #char
	sta textChar

	jsr OUTPUT.fillText

}