//
//  EasyAIPlayerTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class EasyAIPlayerTests: XCTestCase {
    
    let game = Game()
    let brain = Brain()
    let humanPlayer = Constants.playerOneSquareType
    let easyAIPlayer = EasyAIPlayer(squareType: Constants.playerTwoSquareType)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakingFirstMove() {
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail()
            return
        }
        let finalGameState = game.play(aiMove, squareType: easyAIPlayer.squareType)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMakingMoveWhenGameBoardHasOneEmptySpace() {
        game.gameBoard = GameBoardTests.almostFillBoard(playerOne: humanPlayer, playerTwo: easyAIPlayer.squareType)
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail()
            return
        }
        XCTAssert(aiMove == .bottomRight)
    }
    
    func testMakingMoveOnFullGameBoard() {
        game.gameBoard = GameBoardTests.almostFillBoard(playerOne: humanPlayer, playerTwo: easyAIPlayer.squareType)
        game.gameBoard.bottomRight = humanPlayer
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        XCTAssertNil(move)
    }
    
}
