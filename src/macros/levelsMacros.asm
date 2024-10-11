// ----------------------------------- LEVELS MACROS -----------------------------------

.macro LoadLevel(levelLength, levelXs, levelYs, levelColors) {
    
    ldx #0

    preloadLevelLoop:
        lda levelXs, x
        sta tileCol

        lda levelYs, x
        sta tileRow

        lda levelColors, x
        sta tileColor

        lda #BLOCK
        sta tileNr

        jsr TILE.drawChar

        inx
        cpx levelLength
        bne preloadLevelLoop

}