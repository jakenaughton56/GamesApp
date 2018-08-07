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
    let easyAIPlayer = EasyAIPlayer()
    
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
        let finalGameState = game.play(aiMove)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMakeMoveWhenGameBoardHasOneEmptySpace() {
        almostFillBoard()
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        guard let aiMove = move else {
            XCTFail()
            return
        }
        let finalGameState = game.play(aiMove)
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testMakeMoveOnFullGameBoard() {
        almostFillBoard()
        let _ = game.play(.bottomRight)
        let move = easyAIPlayer.chooseMove(game.gameBoard)
        XCTAssertNil(move)
    }
    
    private func almostFillBoard() {
        let _ = game.play(.centre)
        let _ = game.play(.topLeft)
        let _ = game.play(.top)
        let _ = game.play(.left)
        let _ = game.play(.bottomLeft)
        let _ = game.play(.topRight)
        let _ = game.play(.right)
        let _ = game.play(.bottom)
    }
    
}
