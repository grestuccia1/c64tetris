
// ----------------------------------- SYSTEM LIBRARY -----------------------------------

SYSTEM:
{
	setup:
		sei
		lda #DISABLED_BASIC
		sta PROCESSOR_PORT
		cli

		lda #SCREEN_0400_CHARSET_3800
		sta SCREEN_MEMORY_SETUP
		
		lda #%11111111 
		sta SPRITE_MULTICOLOR

		lda #DEFAULT_SCREEN_BORDER_COLOR
		sta SCREEN_BORDER_COLOR
		lda #DEFAULT_SCREEN_BACKGROUND_COLOR
		sta SCREEN_BACKGROUND_COLOR

		lda #DEFAULT_SPRITE_EXTRA_COLOR_1
		sta SPRITE_EXTRA_COLOR_1
		lda #DEFAULT_SPRITE_EXTRA_COLOR_2
		sta SPRITE_EXTRA_COLOR_2

		lda #BLACK_COLOR
		sta SPRITE_BACKGROUND

		lda #DARK_GREY_COLOR
		sta SPRITE_COLOR

		lda #>SCREEN_RAM
		sta SCREEN_RAM_HIGH_BYTE

		jsr SCREEN_CLEAR

		lda #0
		tay
		tax
		jsr MUSIC_INIT

		jsr INTERRUPT.setupRasterInterrupt
		rts

	delay:
		PushToStack()

		ldx #0

		delayLoop1:
			ldy #0

			delayLoop2:
				iny
				cpy delayTimer2
				bne delayLoop2

			inx
			cpx delayTimer1
			bne delayLoop1
			
		PopFromStack()
		rts

}
