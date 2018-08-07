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
    let humanGame = Game()
    
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
        let _ = humanGame.play(.topLeft)
        XCTAssertFalse(humanGame.isItPlayerOnesTurn)
    }
    
    func testUpdatingBoardStateOnce() {
        let _ = humanGame.play(.topLeft)
        XCTAssert(humanGame.gameBoard.topLeft != .empty)
    }
    
    func testUpdatingBoardStateTwice() {
        let _ = humanGame.play(.topLeft)
        let _ = humanGame.play(.bottomRight)
        XCTAssert(humanGame.gameBoard.topLeft != .empty)
        XCTAssert(humanGame.gameBoard.bottomRight != .empty)
    }
    
    func testEmptySquareUpdatingBoardStateOnce() {
        let _ = humanGame.play(.topRight)
        XCTAssert(humanGame.gameBoard.topLeft == .empty)
    }
    
    func testGameBoardFull() {
        moveSevenTimes()
        let _ = humanGame.play(.bottom)
        let finalGameState = humanGame.play(.bottomRight)
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testGameBoardIsAlmostFull() {
        moveSevenTimes()
        let finalGameState = humanGame.play(.bottom)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMovingOnTakenSquare() {
        let _ = humanGame.play(.topLeft)
        let finalGameState = humanGame.play(.topLeft)
        XCTAssert(finalGameState == .squareTaken)
    }
    
    func testMovingAfterWin() {
        let _ = humanGame.play(.topLeft)
        let _ = humanGame.play(.bottomLeft)
        let _ = humanGame.play(.top)
        let _ = humanGame.play(.bottom)
        let _ = humanGame.play(.topRight)
        let finalGameState = humanGame.play(.bottomRight)
        XCTAssert(finalGameState == .playerAlreadyWon)
        XCTAssert(humanGame.gameBoard.bottomRight == .empty)
    }
    
    func testWinningMove() {
        let _ = humanGame.play(.topLeft)
        let _ = humanGame.play(.bottomLeft)
        let _ = humanGame.play(.top)
        let _ = humanGame.play(.bottom)
        let finalGameState = humanGame.play(.topRight)
        XCTAssert(finalGameState == .playerWins)
    }
    
    func testStartingNewGame() {
        let _ = humanGame.play(.topLeft)
        let _ = humanGame.play(.bottomLeft)
        let _ = humanGame.play(.top)
        XCTAssertFalse(humanGame.isItPlayerOnesTurn)
        XCTAssertFalse(brain.isEmpty(humanGame.gameBoard))
        humanGame.startNewGame()
        XCTAssertTrue(humanGame.isItPlayerOnesTurn)
        XCTAssertTrue(brain.isEmpty(humanGame.gameBoard))
    }
    
    private func moveSevenTimes() {
        let _ = humanGame.play(.centre)
        let _ = humanGame.play(.topLeft)
        let _ = humanGame.play(.top)
        let _ = humanGame.play(.left)
        let _ = humanGame.play(.bottomLeft)
        let _ = humanGame.play(.topRight)
        let _ = humanGame.play(.right)
    }
    
}
