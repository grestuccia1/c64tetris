// ----------------------------------- MATH LIBRARY -----------------------------------

MATH:
{
    generateRandomBelow7:

        .if (DEBUG) {
            lda #0
            sta ZP_RANDOM_NUMBER
            rts
        }

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

    generateRandomBelow18:

        .if (DEBUG) {
            lda #0
            sta ZP_RANDOM_NUMBER
            rts
        }

        lda $DC04           
        and #$1F           
        cmp #18            
        bcc randomInRange18 
        jmp generateRandomBelow18 
        randomInRange18:
            sta ZP_RANDOM_NUMBER
            rts  

    multiplyBy2:
        asl   
        rts 

    multiplyBy4:
        asl   
        asl   
        rts   

    multiplyBy8:
        asl   
        asl  
        asl   
        rts  

    multiplyBy5:
        sta temp
        asl        
        asl        
        clc        
        adc temp   
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