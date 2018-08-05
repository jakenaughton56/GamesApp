//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 27/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    let brain = Brain()
    let humanGame = Game(player1: .human, player2: .human)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsPlayerOnesTurnBooleanChanges() {
        XCTAssertTrue(humanGame.isItPlayerOnesTurn)
        let _ = humanGame.play(move: .topLeft)
        XCTAssertFalse(humanGame.isItPlayerOnesTurn)
    }
    
    func testUpdatingBoardStateOnce() {
        let _ = humanGame.play(move: .topLeft)
        XCTAssert(humanGame.gameBoard.topLeft != .empty)
    }
    
    func testUpdatingBoardStateTwice() {
        let _ = humanGame.play(move: .topLeft)
        let _ = humanGame.play(move: .bottomRight)
        XCTAssert((humanGame.gameBoard.topLeft != .empty) && (humanGame.gameBoard.bottomRight != .empty))
    }
    
    func testEmptySquareUpdatingBoardStateOnce() {
        let _ = humanGame.play(move: .topRight)
        XCTAssert(humanGame.gameBoard.topLeft == .empty)
    }
    
    func testGameBoardFull() {
        moveSevenTimes()
        let _ = humanGame.play(move: .bottom)
        let gameState = humanGame.play(move: .bottomRight)
        XCTAssert(gameState == .gameBoardFull)
    }
    
    func testGameBoardIsAlmostFull() {
        moveSevenTimes()
        let gameState = humanGame.play(move: .bottom)
        XCTAssert(gameState == .nextMove)
    }
    
    func testMovingOnTakenSquare() {
        let _ = humanGame.play(move: .topLeft)
        let gameState = humanGame.play(move: .topLeft)
        XCTAssert(gameState == .squareTaken)
    }
    
    func testWinningMove() {
        let _ = humanGame.play(move: .topLeft)
        let _ = humanGame.play(move: .bottomLeft)
        let _ = humanGame.play(move: .top)
        let _ = humanGame.play(move: .bottom)
        let gameState = humanGame.play(move: .topRight)
        XCTAssert(gameState == .playerWon)
    }
    
    func testStartingNewGame() {
        let _ = humanGame.play(move: .topLeft)
        let _ = humanGame.play(move: .bottomLeft)
        let _ = humanGame.play(move: .top)
        XCTAssertFalse(humanGame.isItPlayerOnesTurn)
        XCTAssertFalse(brain.checkEmpty(gameBoard: humanGame.gameBoard))
        humanGame.startNewGame()
        XCTAssertTrue(humanGame.isItPlayerOnesTurn)
        XCTAssertTrue(brain.checkEmpty(gameBoard: humanGame.gameBoard))
    }
    
    func moveSevenTimes() {
        let _ = humanGame.play(move: .centre)
        let _ = humanGame.play(move: .topLeft)
        let _ = humanGame.play(move: .top)
        let _ = humanGame.play(move: .left)
        let _ = humanGame.play(move: .bottomLeft)
        let _ = humanGame.play(move: .topRight)
        let _ = humanGame.play(move: .right)
    }
    

    
}
