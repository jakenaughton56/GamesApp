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
        let storyboard = UIStoryboard(name: "Game", bundle: Bundle.main)
        gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        UIApplication.shared.keyWindow!.rootViewController = gameViewController
        let _ = gameViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdatingBoardStateOnce() {
        gameViewController.play(.topLeft)
        XCTAssert(gameViewController.game?.gameBoard.topLeft != .empty)
    }
    
    func testUpdatingBoardStateTwice() {
        gameViewController.play(.topLeft)
        gameViewController.play(.bottom)
        XCTAssert(gameViewController.game?.gameBoard.topLeft != .empty && gameViewController.game?.gameBoard.bottom != .empty)
    }
    
    func testWinningMove() {
        gameViewController.play(.topLeft)
        gameViewController.play(.bottom)
        gameViewController.play(.top)
        gameViewController.play(.bottomLeft)
        gameViewController.play(.topRight)
        guard let finalGameState = gameViewController.gameState else {
            XCTFail()
            return
        }
        XCTAssert(finalGameState == .playerWins)
    }
    
    func testSquareIsTaken() {
        gameViewController.play(.topLeft)
        gameViewController.play(.topLeft)
        guard let finalGameState = gameViewController.gameState else {
            XCTFail()
            return
        }
        XCTAssert(finalGameState == .squareTaken)
    }
    
    func testGameBoardIsFull() {
        gameViewController.play(.centre)
        gameViewController.play(.topLeft)
        gameViewController.play(.top)
        gameViewController.play(.left)
        gameViewController.play(.bottomLeft)
        gameViewController.play(.topRight)
        gameViewController.play(.right)
        gameViewController.play(.bottom)
        gameViewController.play(.bottomRight)
        guard let finalGameState = gameViewController.gameState else {
            XCTFail()
            return
        }
        XCTAssert(finalGameState == .gameBoardFull)
    }
    
    func testPlayMoveAfterWin() {
        gameViewController.play(.topLeft)
        gameViewController.play(.bottom)
        gameViewController.play(.top)
        gameViewController.play(.bottomLeft)
        gameViewController.play(.topRight)
        gameViewController.play(.bottomRight)
        guard let finalGameState = gameViewController.gameState else {
            XCTFail()
            return
        }
        XCTAssert(finalGameState == .playerAlreadyWon)
        XCTAssert(gameViewController.game?.gameBoard.bottomRight == .empty)
    }
    
    func testStartingNewGame() {
        let brain = Brain()
        gameViewController.play(.topLeft)
        gameViewController.play(.bottom)
        gameViewController.play(.top)
        guard let gameBoardStateOne = gameViewController.game?.gameBoard else {
            XCTFail()
            return
        }
        XCTAssertFalse(brain.isEmpty(gameBoardStateOne))
        gameViewController.newGame()
        guard let gameBoardStateTwo = gameViewController.game?.gameBoard else {
            XCTFail()
            return
        }
        XCTAssertTrue(brain.isEmpty(gameBoardStateTwo))
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
    
    func testAllSquaresHaveNoImage() {
        XCTAssertNil(gameViewController.topLeftButton.currentImage)
        XCTAssertNil(gameViewController.topButton.currentImage)
        XCTAssertNil(gameViewController.topRightButton.currentImage)
        XCTAssertNil(gameViewController.leftButton.currentImage)
        XCTAssertNil(gameViewController.centreButton.currentImage)
        XCTAssertNil(gameViewController.rightButton.currentImage)
        XCTAssertNil(gameViewController.bottomLeftButton.currentImage)
        XCTAssertNil(gameViewController.bottomButton.currentImage)
        XCTAssertNil(gameViewController.bottomRightButton.currentImage)
    }
    
    func testDrawingOnAllSquares() {
        gameViewController.play(.topLeft)
        guard let topLeftImage = gameViewController.topLeftButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.top)
        guard let topImage = gameViewController.topButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.left)
        guard let leftImage = gameViewController.leftButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.centre)
        guard let centreImage = gameViewController.centreButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.topRight)
        guard let topRightImage = gameViewController.topRightButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.bottomLeft)
        guard let bottomLeftImage = gameViewController.bottomLeftButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.bottom)
        guard let bottomImage = gameViewController.bottomButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.right)
        guard let rightImage = gameViewController.rightButton.currentImage else {
            XCTFail()
            return
        }
        gameViewController.play(.bottomRight)
        guard let bottomRightImage = gameViewController.bottomRightButton.currentImage else {
            XCTFail()
            return
        }
        XCTAssert(topLeftImage.isEqual(#imageLiteral(resourceName: "Cross")))
        XCTAssert(topImage.isEqual(#imageLiteral(resourceName: "Nought")))
        XCTAssert(leftImage.isEqual(#imageLiteral(resourceName: "Cross")))
        XCTAssert(centreImage.isEqual(#imageLiteral(resourceName: "Nought")))
        XCTAssert(topRightImage.isEqual(#imageLiteral(resourceName: "Cross")))
        XCTAssert(bottomLeftImage.isEqual(#imageLiteral(resourceName: "Nought")))
        XCTAssert(bottomImage.isEqual(#imageLiteral(resourceName: "Cross")))
        XCTAssert(rightImage.isEqual(#imageLiteral(resourceName: "Nought")))
        XCTAssert(bottomRightImage.isEqual(#imageLiteral(resourceName: "Cross")))
    }
    
    func testEasyGameMode() {
        gameViewController.gameMode = .easy
        gameViewController.play(.centre)
        XCTAssert(gameViewController.game?.isItPlayerOnesTurn == true)
    }
    
}
