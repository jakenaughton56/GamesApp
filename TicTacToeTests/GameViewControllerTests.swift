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
        XCTAssert(finalGameState == .playerWon)
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
    
}
