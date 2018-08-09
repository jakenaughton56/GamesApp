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
    let playerOne = Constants.playerOneSquareType
    let playerTwo = Constants.playerTwoSquareType
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUpdatingBoardStateOnce() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        XCTAssert(humanGame.gameBoard.topLeft != .empty)
    }
    
    func testUpdatingBoardStateTwice() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        let _ = humanGame.play(.bottomRight, squareType: playerTwo)
        XCTAssert(humanGame.gameBoard.topLeft != .empty)
        XCTAssert(humanGame.gameBoard.bottomRight != .empty)
    }
    
    func testEmptySquareUpdatingBoardStateOnce() {
        let _ = humanGame.play(.topRight, squareType: playerOne)
        XCTAssert(humanGame.gameBoard.topLeft == .empty)
    }
    
    func testGameBoardFull() {
        moveSevenTimes()
        let _ = humanGame.play(.bottom, squareType: playerTwo)
        let finalGameState = humanGame.play(.bottomRight, squareType: playerOne)
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testGameBoardIsAlmostFull() {
        moveSevenTimes()
        let finalGameState = humanGame.play(.bottom, squareType: playerTwo)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMovingOnTakenSquare() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        let finalGameState = humanGame.play(.topLeft, squareType: playerTwo)
        XCTAssert(finalGameState == .squareTaken)
    }
    
    func testMovingAfterWin() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        let _ = humanGame.play(.top, squareType: playerOne)
        let _ = humanGame.play(.topRight, squareType: playerOne)
        let finalGameState = humanGame.play(.bottomRight, squareType: playerOne)
        XCTAssert(finalGameState == .playerAlreadyWon)
        XCTAssert(humanGame.gameBoard.bottomRight == .empty)
    }
    
    func testWinningMove() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        let _ = humanGame.play(.top, squareType: playerOne)
        let finalGameState = humanGame.play(.topRight, squareType: playerOne)
        XCTAssert(finalGameState == .playerWins)
    }
    
    func testStartingNewGame() {
        let _ = humanGame.play(.topLeft, squareType: playerOne)
        let _ = humanGame.play(.bottomLeft, squareType: playerOne)
        let _ = humanGame.play(.top, squareType: playerOne)
        XCTAssertFalse(brain.isEmpty(humanGame.gameBoard))
        humanGame.startNewGame()
        XCTAssertTrue(brain.isEmpty(humanGame.gameBoard))
    }
    
    private func moveSevenTimes() {
        let _ = humanGame.play(.centre, squareType: playerOne)
        let _ = humanGame.play(.topLeft, squareType: playerTwo)
        let _ = humanGame.play(.top, squareType: playerOne)
        let _ = humanGame.play(.left, squareType: playerTwo)
        let _ = humanGame.play(.bottomLeft, squareType: playerOne)
        let _ = humanGame.play(.topRight, squareType: playerTwo)
        let _ = humanGame.play(.right, squareType: playerOne)
    }
    
}
