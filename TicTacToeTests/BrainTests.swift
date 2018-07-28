//
//  BrainTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 26/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class BrainTests: XCTestCase {
    
    var gameBoard = GameBoard()
    
    let brain = Brain()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCrossTopLeftToTopRightWin() {
        gameBoard.topLeft = .cross
        gameBoard.top = .cross
        gameBoard.topRight = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossLeftToRightWin() {
        gameBoard.left = .cross
        gameBoard.centre = .cross
        gameBoard.right = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossBottomLeftToBottomRightWin() {
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .cross
        gameBoard.bottomRight = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossTopLeftToBottomLeftWin() {
        gameBoard.topLeft = .cross
        gameBoard.left = .cross
        gameBoard.bottomLeft = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossTopToBottomWin() {
        gameBoard.top = .cross
        gameBoard.centre = .cross
        gameBoard.bottom = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossTopRightToBottomRightWin() {
        gameBoard.topRight = .cross
        gameBoard.right = .cross
        gameBoard.bottomRight = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossTopLeftToBottomRightWin() {
        gameBoard.topLeft = .cross
        gameBoard.centre = .cross
        gameBoard.bottomRight = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testCrossTopRightToBottomLeftWin() {
        gameBoard.topRight = .cross
        gameBoard.centre = .cross
        gameBoard.bottomLeft = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopLeftToTopRightWin() {
        gameBoard.topLeft = .nought
        gameBoard.top = .nought
        gameBoard.topRight = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtLeftToRightWin() {
        gameBoard.left = .nought
        gameBoard.centre = .nought
        gameBoard.right = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtBottomLeftToBottomRightWin() {
        gameBoard.bottomLeft = .nought
        gameBoard.bottom = .nought
        gameBoard.bottomRight = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopLeftToBottomLeftWin() {
        gameBoard.topLeft = .nought
        gameBoard.left = .nought
        gameBoard.bottomLeft = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopToBottomWin() {
        gameBoard.top = .nought
        gameBoard.centre = .nought
        gameBoard.bottom = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopRightToBottomRightWin() {
        gameBoard.topRight = .nought
        gameBoard.right = .nought
        gameBoard.bottomRight = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopLeftToBottomRightWin() {
        gameBoard.topLeft = .nought
        gameBoard.centre = .nought
        gameBoard.bottomRight = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testNoughtTopRightToBottomLeftWin() {
        gameBoard.topRight = .nought
        gameBoard.centre = .nought
        gameBoard.bottomLeft = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, true)
    }
    
    func testEmptyNoWin() {
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, false)
    }
    
    func testMixedRowNoWin() {
        gameBoard.topRight = .nought
        gameBoard.right = .cross
        gameBoard.bottomRight = .nought
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, false)
    }
    
    func testTwoInRowNoWin() {
        gameBoard.topLeft = .cross
        gameBoard.left = .cross
        let hasWon = brain.hasPlayerWon(gameBoard: gameBoard)
        XCTAssertEqual(hasWon, false)
    }
    
    func testCheckMoveOnEmptyBoardIsValid() {
        let validMove = brain.isMoveValid(gameBoard: gameBoard, move: Square.topLeft)
        XCTAssertEqual(validMove, true)
    }
    
    func testCheckMoveOnEmptySquareIsValid() {
        gameBoard.bottom = .nought
        gameBoard.right = .cross
        gameBoard.bottomLeft = .nought
        let validMove = brain.isMoveValid(gameBoard: gameBoard, move: Square.top)
        XCTAssertEqual(validMove, true)
    }
    
    func testCheckForInvalidMove() {
        gameBoard.centre = .cross
        let validMove = brain.isMoveValid(gameBoard: gameBoard, move: Square.centre)
        XCTAssertEqual(validMove, false)
    }
    
    func testEndOfGameIfGameBoardIsFull() {
        gameBoard.topLeft = .cross
        gameBoard.top = .cross
        gameBoard.topRight = .cross
        gameBoard.left = .nought
        gameBoard.centre = .cross
        gameBoard.right = .cross
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .nought
        gameBoard.bottomRight = .cross
        
        let isGameFinished = brain.isBoardFull(gameBoard: gameBoard)
        XCTAssertEqual(isGameFinished, true)
    }
    
    func testEndOfGameIfGameBoardIsAlmostFull() {
        gameBoard.topLeft = .cross
        gameBoard.top = .cross
        gameBoard.topRight = .cross
        gameBoard.left = .nought
        gameBoard.centre = .cross
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .nought
        gameBoard.bottomRight = .cross
        
        let isGameFinished = brain.isBoardFull(gameBoard: gameBoard)
        XCTAssertEqual(isGameFinished, false)
    }
    
    func testEndOfGameIfGameBoardIsEmpty() {
        let isGameFinished = brain.isBoardFull(gameBoard: gameBoard)
        XCTAssertEqual(isGameFinished, false)
    }
    
}
