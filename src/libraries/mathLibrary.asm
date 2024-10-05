// ----------------------------------- MATH LIBRARY -----------------------------------

MATH:
{
    generate_random:
        lda $DC04                 
        and #$07                  
        cmp #7                    
        beq generate_random       
        sta ZP_RANDOM_NUMBER  
        rts
}