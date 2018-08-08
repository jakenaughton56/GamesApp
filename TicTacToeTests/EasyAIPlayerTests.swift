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
    let humanPlayerSquareType = Constants.playerOneSquareType
    let easyAIPlayer = EasyAIPlayer(squareType: Constants.playerTwoSquareType)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakeFirstMove() {
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail()
            return
        }
        let finalGameState = game.play(aiMove, squareType: easyAIPlayer.squareType)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMakeMoveWhenGameBoardHasOneEmptySpace() {
        almostFillBoard()
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail()
            return
        }
        let finalGameState = game.play(aiMove, squareType: easyAIPlayer.squareType)
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testMakeMoveOnFullGameBoard() {
        almostFillBoard()
        let _ = game.play(.bottomRight, squareType: humanPlayerSquareType)
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        XCTAssertNil(move)
    }
    
    private func almostFillBoard() {
        let _ = game.play(.centre, squareType: humanPlayerSquareType)
        let _ = game.play(.topLeft, squareType: easyAIPlayer.squareType)
        let _ = game.play(.top, squareType: humanPlayerSquareType)
        let _ = game.play(.left, squareType: easyAIPlayer.squareType)
        let _ = game.play(.bottomLeft, squareType: humanPlayerSquareType)
        let _ = game.play(.topRight, squareType: easyAIPlayer.squareType)
        let _ = game.play(.right, squareType: humanPlayerSquareType)
        let _ = game.play(.bottom, squareType: easyAIPlayer.squareType)
    }
    
}
