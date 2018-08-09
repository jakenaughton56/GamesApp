//
//  MediumAIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 9/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class MediumAIPlayer: AdvancedAIPlayer {
    
    override func chooseMove(_ gameBoard: GameBoard) -> Square? {
        var squares = checkForWin(gameBoard)
        if squares.count != 0 {
            return chooseRandomSquareFrom(squares)
        }
        squares = checkForBlock(gameBoard)
        if squares.count != 0 {
            return chooseRandomSquareFrom(squares)
        }
        let move = makeRandomMove(gameBoard)
        return move
    }
}
