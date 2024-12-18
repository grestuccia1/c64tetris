// ----------------------------------- LEVELS MACROS -----------------------------------

.macro LoadLevel(levelLength, levelXs, levelYs, levelColors) {
    
    ldx #0

    preloadLevelLoop:
        lda levelXs, x
        sta charCol
        lda tetrominoWideMode
        beq noWideMode
        inc charCol
        inc charCol

    noWideMode:
        lda levelYs, x
        sta charRow

        lda levelColors, x
        sta charColor

        lda #BLOCK
        sta charId

        jsr OUTPUT.drawChar

        inx
        cpx levelLength
        bne preloadLevelLoop

}