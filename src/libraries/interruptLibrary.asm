
// ----------------------------------- INTERRUPT LIBRARY -----------------------------------

INTERRUPT:
{
	setupRasterInterrupt:

		sei 									// Disable interrupt requests

		jsr CLOCK.setupPalOrNtsc

		lda #%01111111
		sta INTERRUPT_CONTROL_AND_STATUS_CIA_1	// Disable interrupt signals from CIA 1
		sta INTERRUPT_CONTROL_AND_STATUS_CIA_2	// Disable interrupt signals from CIA 2

		lda INTERRUPT_CONTROL_AND_STATUS_CIA_1	// Acknowledge pending interrupts from CIA 1
		lda INTERRUPT_CONTROL_AND_STATUS_CIA_2	// Acknowledge pending interrupts from CIA 2

		lda SCREEN_CONTROL_1
		and #%01111111							// Clear bit 7 since we are not using raster interrupts
		ora #$0b
		sta SCREEN_CONTROL_1					// past raster line 255

		lda SCREEN_CONTROL_2
		sta screenControl2

		lda #250								// Raster line to trigger a raster interrupt
		sta CURRENT_RASTER_LINE

		lda #<irq								// Low byte of the address for our interrupt routine
		sta INTERRUPT_SERVICE_LO
		lda #>irq								// High byte of the address for our interrupt routine
		sta INTERRUPT_SERVICE_HI

		lda INTERRUPT_CONTROL
		ora #%00000001							// Enable raster interrupts
		sta INTERRUPT_CONTROL

		cli 									// Enable interrupt requests
		rts


	enableRasterInterrupt:
		lda INTERRUPT_CONTROL
		ora #%00000001							// Enable raster interrupts
		sta INTERRUPT_CONTROL
		rts


	disableRasterInterrupt:
		lda INTERRUPT_CONTROL
		and #%11111110							// Disable raster interrupts
		sta INTERRUPT_CONTROL
		rts

	irq:
		lda INTERRUPT_STATUS
		ora #%00000001 							// Acknowledge raster interrupt
		sta INTERRUPT_STATUS

		DebugBorder(RED_COLOR)

		jsr COORDINATOR.gamePlay

		lda playMusic
		beq skipMusic
		jsr MUSIC_PLAY
		skipMusic:

		jsr CLOCK.ticks

		jsr CLOCK.update

		jsr CLOCK.draw

		DebugBorder(BLACK_COLOR)

		jmp INTERRUPT_RETURN					// KERNAL interrupt return routine

}

