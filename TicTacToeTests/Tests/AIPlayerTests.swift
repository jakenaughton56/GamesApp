//
//  AIPlayer.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

class AIPlayerTests: XCTestCase {
    
    let aiPlayer = AIPlayer(squareType: Constants.playerTwoSquareType)
    let gameBoard = GameBoard()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testChoosingMove() {
        let move = aiPlayer.chooseMove(gameBoard)
        XCTAssertNil(move)
    }
    
    func testChooseRandomSquareCyclesThroughAllSquares() {
        let allBoardSquares = aiPlayer.allBoardSqares
        var newBoardSquares = [Square]()
        repeat {
            let square = aiPlayer.chooseRandomSquareFrom(allBoardSquares)
            if !newBoardSquares.contains(square) {
                newBoardSquares.append(square)
            }
        } while newBoardSquares.count != allBoardSquares.count
        XCTAssert(newBoardSquares.count == allBoardSquares.count)
    }
    
    func testChooseRandomSquareCyclesThroughSomeSquares() {
        let boardSquares: [Square] = [.topRight, .topLeft, .bottomRight, .bottomLeft]
        var newBoardSquares = [Square]()
        repeat {
            let square = aiPlayer.chooseRandomSquareFrom(boardSquares)
            if !newBoardSquares.contains(square) {
                newBoardSquares.append(square)
            }
        } while newBoardSquares.count != boardSquares.count
        XCTAssert(newBoardSquares.count == boardSquares.count)
    }
    
}
