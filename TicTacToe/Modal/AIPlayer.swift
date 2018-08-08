//
//  AIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class AIPlayer {
    
    let allBoardSqares: [Square] = [.topLeft,.top,.topRight,.left,.centre,.right,.bottomLeft,.bottom,.bottomRight]
    
    func chooseMove(_ gameBoard: GameBoard) -> Square? {
        return nil
    }
    
    func chooseRandomSquareFrom(_ squares: [Square]) -> Square {
        let randomNumber = Int(arc4random_uniform(UInt32(squares.count)))
        return squares[randomNumber]
        
//        switch randomNumber {
//        case 1:
//            return .topLeft
//        case 2:
//            return .top
//        case 3:
//            return .topRight
//        case 4:
//            return .left
//        case 5:
//            return .centre
//        case 6:
//            return .right
//        case 7:
//            return .bottomLeft
//        case 8:
//            return .bottom
//        case 9:
//            return .bottomRight
//        default:
//            print("Error: Random number failed to pick a square")
//            return .centre
//        }
    }
}
