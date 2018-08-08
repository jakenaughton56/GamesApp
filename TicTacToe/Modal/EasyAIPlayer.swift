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
            move = chooseRandomSquareFrom(allBoardSqares)
            gameState = game.play(move)
        } while gameState == .squareTaken
        
        return move
    }
    
    
    
}
