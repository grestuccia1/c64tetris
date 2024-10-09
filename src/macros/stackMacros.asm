
// ----------------------------------- STACK MACROS -----------------------------------

.macro PushToStack() {
        txa
        pha
        tya
        pha
}

.macro PopFromStack() {
        pla
        tay
        pla
        tax
}