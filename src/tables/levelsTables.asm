// ----------------------------------- LEVELS TABLES -----------------------------------

linesGoalPerLevel:
    .byte 0
    .byte 1     // Level: 1
    .byte 2    
    .byte 5    
    .byte 10    
    .byte 12    // Level: 5
    .byte 10    
    .byte 13    
    .byte 16    
    .byte 12    
    .byte 15    // Level: 10
    .byte 18    
    .byte 12
    .byte 15
    .byte 18    
    .byte 20    // Level: 15
    .byte 20    
    .byte 20    
    .byte 22    
    .byte 24    
    .byte 28    // Level: 20


tetrominoFallDelayPerLevel:
    .byte 50    
    .byte 50    // Level: 1
    .byte 50
    .byte 50    
    .byte 45    
    .byte 40    // Level: 5    
    .byte 35    
    .byte 35    
    .byte 35    
    .byte 35    
    .byte 35    // Level: 10  
    .byte 20    
    .byte 20
    .byte 15
    .byte 15
    .byte 10    // Level: 10  
    .byte 10    
    .byte 30    
    .byte 25    
    .byte 20
    .byte 10    // Level: 20       

tetrominoCountPerLevelToSpeedUp:
    .byte 30    
    .byte 20    // Level: 1
    .byte 20    
    .byte 20    
    .byte 20    
    .byte 20    // Level: 5 
    .byte 20
    .byte 20
    .byte 10    
    .byte 10    
    .byte 10    // Level: 10    
    .byte 10    
    .byte 10
    .byte 5
    .byte 5
    .byte 5     // Level: 15   
    .byte 4  
    .byte 3  
    .byte 2 
    .byte 2  
    .byte 2     // Level: 20   


tetrominoCountPerLevelToMoveLinesUp:
    .byte 0    
    .byte 0    // Level: 1
    .byte 0    
    .byte 0    
    .byte 0    
    .byte 0    // Level: 5 
    .byte 0
    .byte 0
    .byte 0    
    .byte 0    
    .byte 0    // Level: 10    
    .byte 0    
    .byte 0
    .byte 0
    .byte 0
    .byte 7     // Level: 15   
    .byte 5  
    .byte 5  
    .byte 3 
    .byte 7  
    .byte 3     // Level: 20   

tetrominoCountPerLevelToNewRandomTopBlock:
    .byte 200    
    .byte 0    // Level: 1
    .byte 0    
    .byte 0    
    .byte 0    
    .byte 0    // Level: 5 
    .byte 0
    .byte 0
    .byte 0    
    .byte 0    
    .byte 0    // Level: 10    
    .byte 0    
    .byte 7
    .byte 5
    .byte 3
    .byte 0     // Level: 15   
    .byte 0  
    .byte 0  
    .byte 0 
    .byte 8  
    .byte 5     // Level: 20   

rowTransitionColor:
    .byte 11, 12, 15, 1, 15, 12, 11, 12, 15, 1, 15, 12, 11, 12, 15, 1, 15, 12, 11, 12, 15, 1, 15, 12, 11, 12, 15, 1, 15, 12

//Dual Rainbow Columns
level4Length:
    .byte 16
level4X:
    .byte 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10
level4Y:
    .byte 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23
level4Color:
    .byte 2, 5, 6, 7, 4, 3, 8, 2, 5, 6, 7, 4, 3, 8, 2, 5

//Random Pillars
level5Length:
    .byte 10
level5X:
    .byte 1, 5, 3, 7, 8, 6, 4, 9, 2, 7
level5Y:
    .byte 19, 19, 20, 20, 20, 21, 22, 22, 23, 23
level5Color:
    .byte 2, 5, 6, 7, 4, 3, 8, 2, 5, 6

//Rainbow Pyramid
level6Length:
    .byte 24
level6X:
    .byte 5, 6, 4, 5, 6, 7, 3, 4, 7, 8, 2, 3, 5, 6, 8, 9, 1, 2, 4, 5, 6, 7, 9, 10
level6Y: 
    .byte 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23
