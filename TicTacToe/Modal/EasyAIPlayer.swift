//
//  EasyAIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class EasyAIPlayer: AIPlayer {
    
    override func chooseMove(_ gameBoard: GameBoard) -> Square? {
        let brain = Brain()
        let game = Game()
        if brain.isBoardFull(gameBoard) { return nil }
        game.gameBoard = gameBoard
        var gameState: GameState
        var move: Square
        repeat {
            move = getRandomSquare()
            gameState = game.play(move)
        } while gameState == .squareTaken
        
        return move
    }
    
    private func getRandomSquare() -> Square {
        let randomNumber = arc4random_uniform(9) + 1
        switch randomNumber {
        case 1:
            return .topLeft
        case 2:
            return .top
        case 3:
            return .topRight
        case 4:
            return .left
        case 5:
            return .centre
        case 6:
            return .right
        case 7:
            return .bottomLeft
        case 8:
            return .bottom
        case 9:
            return .bottomRight
        default:
            print("Error: Random number failed to pick a square")
            return .centre
        }
    }
    
}
