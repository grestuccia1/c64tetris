// ----------------------------------- HUD MACROS -----------------------------------

.macro LoadFullScreen(source, target, color_target) {
    lda #<source
    sta ZP_SOURCE_LO
    lda #>source
    sta ZP_SOURCE_HI
    
    lda #<target
    sta ZP_TARGET_LO
    lda #>target
    sta ZP_TARGET_HI

    lda #<color_target
    sta ZP_COLOR_TARGET_LO
    lda #>color_target
    sta ZP_COLOR_TARGET_HI

    ldx #4
    ldy #0
    loopLoadFullScreen:
    lda (ZP_SOURCE_LO),y
    sta (ZP_TARGET_LO),y
    lda #FONT_COLOR
    sta (ZP_COLOR_TARGET_LO),y
    iny
    bne loopLoadFullScreen        
    inc ZP_SOURCE_HI
    inc ZP_TARGET_HI
    inc ZP_COLOR_TARGET_HI
    dex                 
    bne loopLoadFullScreen 
}