//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 26/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

struct GameBoard {
    var topLeft: SquareType
    var top: SquareType
    var topRight: SquareType
    var left: SquareType
    var centre: SquareType
    var right: SquareType
    var bottomLeft: SquareType
    var bottom: SquareType
    var bottomRight: SquareType
    init() {
        topLeft = .empty
        top = .empty
        topRight = .empty
        left = .empty
        centre = .empty
        right = .empty
        bottomLeft = .empty
        bottom = .empty
        bottomRight = .empty
    }
}

enum SquareType {
    case cross
    case nought
    case empty
}

enum Square {
    case topLeft
    case top
    case topRight
    case left
    case centre
    case right
    case bottomLeft
    case bottom
    case bottomRight
}

