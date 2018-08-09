//
//  Brain.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 27/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class Brain {
    
    // Check all seven combinations that lead to a win
    func hasPlayerWon(_ gameBoard: GameBoard) -> Bool {
        if areSquaresTheSameType(squares: [gameBoard.topLeft, gameBoard.top, gameBoard.topRight]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.left, gameBoard.centre, gameBoard.right]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.bottomLeft, gameBoard.bottom, gameBoard.bottomRight]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.topLeft, gameBoard.left, gameBoard.bottomLeft]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.top, gameBoard.centre, gameBoard.bottom]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.topRight, gameBoard.right, gameBoard.bottomRight]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.topLeft, gameBoard.centre, gameBoard.bottomRight]) {
            return true
        }
        if areSquaresTheSameType(squares: [gameBoard.topRight, gameBoard.centre, gameBoard.bottomLeft]) {
            return true
        }
        return false
    }
    
    // For a valid move square must be empty
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
    
    // For a full board there must be no empty spaces
    func isBoardFull(_ gameBoard: GameBoard) -> Bool {
        if gameBoard.topLeft == .empty || gameBoard.top == .empty || gameBoard.topRight == .empty || gameBoard.left == .empty || gameBoard.centre == .empty || gameBoard.right == .empty || gameBoard.bottomLeft == .empty || gameBoard.bottom == .empty || gameBoard.bottomRight == .empty {
            return false
        }
        return true
    }
    
    // Check every square on the game board is empty
    func isEmpty(_ gameBoard: GameBoard) -> Bool {
        if gameBoard.topLeft != .empty || gameBoard.top != .empty || gameBoard.topRight != .empty || gameBoard.left != .empty || gameBoard.centre != .empty || gameBoard.right != .empty || gameBoard.bottomLeft != .empty || gameBoard.bottom != .empty || gameBoard.bottomRight != .empty {
            return false
        } else {
            return true
        }
    }
    
    func getEmptySquares(_ gameBoard: GameBoard) -> [Square] {
        var squares = [Square]()
        if gameBoard.topLeft == .empty {
            squares.append(.topLeft)
        }
        if gameBoard.top == .empty {
            squares.append(.top)
        }
        if gameBoard.topRight == .empty {
            squares.append(.topRight)
        }
        if gameBoard.left == .empty {
            squares.append(.left)
        }
        if gameBoard.centre == .empty {
            squares.append(.centre)
        }
        if gameBoard.right == .empty {
            squares.append(.right)
        }
        if gameBoard.bottomLeft == .empty {
            squares.append(.bottomLeft)
        }
        if gameBoard.bottom == .empty {
            squares.append(.bottom)
        }
        if gameBoard.bottomRight == .empty {
            squares.append(.bottomRight)
        }
        return squares
    }
    
    private func areSquaresTheSameType(squares: [SquareType]) -> Bool {
        var isCross = false
        var isNought = false
        for square in squares {
            switch square {
            case .empty:
                return false
            case .cross:
                isCross = true
            case .nought:
                isNought = true
            }
        }
        if isCross == isNought {
            return false
        }
        return true
    }
    
}
