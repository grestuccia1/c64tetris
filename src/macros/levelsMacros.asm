// ----------------------------------- LEVELS MACROS -----------------------------------

.macro LoadLevel(levelLENGTH, levelXs, levelYs, levelColors) {
    
    ldx #0

    preloadLevelLoop:
        lda levelXs, x
        sta charCol
        lda tetriminoWideMode
        beq noWideMode
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
        cpx levelLENGTH
        bne preloadLevelLoop

}