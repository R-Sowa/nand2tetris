// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// 無限ループを実行し、その中で、キーボードが押された際には全てのピクセルに黒を書き込み、そうでないときは白を書き込む
// web IDEでは、CPU emulatorの実行速度をfastestにしないと8192ピクセルの塗り替えが遅くて実感できないので注意 

(LOOP)
    @KBD
    D=M 
    // KBD!=0なら黒で塗る
    @BLACK 
    D;JNE 
    // KBD==0なら白で塗る (排他的なので無条件ジャンプ)
    @WHITE 
    0;JMP

(BLACK)
    @SCREEN
    D=A 
    // addr = SCREEN
    @addr
    M=D 

(BLACK_LOOP)
    @addr
    D=M
    @KBD
    D=D-A
    // addr == KBDならKBD-1まで塗り尽くしたので監視ループまで戻る
    @LOOP 
    D;JEQ

    @addr
    A=M
    // RAM[addr] = -1 (1111111111111111 黒で塗る)
    M=-1 

    // addr = addr+1
    @addr 
    M=M+1 

    @BLACK_LOOP
    0;JMP

(WHITE)
    @SCREEN
    D=A
    // addr = SCREEN
    @addr
    M=D

(WHITE_LOOP)
    @addr
    D=M
    @KBD
    D=D-A
    // addr = KBDならKBD-1まで塗り尽くしたので戻る 
    @LOOP
    D;JEQ

    @addr
    A=M
    // RAM[addr] = 0
    M=0

    // addr = addr + 1
    @addr
    M=M+1

    @WHITE_LOOP
    0;JMP