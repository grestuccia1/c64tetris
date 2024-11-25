
// ----------------------------------- MUSIC LIBRARY -----------------------------------

MUSIC:
{
    /*
    init:
        lda #MENU_MUSIC
        sta currentSong
        jsr MUSIC.change
        rts
    */

    play:
        lda currentSong
        cmp #1
        bne playMusicTwo

        jsr PLAY_MUSIC_ONE
        jmp playMusicEnd

            playMusicTwo:
            cmp #2
            bne playMusicThree

            jsr PLAY_MUSIC_TWO
            jmp playMusicEnd

            playMusicThree:
            cmp #3
            bne playMusicFour

            jsr PLAY_MUSIC_THREE
            jmp playMusicEnd

            playMusicFour:
            cmp #4
            bne playMusicMenu

            jsr PLAY_MUSIC_FOUR
            jmp playMusicEnd

            playMusicMenu:
            jsr PLAY_MUSIC_MENU

        playMusicEnd:
        rts

    change:
        lda currentSong
        cmp #1
        bne initMusicTwo

        jsr INIT_MUSIC_ONE
        jmp initMusicEnd

            initMusicTwo:
            cmp #2
            bne initMusicThree

            jsr INIT_MUSIC_TWO
            jmp initMusicEnd

            initMusicThree:
            cmp #3
            bne initMusicFour

            jsr INIT_MUSIC_THREE
            jmp initMusicEnd

            initMusicFour:
            cmp #4
            bne initMusicMenu

            jsr INIT_MUSIC_FOUR
            jmp initMusicEnd

            initMusicMenu:
            jsr INIT_MUSIC_MENU

        initMusicEnd:
        rts
}