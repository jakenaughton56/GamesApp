//
//  ImpossibleAIPlayer.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 9/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class ImpossibleAIPlayerTests: XCTestCase {
    
    var gameBoard = GameBoard()
    let game = Game()
    let humanPlayer = Constants.playerOneSquareType
    let impossibleAIPlayer = ImpossibleAIPlayer(squareType: Constants.playerTwoSquareType)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakingFirstMove() {
        guard let aiMove = impossibleAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on an empty game board")
            return
        }
        let finalGameState = game.play(aiMove, squareType: impossibleAIPlayer.squareType)
        XCTAssert(finalGameState == .nextMove)
    }
    
    func testMakingMoveWhenGameBoardHasOneEmptySpace() {
        gameBoard = GameBoardTests.almostFillBoard(playerOne: impossibleAIPlayer.squareType, playerTwo: humanPlayer)
        guard let aiMove = impossibleAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on the one empty space on the game board")
            return
        }
        XCTAssert(aiMove == .bottomRight)
    }
    
    func testMakingMoveOnFullBoard() {
        gameBoard = GameBoardTests.almostFillBoard(playerOne: humanPlayer, playerTwo: impossibleAIPlayer.squareType)
        gameBoard.bottomRight = humanPlayer
        let move = impossibleAIPlayer.chooseMove(gameBoard)
        XCTAssertNil(move)
    }

    func testWinningMove() {
        gameBoard.topLeft = impossibleAIPlayer.squareType
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.top = humanPlayer
        gameBoard.bottomLeft = humanPlayer
        gameBoard.right = humanPlayer
        guard let aiMove = impossibleAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottomRight, "AI Player failed to make winning move")
    }
    
    func testBlockingMove() {
        gameBoard.topRight = humanPlayer
        gameBoard.centre = humanPlayer
        gameBoard.top = impossibleAIPlayer.squareType
        gameBoard.bottomRight = impossibleAIPlayer.squareType
        gameBoard.left = impossibleAIPlayer.squareType
        guard let aiMove = impossibleAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottomLeft, "AI Player failed to make blocking move")
    }
    
    func testMakingWinningMoveOverBlockingMove() {
        gameBoard.topLeft = impossibleAIPlayer.squareType
        gameBoard.left = impossibleAIPlayer.squareType
        gameBoard.top = humanPlayer
        gameBoard.centre = humanPlayer
        guard let aiMove = impossibleAIPlayer.chooseMove(gameBoard) else {
            XCTFail("AI Player failed to make a move on a board with empty spaces")
            return
        }
        XCTAssert(aiMove == .bottomLeft, "AI Player failed to make winning move when blocking move was available")
    }
    
    func testNotLoosingToMediumAIOverOneHundredGames() {
        let mediumAIPlayer = MediumAIPlayer(squareType: humanPlayer)
        var numberOfGames = 0
        var mediumPlayerWon = false
        
        while !mediumPlayerWon && numberOfGames < 100 {
            game.startNewGame()
            var gameState = GameState.nextMove
            while gameState == .nextMove {
                guard let mediumAIMove = mediumAIPlayer.chooseMove(game.gameBoard) else {
                    XCTFail("Game State is next move so Medium AI should be able to choose a move")
                    return
                }
                gameState = game.play(mediumAIMove, squareType: mediumAIPlayer.squareType)
                
                switch gameState {
                case .nextMove:
                    guard let impossibleAIMove = impossibleAIPlayer.chooseMove(game.gameBoard) else {
                        XCTFail("Game State is next move so Impossible AI should be able to choose a move")
                        return
                    }
                    gameState = game.play(impossibleAIMove, squareType: impossibleAIPlayer.squareType)
                case .playerWins:
                    mediumPlayerWon = true
                default:
                    break
                }
            }
            numberOfGames += 1
        }
        XCTAssertFalse(mediumPlayerWon, "Medium AI Beat Impossible AI")
    }
    
    func testMaxFunctionForWinInOneMove() {
        gameBoard.bottomLeft = impossibleAIPlayer.squareType
        gameBoard.left = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.maxMove(.topLeft, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
    func testMaxFunctionForWinInTwoMoves() {
        gameBoard.bottomLeft = impossibleAIPlayer.squareType
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.topRight = humanPlayer
        gameBoard.bottom = humanPlayer
        let score = impossibleAIPlayer.maxMove(.left, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
    func testMaxFunctionForWinAfterOneMove() {
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.top = humanPlayer
        let score = impossibleAIPlayer.maxMove(.topRight, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
    func testMaxFunctionForWinAfterTwoMoves() {
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.top = humanPlayer
        gameBoard.left = impossibleAIPlayer.squareType
        gameBoard.right = humanPlayer
        let score = impossibleAIPlayer.maxMove(.topLeft, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
    func testMaxFunctionForDrawAfterOneMove() {
        gameBoard.centre = humanPlayer
        let score = impossibleAIPlayer.maxMove(.bottomLeft, gameBoard: gameBoard)
        XCTAssert(score == Constants.drawScore)
    }
    
    func testMaxFunctionForDrawAfterTwoMoves() {
        gameBoard.topRight = humanPlayer
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.topLeft = humanPlayer
        let score = impossibleAIPlayer.maxMove(.top, gameBoard: gameBoard)
        XCTAssert(score == Constants.drawScore)
    }
    
    func testMaxFunctionForLossAfterOneMove() {
        gameBoard.centre = humanPlayer
        let score = impossibleAIPlayer.maxMove(.bottom, gameBoard: gameBoard)
        XCTAssert(score == Constants.loseScore)
    }
    
    func testMaxFunctionForLossAfterTwoMoves() {
        gameBoard.centre = humanPlayer
        gameBoard.topRight = impossibleAIPlayer.squareType
        gameBoard.bottomLeft = humanPlayer
        let score = impossibleAIPlayer.maxMove(.top, gameBoard: gameBoard)
        XCTAssert(score == Constants.loseScore)
    }
    
    func testMinFunctionForLoseInOneMove() {
        gameBoard.topRight = humanPlayer
        gameBoard.right = humanPlayer
        let score = impossibleAIPlayer.minMove(.bottomRight, gameBoard: gameBoard)
        XCTAssert(score == Constants.loseScore)
    }
    
    func testMinFunctionForLoseAfterOneMove() {
        gameBoard.centre = humanPlayer
        gameBoard.bottom = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.bottomRight, gameBoard: gameBoard)
        XCTAssert(score == Constants.loseScore)
    }
    
    func testMinFunctionForLoseAfterTwoMoves() {
        gameBoard.centre = humanPlayer
        gameBoard.top = impossibleAIPlayer.squareType
        gameBoard.right = humanPlayer
        gameBoard.left = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.bottomRight, gameBoard: gameBoard)
        XCTAssert(score == Constants.loseScore)
    }
    
    func testMinFunctionForDrawAfterOneMove() {
        gameBoard.centre = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.bottomLeft, gameBoard: gameBoard)
        XCTAssert(score == Constants.drawScore)
    }
    
    func testMinFunctionForDrawAfterTwoMoves() {
        gameBoard.centre = humanPlayer
        gameBoard.bottomLeft = impossibleAIPlayer.squareType
        gameBoard.bottomRight = humanPlayer
        gameBoard.topLeft = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.left, gameBoard: gameBoard)
        XCTAssert(score == Constants.drawScore)
    }
    
    func testMinFunctionForWinAfterOneMove() {
        gameBoard.centre = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.bottom, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
    func testMinFunctionForWinAfterTwoMoves() {
        gameBoard.centre = impossibleAIPlayer.squareType
        gameBoard.bottom = humanPlayer
        gameBoard.bottomRight = impossibleAIPlayer.squareType
        let score = impossibleAIPlayer.minMove(.topLeft, gameBoard: gameBoard)
        XCTAssert(score == Constants.winScore)
    }
    
}
