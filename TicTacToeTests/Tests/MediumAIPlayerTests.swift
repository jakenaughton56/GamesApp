//
//  MediumAIPlayerTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 8/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class MediumAIPlayerTests: XCTestCase {
    
    var gameBoard = GameBoard()
    let game = Game()
    let humanPlayer = Constants.playerOneSquareType
    let mediumAIPlayer = MediumAIPlayer(squareType: Constants.playerTwoSquareType)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakingFirstMove() {
        let move = mediumAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail("AI Player failed to make a move on an empty game board")
            return
        }
        let finalGameState = game.play(aiMove, squareType: mediumAIPlayer.squareType)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMakingMoveWhenGameBoardHasOneEmptySpace() {
        gameBoard = GameBoardTests.almostFillBoard(playerOne: mediumAIPlayer.squareType, playerTwo: humanPlayer)
        let move = mediumAIPlayer.chooseMove(gameBoard)
        guard let aiMove = move else {
            XCTFail("AI Player failed to make a move on the one empty space on the game board")
            return
        }
        XCTAssert(aiMove == .bottomRight)
    }
    
    func testMakingMoveOnFullBoard() {
        gameBoard = GameBoardTests.almostFillBoard(playerOne: humanPlayer, playerTwo: mediumAIPlayer.squareType)
        gameBoard.bottomRight = humanPlayer
        let move = mediumAIPlayer.chooseMove(gameBoard)
        XCTAssertNil(move)
    }
    
    func testWinningMove() {
        gameBoard.topLeft = mediumAIPlayer.squareType
        gameBoard.centre = mediumAIPlayer.squareType
        let move = mediumAIPlayer.chooseMove(gameBoard)
        guard let aiMove = move else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottomRight, "AI Player failed to make winning move")
    }
    
    func testBlockingMove() {
        gameBoard.top = humanPlayer
        gameBoard.centre = humanPlayer
        let move = mediumAIPlayer.chooseMove(gameBoard)
        guard let aiMove = move else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottom, "AI Player failed to make blocking move")
    }
    
    func testMakingWinningMoveOverBlockingMove() {
        gameBoard.topLeft = mediumAIPlayer.squareType
        gameBoard.left = mediumAIPlayer.squareType
        gameBoard.top = humanPlayer
        gameBoard.centre = humanPlayer
        let move = mediumAIPlayer.chooseMove(gameBoard)
        guard let aiMove = move else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottomLeft, "AI Player failed to make winning move when blocking move was available")
    }
    
    func testMakingWinningMoveWithTwoAvailableOptions() {
        gameBoard.bottomRight = mediumAIPlayer.squareType
        gameBoard.bottom = mediumAIPlayer.squareType
        gameBoard.centre = mediumAIPlayer.squareType
        game.gameBoard = gameBoard
        guard let move = mediumAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        let finalGameState = game.play(move, squareType: mediumAIPlayer.squareType)
        XCTAssert(finalGameState == .playerWins, "AI Player Failed to play one of two winning moves")
    }
}
