// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

@24575
D=A
@SCREENEND
M=D
@currenColor // used to skip painting if screen is already painted the intended color
M=0

(MAINLOOP)
    @KBD
    D=M
    // paint white if no key pressed (kbd != 0)
    @PAINTWHITE
    D;JEQ
    // paint black otherwise
    @PAINTBLACK
    0;JMP

    (PAINTBLACK)
        @1
        D=-A
        @color
        M=D
        @FILLSCREEN
        0;JMP
    (PAINTWHITE)
        @color
        M=0
        @FILLSCREEN
        0;JMP

(FILLSCREEN)
    // init pixel to first address of screen
    @SCREEN
    D=A
    @pixel
    M=D

    // if screen is already painted to color, skip paint
    @color
    D=M
    @currentColor
    D=D-M
    @END
    D;JEQ

    // update current color to the selected color
    @color
    D=M
    @currentColor
    M=D

    // loop through each pixel and set color
    (PIXELLOOP)
        // exit loop if pixel is passed end of screen
        @pixel
        D=M
        @SCREENEND
        D=D-M
        @END
        D;JGT

        // color pixel
        @color
        D=M
        @pixel
        A=M
        M=D

        // next pixel
        @pixel
        M=M+1
        @PIXELLOOP
        0;JMP

(END)
    // back to main loop (infinite loop)
    @MAINLOOP
    0;JMP
