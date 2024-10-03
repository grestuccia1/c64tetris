
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
		
		lda #DEFAULT_SCREEN_BORDER_COLOR
		sta SCREEN_BORDER_COLOR
		lda #DEFAULT_SCREEN_BACKGROUND_COLOR
		sta SCREEN_BACKGROUND_COLOR

		lda #>SCREEN_RAM
		sta SCREEN_RAM_HIGH_BYTE

		jsr SCREEN_CLEAR

		jsr INTERRUPT.setupRasterInterrupt
		rts

	delay:
		txa
		pha
		tya
		pha

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
			
		pla
		tay
		pla
		tax
		rts

}
