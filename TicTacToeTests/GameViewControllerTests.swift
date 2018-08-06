//
//  GameViewControllerTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 28/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameViewControllerTests: XCTestCase {
    
    var gameViewController: GameViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        UIApplication.shared.keyWindow!.rootViewController = gameViewController
        
        let _ = gameViewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUpdatingBoardStateOnce() {
        let _ = gameViewController.play(move: .topLeft)
        XCTAssert(gameViewController.game?.gameBoard.topLeft != .empty)
    }
    
    func testUpdatingBoardStateTwice() {
        let _ = gameViewController.play(move: .topLeft)
        let _ = gameViewController.play(move: .bottom)
        XCTAssert(gameViewController.game?.gameBoard.topLeft != .empty && gameViewController.game?.gameBoard.bottom != .empty)
    }
    
    func testWinningMove() {
        let _ = gameViewController.play(move: .topLeft)
        let _ = gameViewController.play(move: .bottom)
        let _ = gameViewController.play(move: .top)
        let _ = gameViewController.play(move: .bottomLeft)
        let finalGameState = gameViewController.play(move: .topRight)
        XCTAssert(finalGameState == .playerWins)
    }
    
    func testSquareIsTaken() {
        let _ = gameViewController.play(move: .topLeft)
        let finalGameState = gameViewController.play(move: .topLeft)
        XCTAssert(finalGameState == .squareTaken)
    }
    
    func testGameBoardIsFull() {
        let _ = gameViewController.play(move: .centre)
        let _ = gameViewController.play(move: .topLeft)
        let _ = gameViewController.play(move: .top)
        let _ = gameViewController.play(move: .left)
        let _ = gameViewController.play(move: .bottomLeft)
        let _ = gameViewController.play(move: .topRight)
        let _ = gameViewController.play(move: .right)
        let _ = gameViewController.play(move: .bottom)
        let finalGameState = gameViewController.play(move: .bottomRight)
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testPlayMoveAfterWin() {
        let _ = gameViewController.play(move: .topLeft)
        let _ = gameViewController.play(move: .bottom)
        let _ = gameViewController.play(move: .top)
        let _ = gameViewController.play(move: .bottomLeft)
        let _ = gameViewController.play(move: .topRight)
        let finalGameState = gameViewController.play(move: .bottomRight)
        XCTAssert(finalGameState == .playerAlreadyWon)
        XCTAssert(gameViewController.game?.gameBoard.bottomRight == .empty)
    }
    
    func testStartingNewGame() {
        let brain = Brain()
        let _ = gameViewController.play(move: .topLeft)
        let _ = gameViewController.play(move: .bottom)
        let _ = gameViewController.play(move: .top)
        guard let gameBoardStateOne = gameViewController.game?.gameBoard else {
            XCTFail()
            return
        }
        XCTAssertFalse(brain.checkEmpty(gameBoard: gameBoardStateOne))
        gameViewController.newGame()
        guard let gameBoardStateTwo = gameViewController.game?.gameBoard else {
            XCTFail()
            return
        }
        XCTAssertTrue(brain.checkEmpty(gameBoard: gameBoardStateTwo))
    }
    
    func testInitialScores() {
        guard let playerOneScore = gameViewController.playerOneScore else {
            XCTFail()
            return
        }
        guard let playerTwoScore = gameViewController.playerTwoScore else {
            XCTFail()
            return
        }
        XCTAssertTrue(playerOneScore == 0)
        XCTAssertTrue(playerTwoScore == 0)
    }
    
    func testIncreasingPlayerOnesScore() {
        let player = Player.playerOne
        gameViewController.updateScore(player: player)
        guard let playerOneScore = gameViewController.playerOneScore else {
            XCTFail()
            return
        }
        XCTAssertTrue(playerOneScore == 1)
    }
    
    func testIncreasingPlayerOnesScoreTwice() {
        let player = Player.playerOne
        gameViewController.updateScore(player: player)
        gameViewController.updateScore(player: player)
        guard let playerOneScore = gameViewController.playerOneScore else {
            XCTFail()
            return
        }
        XCTAssertTrue(playerOneScore == 2)
    }
    
    func testIncreasingPlayerTwosScore() {
        let player = Player.playerTwo
        gameViewController.updateScore(player: player)
        guard let playerTwoScore = gameViewController.playerTwoScore else {
            XCTFail()
            return
        }
        XCTAssertTrue(playerTwoScore == 1)
    }
    
    func testIncreasingPlayerTwosScoreTwice() {
        let player = Player.playerTwo
        gameViewController.updateScore(player: player)
        gameViewController.updateScore(player: player)
        guard let playerTwoScore = gameViewController.playerTwoScore else {
            XCTFail()
            return
        }
        XCTAssertTrue(playerTwoScore == 2)
    }
    
}
