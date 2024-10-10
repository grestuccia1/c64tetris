// ----------------------------------- MATH LIBRARY -----------------------------------

MATH:
{
    generateRandomBelow7:
        lda $DC04                 
        and #$07                  
        cmp #7                    
        beq generateRandomBelow7       
        sta ZP_RANDOM_NUMBER  
        rts

    generateRandomBelow10:
        lda $DC04                 
        and #$07
        clc   
        adc #1
        cmp #9 
        beq generateRandomBelow10
        sta ZP_RANDOM_NUMBER_SCORE  
        rts

    divideBy10:
        //; Return with the quotient in A and the remainder in X.
        ldx #0         
    divideLoopBy10:
        cmp #10        
        bcc doneDivideBy10
        sbc #10        
        inx            
        jmp divideLoopBy10 
    doneDivideBy10:
    rts            
}