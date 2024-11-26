// ----------------------------------- SOUNDS MACROS -----------------------------------

.macro playSFX(label) {
	
	lda #<label   
    ldy #>label 
    ldx #14       
   	jsr $9503

}