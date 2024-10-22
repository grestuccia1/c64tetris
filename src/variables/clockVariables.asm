// ----------------------------------- CLOCK VARIABLES -----------------------------------

irq_counter_setup:  .byte $00  
irq_counter:        .byte $00  

minutes:            .byte $00   
seconds:            .byte $00  
remainder:          .byte $00  
tens:               .byte $00  
units:              .byte $00  
clockOffset:        .byte $00
showColon:          .byte 0
clockStart:         .byte 0

dc04: .byte 0
dc05: .byte 0
dc0e: .byte 0