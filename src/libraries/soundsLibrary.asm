// ----------------------------------- SOUNDS LIBRARY -----------------------------------

SOUNDS: {

    FadeInVolume:

        lda currentVolume          
        cmp #IS_VOLUME_ON
        beq maxVolumeReached
        sta $D418         

        ldx #RASTER_TICK_2
        jsr CLOCK.tickStatus
        bne maxVolumeReached

        inc currentVolume  
          
        maxVolumeReached:
        rts     
        
    FadeOutVolume:

        lda currentVolume          
        cmp #IS_VOLUME_OFF        
        beq minVolumeReached
        sta $D418         

        ldx #RASTER_TICK_2
        jsr CLOCK.tickStatus
        bne minVolumeReached

        dec currentVolume  
          
        minVolumeReached:
        rts            
}