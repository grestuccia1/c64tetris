// ----------------------------------- SPRITE MACROS -----------------------------------

.macro ShowFolkRussianDancer(posY,posX)
{
        lda #posX
        sta SPRITE_X

        lda #posY
        sta SPRITE_Y

        lda #%00000001
        sta SPRITE_ENABLE

        lda firstSpriteAnimGraphic
        clc
        adc #SPRITE_POINTER_INDEX
        sta SPRITE_POINTER
}

.macro HideFolkRussianDancer()
{
        lda #%00000000
        sta SPRITE_ENABLE
}

.macro AnimatesFolkRussianDancer()
{
        lda firstSpriteAnimGraphic
        clc
        adc #SPRITE_POINTER_INDEX
        sta SPRITE_POINTER

        lda firstSpriteAnimGraphic
        cmp #28
        beq maxFrameReached
        bcs maxFrameReached
        inc firstSpriteAnimGraphic
        jmp continueAnimatesDancing
    maxFrameReached:
        lda #0
        sta firstSpriteAnimGraphic

    continueAnimatesDancing:    
}