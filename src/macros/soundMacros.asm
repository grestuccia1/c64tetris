// ----------------------------------- SOUNDS MACROS -----------------------------------

.macro playSFX(label) {
	
	lda #<label        //Start address of sound effect data 
    ldy #>label 
    ldx #14       //0, 7 or 14 for channels 1-3 
   	jsr $9503

}