
// ----------------------------------- SYSTEM LIBRARY -----------------------------------

SYSTEM:
{
	setup:
		sei
		lda #%00110110 // Disable BASIC
		sta PROCESSOR_PORT
		cli

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


	start_cooldown:
		lda #$00                            // Disable the timer control register
		sta $DC0E                           

		lda #<cooldown_duration_value       // Load the low byte of the timer duration
		sta $DC04                           // Set low byte of timer A
		lda #>cooldown_duration_value       // Load the high byte of the timer duration
		sta $DC05                           // Set high byte of timer A

		lda #%00010001                      // Start Timer A in one-shot mode
		sta $DC0E                           // Write control register to start countdown

	wait_for_cooldown:
		lda $DC04                           // Read the low byte of timer A
		ora $DC05                           // Combine with the high byte of timer A
		bne wait_for_cooldown               // If timer not zero, continue waiting

		lda #$00                            // Clear control register to stop the timer
		sta $DC0E
		rts                                 // Return when cooldown is over

	check_cooldown:
		lda $DC04                			 // Load the low byte of Timer A
		ora $DC05                 			 // OR with the high byte of Timer A
		bne cooldown_active       			 // If result is non-zero, cooldown is still active
		rts                       			 // If zero, cooldown has finished

	cooldown_active:
		//CODE HERE
		rts
}
