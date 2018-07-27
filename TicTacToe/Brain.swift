//
//  Brain.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 27/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class Brain {
    
    func hasPlayerWon(board: GameBoard) -> Bool {
        if board.topLeft == .cross && board.top == .cross && board.topRight == .cross {
            return true
        }
        if board.left == .cross && board.centre == .cross && board.right == .cross {
            return true
        }
        if board.bottomLeft == .cross && board.bottom == .cross && board.bottomRight == .cross {
            return true
        }
        if board.topLeft == .cross && board.left == .cross && board.bottomLeft == .cross {
            return true
        }
        if board.top == .cross && board.centre == .cross && board.bottom == .cross {
            return true
        }
        if board.topRight == .cross && board.right == .cross && board.bottomRight == .cross {
            return true
        }
        if board.topLeft == .cross && board.centre == .cross && board.bottomRight == .cross {
            return true
        }
        if board.topRight == .cross && board.centre == .cross && board.bottomLeft == .cross {
            return true
        }
        if board.topLeft == .nought && board.top == .nought && board.topRight == .nought {
            return true
        }
        if board.left == .nought && board.centre == .nought && board.right == .nought {
            return true
        }
        if board.bottomLeft == .nought && board.bottom == .nought && board.bottomRight == .nought {
            return true
        }
        if board.topLeft == .nought && board.left == .nought && board.bottomLeft == .nought {
            return true
        }
        if board.top == .nought && board.centre == .nought && board.bottom == .nought {
            return true
        }
        if board.topRight == .nought && board.right == .nought && board.bottomRight == .nought {
            return true
        }
        if board.topLeft == .nought && board.centre == .nought && board.bottomRight == .nought {
            return true
        }
        if board.topRight == .nought && board.centre == .nought && board.bottomLeft == .nought {
            return true
        }
        return false
    }
    
    func isMoveValid(board: GameBoard, move: Square) -> Bool {
        switch move {
        case .topLeft:
            return board.topLeft == .empty
        case .top:
            return board.top == .empty
        case .topRight:
            return board.topRight == .empty
        case .left:
            return board.left == .empty
        case .centre:
            return board.centre == .empty
        case .right:
            return board.right == .empty
        case .bottomLeft:
            return board.bottomLeft == .empty
        case .bottom:
            return board.bottom == .empty
        case .bottomRight:
            return board.bottomRight == .empty
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
