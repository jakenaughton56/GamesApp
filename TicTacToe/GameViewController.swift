//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 28/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var game: Game?
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centreButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBOutlet weak var gameStateLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(player1: .human, player2: .human)
        localizeControllerStrings()
    }
    
    func localizeControllerStrings() {
        newGameButton.setTitle(NSLocalizedString("New Game", comment: "Start a new game"), for: .normal)
        backButton.setTitle(NSLocalizedString("Back", comment: "Go back to main menu"), for: .normal)
        gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player Ones turn to move")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func play(move: Square) -> GameState {
        guard let unwrappedGame = game else {
            print("Game didn't intiate properly")
            return .error
        }
        let gameState = unwrappedGame.play(move: move)
        return gameState
    }

    @IBAction func squareTapped(_ sender: UIButton) {
        var square: Square
        switch sender {
        case topLeftButton:
            square = .topLeft
        case topButton:
            square = .top
        case topRightButton:
            square = .topRight
        case leftButton:
            square = .left
        case centreButton:
            square = .centre
        case rightButton:
            square = .right
        case bottomLeftButton:
            square = .bottomLeft
        case bottomButton:
            square = .bottom
        case bottomRightButton:
            square = .bottomRight
        default:
            print("Square does not exist")
            return
        }
        guard let unwrappedGame = game else {
            print("Game didn't intiate properly")
            return
        }
        let isItPlayerOnesTurn = unwrappedGame.isItPlayerOnesTurn
        let gameState = play(move: square)
        
        switch gameState {
        case .nextMove:
            drawOnSquare(square: square, button: sender, isItPlayerOnesTurn: isItPlayerOnesTurn)
            if isItPlayerOnesTurn {
                gameStateLabel.text = NSLocalizedString("Player Two's Turn", comment: "Player One's turn to move")
            } else {
                gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player Two's turn to move")
            }
        case .gameBoardFull:
            drawOnSquare(square: square, button: sender, isItPlayerOnesTurn: isItPlayerOnesTurn)
            gameStateLabel.text = NSLocalizedString("Draw!", comment: "Game was drawn")
        case .playerWon:
            drawOnSquare(square: square, button: sender, isItPlayerOnesTurn: isItPlayerOnesTurn)
            if isItPlayerOnesTurn {
                gameStateLabel.text = NSLocalizedString("Player One Wins!", comment: "Player One Won the game")
            } else {
                gameStateLabel.text = NSLocalizedString("Player Two Wins!", comment: "Player Two Won the game")
            }
        case .squareTaken:
            // Don't need to do anything
            break
        case .error:
            print("Error With GameState")
        }
            
    }
    
    func drawOnSquare(square: Square, button: UIButton, isItPlayerOnesTurn: Bool) {
        if isItPlayerOnesTurn {
            button.setImage(#imageLiteral(resourceName: "Cross"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "Nought"), for: .normal)
        }
    }
}