level6Color:
    .byte 2, 5, 6, 7, 4, 3, 8, 2, 5, 6, 7, 4, 3, 8, 2, 5, 6, 7, 4, 3, 8, 2, 5, 6

//REX 
level7Length:
    .byte 42
level7X: 
    .byte 2,3,5,6,8,10,1,3,5,8,10,1,3,5,8,10,1,3,5,8,10,2,3,5,6,9,1,3,5,8,10,1,3,5,8,10,1,3,5,6,8,10
level7Y: 
    .byte 16,16,16,16,16,16,17,17,17,17,17,18,18,18,18,18,19,19,19,19,19,20,20,20,20,20,21,21,21,21,21,22,22,22,22,22,23,23,23,23,23,23
level7Color:
    .byte 11,11,11,11,11,11,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11

//HEART
level8Length:
    .byte 37
level8X: 
    .byte 2,3,7,8,1,2,3,4,6,7,8,9,1,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,3,4,5,6,7,4,5,6,5
level8Y: 
    .byte 17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,19,20,20,20,20,20,20,20,21,21,21,21,21,22,22,22,23
level8Color:
    .byte 2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2

//C64 Logo
level9Length:
    .byte 34
level9X: 
    .byte 3,4,5,6,2,3,4,5,6,8,9,10,2,3,8,9,2,3,2,3,8,9,2,3,4,5,6,8,9,10,3,4,5,6
level9Y: 
    .byte 17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,20,20,21,21,21,21,22,22,22,22,22,22,22,22,23,23,23,23
level9Color:
    .byte 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,2,2,6,6,6,6,6,2,2,2,6,6,6,6

//Racer X
level10Length:
    .byte 44
level10X: 
    .byte 4,5,6,7,3,4,5,6,7,8,3,4,5,6,7,8,3,4,5,6,7,8,3,4,5,6,7,8,3,4,5,6,7,8,3,4,5,6,7,8,4,5,6,7
level10Y: 
    .byte 16,16,16,16,17,17,17,17,17,17,18,18,18,18,18,18,19,19,19,19,19,19,20,20,20,20,20,20,21,21,21,21,21,21,22,22,22,22,22,22,23,23,23,23
level10Color:
    .byte 1,11,11,1,11,11,1,1,11,11,11,1,11,11,1,11,6,6,6,6,6,6,6,6,10,10,6,6,10,10,10,10,10,10,11,10,10,10,10,11,11,11,11,11

//ISA
level11Length: 
    .byte 41

level11X: 
    .byte 1,2,3,5,6,9,2,4,7,8,10,2,4,8,10,2,5,6,8,9,10,2,7,8,10,2,7,8,10,2,4,7,8,10,1,2,3,5,6,8,10

level11Y: 
    .byte 16,16,16,16,16,16,17,17,17,17,17,18,18,18,18,19,19,19,19,19,19,20,20,20,20,21,21,21,21,22,22,22,22,22,23,23,23,23,23,23,23

level11Color: 
    .byte 2,2,2,4,4,7,2,4,4,7,7,2,4,7,7,2,4,4,7,7,7,2,4,7,7,2,4,7,7,2,4,4,7,7,2,2,2,4,4,7,7

//Cate
level12Length: 
    .byte 45

level12X: 
    .byte 2,4,6,7,8,9,10,1,3,5,7,9,1,3,4,5,7,9,10,1,3,5,7,9,1,3,5,7,9,1,3,5,7,9,1,3,5,7,9,2,3,5,7,9,10

level12Y: 
    .byte 16,16,16,16,16,16,16,17,17,17,17,17,18,18,18,18,18,18,18,19,19,19,19,19,20,20,20,20,20,21,21,21,21,21,22,22,22,22,22,23,23,23,23,23,23

level12Color: 
    .byte 2,4,7,7,7,3,3,2,4,4,7,3,2,4,4,4,7,3,3,2,4,4,7,3,2,4,4,7,3,2,4,4,7,3,2,4,4,7,3,2,4,4,7,3,3