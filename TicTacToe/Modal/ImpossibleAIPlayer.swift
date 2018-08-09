//
//  ImpossibleAIPlayer.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 9/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import Foundation

class ImpossibleAIPlayer: AdvancedAIPlayer {
    
    override func chooseMove(_ gameBoard: GameBoard) -> Square? {
        let emptySquares = brain.getEmptySquares(gameBoard)
        var squaresToPlay = [Square]()
        if emptySquares.count == 0 {
            return nil
        }
        if emptySquares.count > Constants.numberOfSquaresOnBoard - 2 {
            if gameBoard.centre == .empty {
                squaresToPlay.append(.centre)
            } else {
                squaresToPlay = [.topLeft, .topRight, .bottomLeft, .bottomRight]
            }
        } else {
            var highestScore = Constants.noScore
            for square in emptySquares {
                let currentScore = maxMove(square, gameBoard: gameBoard)
                if currentScore >= highestScore {
                    if currentScore > highestScore {
                        highestScore = currentScore
                        squaresToPlay = [Square]()
                    }
                    squaresToPlay.append(square)
                }
            }
            
        }
        return chooseRandomSquareFrom(squaresToPlay)
    }
    
    func maxMove(_ square: Square, gameBoard: GameBoard) -> Int {
        let game = Game()
        game.gameBoard = gameBoard
        let gameState = game.play(square, squareType: self.squareType)
        switch gameState {
        case .playerWins:
            return Constants.winScore
        case .gameBoardFull:
            return Constants.drawScore
        case .nextMove:
            let emptySquares = brain.getEmptySquares(game.gameBoard)
            var minScore = Constants.winScore
            for emptySquare in emptySquares {
                let currentMinScore = minMove(emptySquare, gameBoard: game.gameBoard)
                if currentMinScore < minScore {
                    minScore = currentMinScore
                }
            }
            return minScore
        default:
            print("Error: should never get here in Max Move for Impossible AI Player")
            return Constants.noScore
        }
    }
    
    func minMove(_ square: Square, gameBoard: GameBoard) -> Int {
        let game = Game()
        game.gameBoard = gameBoard
        let opponentSquareType: SquareType
        if self.squareType == .nought {
            opponentSquareType = .cross
        } else {
            opponentSquareType = .nought
        }
        let gameState = game.play(square, squareType: opponentSquareType)
        switch gameState {
        case .playerWins:
            return Constants.loseScore
        case .gameBoardFull:
            return Constants.drawScore
        case .nextMove:
            let emptySquares = brain.getEmptySquares(game.gameBoard)
            var maxScore = Constants.loseScore
            for emptySquare in emptySquares {
                let currentMinScore = maxMove(emptySquare, gameBoard: game.gameBoard)
                if currentMinScore > maxScore {
                    maxScore = currentMinScore
                }
            }
            return maxScore
        default:
            print("Error: should never get here in Max Move for Impossible AI Player")
            return Constants.noScore
        }
    }
}
