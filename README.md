# C64 Tetris

<br/>
<div align="center">
<a href="https://github.com/ShaanCoding/makeread.me">
<img src="images/tetris-title.png" alt="Logo" width="297" height="87">
</a>
</div>


# Tetris for Commodore 64 (C64) in Kick Assembler

## Introduction

This project is a clone of the classic **Tetris** game, developed for the Commodore 64 (C64) using **Kick Assembler**. The aim was to recreate the core mechanics of Tetris, including piece movement, rotation, line clearing, and scoring, while working within the constraints of the C64's hardware.

## Inspiration: My First Computer and the Beginning of a Passion

My first computer was not just a tool; it was the spark that ignited my passion for programming. Even though at the time I lacked the knowledge and documentation (and much of it was in English), I always dreamed of developing a game in assembler. That dream stayed with me throughout my life, and although I started late, at 50 years old, I decided that it’s never too late to learn and pursue what you love. My first computer gave me my vocation, but it was determination that led me to follow that dream.

**Inspired by and incorporates mechanics from the 1989 [Atari](https://atari.com/) arcade game Tetris.**

## Features

-	Classic Tetris gameplay with falling tetrominoes.
-	Joystick support on Port 2 of the Commodore 64 for an authentic gaming experience.
-	Score calculation based on lines cleared.
-	Level progression with increasing difficulty.
-	Game over detection when blocks reach the top of the screen.
-	Music toggle (on/off) option.
-	In-game stats (pieces placed, lines cleared, etc.).
-	Title screen and menu for game options.
-	Multiple levels with automatic progression.
-	Wide mode with a wider playfield (14 columns wide instead of the standard 10).
-	Start level selection from the menu before starting the game.

## How the Game Was Made

“The development of the game was heavily based on a [Board-b Tutorials](https://www.youtube.com/@board-b-tutorials) course, which provides a detailed explanation of how to create a game in Kick Assembler. Additionally, source code from the course was used, without which this project would not have been possible.”


### 1. Grid and Tetromino Representation

The playfield grid was implemented as a two-dimensional array, with each cell representing an occupied or unoccupied space. The tetrominoes (game pieces) were defined using bit patterns, where each tetromino is a 4x4 matrix of bits.

- **Tetrominoes:** Each tetromino shape (I, O, T, L, J, Z, S) is stored as a series of bytes in memory, representing its rotation states.
- **Rotation:** (Clockwise): Rotation of tetrominoes was handled by shifting the bits within the matrix and rotating the pieces clockwise. The game ensures that the tetromino can rotate freely within the boundaries of the grid, checking for valid positions during each rotation.

### 2. Controls

The controls were implemented using the **keyboard** input, with specific keys assigned for moving left, right, rotating, and dropping the piece:

- `Left Arrow`: Move left
- `Right Arrow`: Move right
- `Space`: Rotate (Clockwise)
- `Down Arrow`: Drop faster

### 3. Collision Detection

Collision detection was a key part of the game's logic to ensure that tetrominoes don't overlap or go out of bounds. The game checks for collisions between tetrominoes and the edges of the grid or existing placed blocks.

### 4. Line Clearing and Scoring

The game detects when a horizontal line is fully filled with blocks. When this happens, the line is cleared, and all blocks above it shift down. The scoring system was implemented to give points for each cleared line, with bonuses for clearing multiple lines simultaneously.

### 5. Graphics and Sound

- **Graphics:** The game's graphics were designed using the C64's character-based graphics mode. Each tetromino is represented by a character block, and the playfield uses custom character sets for a clean look.
- **Music:** Instead of creating original compositions, I incorporated music from the [SIDPLAY](http://www.sidmusic.org/) repository, utilizing the SID chip. This provided an engaging soundtrack that dynamically responded to game actions like clearing lines and rotating pieces, enhancing the overall gaming experience.


## How to Run

To run this game on a C64 emulator or real hardware:

1. Assemble the source code using **Kick Assembler**.
   ```bash
   kickass main.asm
   ```
2. Load the resulting `.prg` file into a C64 emulator like **VICE** or onto a real Commodore 64.

## Development Tools

- **Kick Assembler**: The primary assembler used for coding this project.
- **VICE**: A C64 emulator used for testing the game.
- **CharPad**: Used for designing the custom character set.
- **SpritePad**: Used for designing the custom sprite set.
- **Visual Studio Code**: The main code editor for the project, offering a robust environment for writing and managing assembly code efficiently.
- **Trello**: Utilized for project management to organize tasks, track progress, and coordinate development milestones effectively.
- **Google Sheets**: Employed for designing game levels and piece configurations, enabling easy visualization and modification of game elements. [Tetris C64 Sheet](https://docs.google.com/spreadsheets/d/1_ig19sMXD00o047gIRUfUvoIk_laGAnXPoKrUIsnIFE/edit?usp=sharing)


## References

Here are some references I used to complete this project:

1. **Kick Assembler Documentation** - For learning about assembly instructions and features specific to Kick Assembler.
   - [Kick Assembler Manual](http://theweb.dk/KickAssembler/WebHelp/)
   
2. **C64 Memory Map and Architecture** - For understanding the C64's memory layout and hardware capabilities.
   - [C64 Programmer's Reference Guide](http://www.zimmers.net/cbmpics/cbm/c64/vic-ii.txt)
   
3. **SID Chip Programming** - For generating sound effects.
   - [SID Chip Programming Guide](https://www.c64-wiki.com/wiki/SID)

4. **Tetris Mechanics** - General understanding of how the original Tetris game mechanics work.
   - [Tetris Wiki](https://tetris.wiki/Tetris_Guideline)

5. **board-b Tutorials** - For learning about assembly instructions and features specific to Kick Assembler.
    - [board-b YouTube Channel](https://www.youtube.com/@board-b-tutorials)

## License

This project is released under the MIT License. You are free to use, modify, and distribute this code as long as proper credit is given.

## Tetris

- [Wiki](https://es.wikipedia.org/wiki/Tetris)
- [Official Site](https://www.tetris.com/)
- [History](https://vadim.oversigma.com/Tetris.htm)


## Important
**All rights to Tetris belong to their respective owners. This project is inspired by Tetris and is for educational purposes only, with no commercial intent.**

**Music**: New Song - Author [Leigh White (Racer X)](https://csdb.dk/release/?id=17674) ❤️❤️❤️