// ----------------------------------- SOUNDS MACROS -----------------------------------

.macro changeSong(number) {
    lda #number
    sta currentSong
    jsr MUSIC.change
}

.macro playRandomSong() {
    getRandomSongAvoidRepeat()
    lda lastRandom
    clc
    adc #1
    sta currentSong
    jsr MUSIC.change
}

.macro getRandomSongAvoidRepeat() {
    generateRandom:
        lda $d012   
        eor $d013   
        and #$03    
        cmp lastRandom  
        beq generateRandom

    sta lastRandom      
}