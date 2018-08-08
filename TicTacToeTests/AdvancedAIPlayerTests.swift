//
//  AdvancedAIPlayer.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 8/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class AdvancedAIPlayerTests: XCTestCase {
    
    var gameBoard = GameBoard()
    let humanPlayerSquareType = Constants.playerOneSquareType
    let advancedAIPlayer = AdvancedAIPlayer(squareType: Constants.playerTwoSquareType)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNoWinningMoveAvailable() {
        gameBoard.topRight = .cross
        gameBoard.right = .cross
        let move = advancedAIPlayer.checkForWin(gameBoard)
        XCTAssert(move.count == 0)
    }
    
    func testChooseWinningMoveStraight() {
        gameBoard.topRight = .nought
        gameBoard.right = .nought
        let move = advancedAIPlayer.checkForWin(gameBoard)
        if move.count != 1 {
            XCTFail("Didn't return correct number of winning moves")
            return
        }
        XCTAssert(move[0] == .bottomRight)
    }
    
    func testChooseWinningMoveDiagonal() {
        gameBoard.bottomLeft = .nought
        gameBoard.centre = .nought
        let move = advancedAIPlayer.checkForWin(gameBoard)
        if move.count != 1 {
            XCTFail("Didn't return correct number of winning moves")
            return
        }
        XCTAssert(move[0] == .topRight)
    }
    
    func testChooseTwoWinningMoves() {
        gameBoard.topLeft = .nought
        gameBoard.top = .nought
        gameBoard.bottomLeft = .nought
        gameBoard.bottom = .nought
        gameBoard.left = .cross
        gameBoard.centre = .cross
        let move = advancedAIPlayer.checkForWin(gameBoard)
        if move.count != 2 {
            XCTFail("Didn't return correct number of winning moves")
            return
        }
        XCTAssert(move[0] == .topRight || move[1] == .topRight)
        XCTAssert(move[0] == .bottomRight || move[1] == .bottomRight)
    }
    
    func testNoBlockingMoveAvailable() {
        gameBoard.topRight = .nought
        gameBoard.right = .nought
        let move = advancedAIPlayer.checkForBlock(gameBoard)
        print("hello")
        print(move)
        XCTAssert(move.count == 0)
    }
    
    func testChooseBlockingMoveStraight() {
        gameBoard.topRight = .cross
        gameBoard.top = .cross
        let move = advancedAIPlayer.checkForBlock(gameBoard)
        if move.count != 1 {
            XCTFail("Didn't return correct number of blocking moves")
            return
        }
        XCTAssert(move[0] == .topLeft)
    }
    
    func testChooseBlockingMoveDiagonal() {
        gameBoard.bottomRight = .cross
        gameBoard.centre = .cross
        let move = advancedAIPlayer.checkForBlock(gameBoard)
        if move.count != 1 {
            XCTFail("Didn't return correct number of blocking moves")
            return
        }
        XCTAssert(move[0] == .topLeft)
    }
    
    func testChooseTwoBlockingMoves() {
        gameBoard.topLeft = .cross
        gameBoard.top = .cross
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .cross
        gameBoard.left = .nought
        gameBoard.centre = .nought
        let move = advancedAIPlayer.checkForBlock(gameBoard)
        if move.count != 2 {
            XCTFail("Didn't return correct number of blocking moves")
            return
        }
        XCTAssert(move[0] == .topRight || move[1] == .topRight)
        XCTAssert(move[0] == .bottomRight || move[1] == .bottomRight)
    }
    
    func testNoMovePlayedOnceGameIsAlreadyWon() {
        gameBoard.topLeft = .nought
        gameBoard.left = .nought
        gameBoard.bottomLeft = .nought
        let move = advancedAIPlayer.checkForWin(gameBoard)
        XCTAssert(move.count == 0)
    }
    
    func testNoMovePlayedIfGameBoardIsFull() {
        gameBoard.topLeft = .cross
        gameBoard.top = .cross
        gameBoard.bottomLeft = .cross
        gameBoard.bottom = .cross
        gameBoard.left = .nought
        gameBoard.centre = .nought
        gameBoard.right = .cross
        gameBoard.topRight = .nought
        gameBoard.bottomRight = .nought
        let move = advancedAIPlayer.checkForWin(gameBoard)
        XCTAssert(move.count == 0)
    }
}
