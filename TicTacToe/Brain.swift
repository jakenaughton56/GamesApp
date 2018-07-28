//
//  Brain.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 27/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class Brain {
    
    func hasPlayerWon(gameBoard: GameBoard) -> Bool {
        if gameBoard.topLeft == .cross && gameBoard.top == .cross && gameBoard.topRight == .cross {
            return true
        }
        if gameBoard.left == .cross && gameBoard.centre == .cross && gameBoard.right == .cross {
            return true
        }
        if gameBoard.bottomLeft == .cross && gameBoard.bottom == .cross && gameBoard.bottomRight == .cross {
            return true
        }
        if gameBoard.topLeft == .cross && gameBoard.left == .cross && gameBoard.bottomLeft == .cross {
            return true
        }
        if gameBoard.top == .cross && gameBoard.centre == .cross && gameBoard.bottom == .cross {
            return true
        }
        if gameBoard.topRight == .cross && gameBoard.right == .cross && gameBoard.bottomRight == .cross {
            return true
        }
        if gameBoard.topLeft == .cross && gameBoard.centre == .cross && gameBoard.bottomRight == .cross {
            return true
        }
        if gameBoard.topRight == .cross && gameBoard.centre == .cross && gameBoard.bottomLeft == .cross {
            return true
        }
        if gameBoard.topLeft == .nought && gameBoard.top == .nought && gameBoard.topRight == .nought {
            return true
        }
        if gameBoard.left == .nought && gameBoard.centre == .nought && gameBoard.right == .nought {
            return true
        }
        if gameBoard.bottomLeft == .nought && gameBoard.bottom == .nought && gameBoard.bottomRight == .nought {
            return true
        }
        if gameBoard.topLeft == .nought && gameBoard.left == .nought && gameBoard.bottomLeft == .nought {
            return true
        }
        if gameBoard.top == .nought && gameBoard.centre == .nought && gameBoard.bottom == .nought {
            return true
        }
        if gameBoard.topRight == .nought && gameBoard.right == .nought && gameBoard.bottomRight == .nought {
            return true
        }
        if gameBoard.topLeft == .nought && gameBoard.centre == .nought && gameBoard.bottomRight == .nought {
            return true
        }
        if gameBoard.topRight == .nought && gameBoard.centre == .nought && gameBoard.bottomLeft == .nought {
            return true
        }
        return false
    }
    
    func isMoveValid(gameBoard: GameBoard, move: Square) -> Bool {
        switch move {
        case .topLeft:
            return gameBoard.topLeft == .empty
        case .top:
            return gameBoard.top == .empty
        case .topRight:
            return gameBoard.topRight == .empty
        case .left:
            return gameBoard.left == .empty
        case .centre:
            return gameBoard.centre == .empty
        case .right:
            return gameBoard.right == .empty
        case .bottomLeft:
            return gameBoard.bottomLeft == .empty
        case .bottom:
            return gameBoard.bottom == .empty
        case .bottomRight:
            return gameBoard.bottomRight == .empty
        }
    }
    
    func isBoardFull(gameBoard: GameBoard) -> Bool {
        if gameBoard.topLeft == .empty || gameBoard.top == .empty || gameBoard.topRight == .empty {
            return false
        }
        if gameBoard.left == .empty || gameBoard.centre == .empty || gameBoard.right == .empty {
            return false
        }
        if gameBoard.bottomLeft == .empty || gameBoard.bottom == .empty || gameBoard.bottomRight == .empty {
            return false
        }
        return true
    }
}
