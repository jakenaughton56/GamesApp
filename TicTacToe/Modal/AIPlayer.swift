//
//  AIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class AIPlayer {
    
    let brain = Brain()
    let allBoardSqares: [Square] = [.topLeft,.top,.topRight,.left,.centre,.right,.bottomLeft,.bottom,.bottomRight]
    let squareType: SquareType
    
    init(squareType: SquareType) {
        self.squareType = squareType
    }
    
    func chooseMove(_ gameBoard: GameBoard) -> Square? {
        return nil
    }
    
    func chooseRandomSquareFrom(_ squares: [Square]) -> Square {
        let randomNumber = Int(arc4random_uniform(UInt32(squares.count)))
        if randomNumber < 0 || randomNumber > (squares.count-1) {
            print("Error: Random number generated was not an array index, defaulting to 0")
            return squares[0]
        }
        return squares[randomNumber]
    }
}
