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
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossLeftToRightWin() {
        gameBoard.left = .cross
        gameBoard.centre = .cross
        gameBoard.right = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossBottomLeftToBottomRightWin() {
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .cross
        gameBoard.bottomRight = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossTopLeftToBottomLeftWin() {
        gameBoard.topLeft = .cross
        gameBoard.left = .cross
        gameBoard.bottomLeft = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossTopToBottomWin() {
        gameBoard.top = .cross
        gameBoard.centre = .cross
        gameBoard.bottom = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossTopRightToBottomRightWin() {
        gameBoard.topRight = .cross
        gameBoard.right = .cross
        gameBoard.bottomRight = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossTopLeftToBottomRightWin() {
        gameBoard.topLeft = .cross
        gameBoard.centre = .cross
        gameBoard.bottomRight = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCrossTopRightToBottomLeftWin() {
        gameBoard.topRight = .cross
        gameBoard.centre = .cross
        gameBoard.bottomLeft = .cross
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopLeftToTopRightWin() {
        gameBoard.topLeft = .nought
        gameBoard.top = .nought
        gameBoard.topRight = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtLeftToRightWin() {
        gameBoard.left = .nought
        gameBoard.centre = .nought
        gameBoard.right = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtBottomLeftToBottomRightWin() {
        gameBoard.bottomLeft = .nought
        gameBoard.bottom = .nought
        gameBoard.bottomRight = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopLeftToBottomLeftWin() {
        gameBoard.topLeft = .nought
        gameBoard.left = .nought
        gameBoard.bottomLeft = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopToBottomWin() {
        gameBoard.top = .nought
        gameBoard.centre = .nought
        gameBoard.bottom = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopRightToBottomRightWin() {
        gameBoard.topRight = .nought
        gameBoard.right = .nought
        gameBoard.bottomRight = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopLeftToBottomRightWin() {
        gameBoard.topLeft = .nought
        gameBoard.centre = .nought
        gameBoard.bottomRight = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testNoughtTopRightToBottomLeftWin() {
        gameBoard.topRight = .nought
        gameBoard.centre = .nought
        gameBoard.bottomLeft = .nought
        XCTAssertTrue(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testEmptyNoWin() {
        XCTAssertFalse(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testMixedRowNoWin() {
        gameBoard.topRight = .nought
        gameBoard.right = .cross
        gameBoard.bottomRight = .nought
        XCTAssertFalse(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testTwoInRowNoWin() {
        gameBoard.topLeft = .cross
        gameBoard.left = .cross
        XCTAssertFalse(brain.hasPlayerWon(gameBoard: gameBoard))
    }
    
    func testCheckMoveOnEmptyBoardIsValid() {
        XCTAssertTrue(brain.isMoveValid(gameBoard: gameBoard, move: Square.topLeft))
    }
    
    func testCheckMoveOnEmptySquareIsValid() {
        gameBoard.bottom = .nought
        gameBoard.right = .cross
        gameBoard.bottomLeft = .nought
        XCTAssertTrue(brain.isMoveValid(gameBoard: gameBoard, move: Square.top))
    }
    
    func testCheckForInvalidMove() {
        gameBoard.centre = .cross
        XCTAssertFalse(brain.isMoveValid(gameBoard: gameBoard, move: Square.centre))
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
        XCTAssertTrue(brain.isBoardFull(gameBoard: gameBoard))
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
        XCTAssertFalse(brain.isBoardFull(gameBoard: gameBoard))
    }
    
    func testBoardIsNotFullAtStartOfGame() {
        XCTAssertFalse(brain.isBoardFull(gameBoard: gameBoard))
    }
    
    func testSquaresAreEmpty() {
        XCTAssertTrue(brain.checkEmpty(gameBoard: gameBoard))
    }
    
    func testSquaresAreNotEmpty() {
        gameBoard.topLeft = .cross
        XCTAssertFalse(brain.checkEmpty(gameBoard: gameBoard))
    }
    
}
