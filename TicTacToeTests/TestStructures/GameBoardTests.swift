//
//  gameBoardTests.swift
//  TicTacToeTests
//
//  Created by Jake Mobile Dev on 9/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import XCTest
@testable import TicTacToe

struct GameBoardTests {
    
    // Almost fill board except for bottom right player one's move
    static func almostFillBoard(playerOne: SquareType, playerTwo: SquareType) -> GameBoard {
        var gameBoard = GameBoard()
        gameBoard.centre = playerOne
        gameBoard.topLeft = playerTwo
        gameBoard.top = playerOne
        gameBoard.left = playerTwo
        gameBoard.bottomLeft = playerOne
        gameBoard.topRight = playerTwo
        gameBoard.right = playerOne
        gameBoard.bottom = playerTwo
        return gameBoard
    }
}
