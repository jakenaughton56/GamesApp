//
//  Game.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 27/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class Game {
    
    let brain: Brain
    var gameBoard: GameBoard
    
    init() {
        brain = Brain()
        gameBoard = GameBoard()
    }
    
    func play(_ move: Square, squareType: SquareType) -> GameState {
        if !brain.isMoveValid(gameBoard: gameBoard, move: move) {
            return .squareTaken
        }
        if brain.hasPlayerWon(gameBoard) {
            return .playerAlreadyWon
        }
        
        switch move {
        case .topLeft:
            gameBoard.topLeft = squareType
        case .top:
            gameBoard.top = squareType
        case .topRight:
            gameBoard.topRight = squareType
        case .left:
            gameBoard.left = squareType
        case .centre:
            gameBoard.centre = squareType
        case .right:
            gameBoard.right = squareType
        case .bottomLeft:
            gameBoard.bottomLeft = squareType
        case .bottom:
            gameBoard.bottom = squareType
        case .bottomRight:
            gameBoard.bottomRight = squareType
        }
        if brain.hasPlayerWon(gameBoard) {
            return .playerWins
        }
        if brain.isBoardFull(gameBoard) {
            return .gameBoardFull
        }
        return .nextMove
    }
    
    func startNewGame() {
        gameBoard = GameBoard()
    }
}
