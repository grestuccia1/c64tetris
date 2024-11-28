// ----------------------------------- SOUNDS MACROS -----------------------------------

.macro randomSong() {
	
	jsr MATH.generateRandomSong
    lda ZP_RANDOM_NUMBER
    tay
    tax
    jsr MUSIC_INIT

}