
// ----------------------------------- COLLITION LIBRARY -----------------------------------

COLLITION:
{

    init:
        lda tetriminoRow
        sta collitionRow

        lda tetriminoCol
        sta collitionCol

        lda tetriminoRot
        sta collitionRot

        rts

    pass:    
        lda collitionRow
        sta tetriminoRow

        lda collitionCol
        sta tetriminoCol

        lda collitionRot
        sta tetriminoRot

        rts

	check:
		txa
		pha
		tya
		pha

		lda #SPACE
		sta charCollision

		lda collitionRot 
		asl
		asl
		sta collitionInit

		lda collitionRot 
		clc
		adc #1
		asl
		asl
		sta collitionEnd

		ldy collitionInit
		
		checkPiece:
			
				lda (ZP_PX_LO), y
				clc
				adc collitionCol
				sta tileCol

				lda (ZP_PY_LO), y
				clc
				adc collitionRow
				sta tileRow

				jsr TILE.getChar

				lda charCollision
				cmp	#SPACE
				bne checkDone

				iny
				cpy collitionEnd
				bne checkPiece
		checkDone:
				pla
				tay
				pla
				tax
				rts

}