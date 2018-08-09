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
        return makeRandomMove(gameBoard)
    }
}
