//
//  AdvancedAIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 8/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class AdvancedAIPlayer: AIPlayer {
    
    let game = Game()
    
    func checkForWin(_ gameBoard: GameBoard) -> [Square] {
        return checkForWinningLine(gameBoard, squareType: self.squareType)
    }
    
    func checkForBlock(_ gameBoard: GameBoard) -> [Square] {
        let enemySquareType: SquareType
        if(self.squareType == .nought) {
            enemySquareType = .cross
        } else {
            enemySquareType = .nought
        }
        return checkForWinningLine(gameBoard, squareType: enemySquareType)
    }
    
    func checkForWinningLine(_ gameBoard: GameBoard, squareType: SquareType) -> [Square] {
        var squares = [Square]()
        if brain.hasPlayerWon(gameBoard) {
            print("Game has already been won, no need to pick a winning move")
            return squares
        }
        if brain.isBoardFull(gameBoard) {
            print("Game Board is full, no need to pick a winning move")
            return squares
        }
        for square in allBoardSqares {
            game.gameBoard = gameBoard
            let gameState = game.play(square, squareType: squareType)
            if gameState == .playerWins {
                squares.append(square)
            }
        }
        return squares
    }
}
