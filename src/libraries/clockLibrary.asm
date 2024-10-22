
// ----------------------------------- CLOCK LIBRARY -----------------------------------

CLOCK:
{

    setupPalOrNtsc:
        ldy #$04
        ld_DEY:           
        ldx #$88
        waitline:         
            cpy CURRENT_RASTER_LINE
            bne waitline
            dex
            bmi ld_DEY + 1
        loop:  
            lda CURRENT_RASTER_LINE - $7f,x
            dey
            bne loop
            and #$03
            and #%00000010    
            beq isPal    

            lda #NTSC_RASTER
            jmp doneSetupPalOrNtsc
        isPal:
            lda #PAL_RASTER

    doneSetupPalOrNtsc:
            sta irq_counter_setup  
            sta irq_counter 
            rts

    update:
        PushToStack()

        lda clockStart
        cmp #0
        beq endUpdateClock

        dec irq_counter
        bne endUpdateClock
        lda irq_counter_setup
        sta irq_counter  


        lda showColon
        eor #1
        sta showColon

        inc seconds
        lda seconds        
        cmp #60
        bne endUpdateClock             
        inc minutes
        lda #0
        sta seconds

        endUpdateClock: 
        
        PopFromStack()   
        rts

    reset:
        lda #0
        sta minutes
        sta seconds
        rts

    stop:
        lda #0
        sta clockStart
        rts

    start:
        jsr reset
        lda #1
        sta clockStart
        rts    

    draw:
        PushToStack()

        lda clockStart
        cmp #0
        beq endDraw
        
        lda #0
        sta clockOffset

        lda minutes
        jsr printTwoDigits

        lda showColon
        bne endShowColon
        lda #':'
        jmp drawColon
        endShowColon:
        lda #' '
        drawColon:
        jsr drawChar

        lda seconds
        jsr printTwoDigits

    endDraw:

        PopFromStack() 
        rts

   printTwoDigits:

    jsr MATH.divideBy10
    sta units
    txa    
    jsr convertToAscii
    jsr drawChar
    lda units
    jsr convertToAscii
    jsr drawChar
    rts

convertToTensAndUnits:
    sec
    sbc #10
    bcc doneConvertToTensAndUnits
    inx
    bne convertToTensAndUnits
doneConvertToTensAndUnits:
    stx tens
    clc
    adc #10
    sta units
    rts

convertToAscii:
    clc
    adc #$30
    rts

drawChar:
    
    sta charId

    lda #8
    sta charRow

    lda #18
    clc
    adc clockOffset
    sta charCol

    jsr OUTPUT.drawCharNoColor

    inc clockOffset
    rts

divideBy60:
    ldx #0         
loopDivideBy60:
    cmp #60        
    bcc doneDivideBy60
    sec
    sbc #60        
    inx            
    bne loopDivideBy60
doneDivideBy60:
    stx minutes    
    sta remainder  
    rts

}