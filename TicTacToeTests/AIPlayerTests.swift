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
    
    let aiPlayer = AIPlayer()
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
    
}
