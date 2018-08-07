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
    var isItPlayerOnesTurn: Bool
    
    init() {
        brain = Brain()
        gameBoard = GameBoard()
        isItPlayerOnesTurn = true
    }
    
    func play(_ move: Square) -> GameState {
        let playerSquareType: SquareType
        if isItPlayerOnesTurn {
            playerSquareType = .cross
        } else {
            playerSquareType = .nought
        }
        if !brain.isMoveValid(gameBoard: gameBoard, move: move) {
            return .squareTaken
        }
        if brain.hasPlayerWon(gameBoard) {
            return .playerAlreadyWon
        }
        isItPlayerOnesTurn = !isItPlayerOnesTurn
        
        switch move {
        case .topLeft:
            gameBoard.topLeft = playerSquareType
        case .top:
            gameBoard.top = playerSquareType
        case .topRight:
            gameBoard.topRight = playerSquareType
        case .left:
            gameBoard.left = playerSquareType
        case .centre:
            gameBoard.centre = playerSquareType
        case .right:
            gameBoard.right = playerSquareType
        case .bottomLeft:
            gameBoard.bottomLeft = playerSquareType
        case .bottom:
            gameBoard.bottom = playerSquareType
        case .bottomRight:
            gameBoard.bottomRight = playerSquareType
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
        isItPlayerOnesTurn = true
    }
}
