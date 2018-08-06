//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 28/7/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var playerOneScore: Int? {
        didSet {
            guard let unwrappedScore = playerOneScore else {
                print("Player One's score did not intiate properly")
                return
            }
            playerOneScoreLabel.text = "\(unwrappedScore)"
        }
    }
    var playerTwoScore: Int? {
        didSet {
            guard let unwrappedScore = playerTwoScore else {
                print("Player Two's score did not intiate properly")
                return
            }
            playerTwoScoreLabel.text = "\(unwrappedScore)"
        }
    }
    
    var game: Game?
    
    @IBOutlet weak var playerOneTitleLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoTitleLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    
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
        setInitialScores()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func localizeControllerStrings() {
        newGameButton.setTitle(NSLocalizedString("New Game", comment: "Start a new game"), for: .normal)
        backButton.setTitle(NSLocalizedString("Back", comment: "Go back to main menu"), for: .normal)
        gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player Ones turn to move")
        playerOneTitleLabel.text = NSLocalizedString("Player One", comment: "Player One's Title")
        playerTwoTitleLabel.text = NSLocalizedString("Player Two", comment: "Player Two's Title")
    }
    
    private func setInitialScores() {
        playerOneScore = 0
        playerTwoScore = 0
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
            print("Couldn't match square to button")
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
                gameStateLabel.text = NSLocalizedString("Player Two's Turn", comment: "Player Two's turn to move")
            } else {
                gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player One's turn to move")
            }
        case .gameBoardFull:
            drawOnSquare(square: square, button: sender, isItPlayerOnesTurn: isItPlayerOnesTurn)
            gameStateLabel.text = NSLocalizedString("Draw!", comment: "Game was drawn")
        case .playerWins:
            drawOnSquare(square: square, button: sender, isItPlayerOnesTurn: isItPlayerOnesTurn)
            if isItPlayerOnesTurn {
                gameStateLabel.text = NSLocalizedString("Player One Wins!", comment: "Player One Won the game")
                updateScore(player: .playerOne)
            } else {
                gameStateLabel.text = NSLocalizedString("Player Two Wins!", comment: "Player Two Won the game")
                updateScore(player: .playerTwo)
            }
        case .squareTaken:
            // Don't need to do anything
            break
        case .playerAlreadyWon:
            // Don't need to do anything
            break
        case .error:
            print("Error With GameState")
        }
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        newGame()
        gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player One's turn to move")
    }
    
    func play(move: Square) -> GameState {
        guard let unwrappedGame = game else {
            print("Game didn't intiate properly")
            return .error
        }
        let gameState = unwrappedGame.play(move: move)
        return gameState
    }
    
    func newGame() {
        guard let unwrappedGame = game else {
            print("Game didn't intiate properly")
            return
        }
        unwrappedGame.startNewGame()
        topLeftButton.setImage(nil, for: .normal)
        topButton.setImage(nil, for: .normal)
        topRightButton.setImage(nil, for: .normal)
        leftButton.setImage(nil, for: .normal)
        centreButton.setImage(nil, for: .normal)
        rightButton.setImage(nil, for: .normal)
        bottomLeftButton.setImage(nil, for: .normal)
        bottomButton.setImage(nil, for: .normal)
        bottomRightButton.setImage(nil, for: .normal)
    }
    
    func updateScore(player: Player) {
        switch player {
        case .playerOne:
            guard let unwrappedScore = playerOneScore else {
                print("Player One's score did not intiate properly")
                return
            }
            playerOneScore = unwrappedScore + 1
        case .playerTwo:
            guard let unwrappedScore = playerTwoScore else {
                print("Player Two's score did not intiate properly")
                return
            }
            playerTwoScore = unwrappedScore + 1
        }
    }
    
    private func drawOnSquare(square: Square, button: UIButton, isItPlayerOnesTurn: Bool) {
        if isItPlayerOnesTurn {
            button.setImage(#imageLiteral(resourceName: "Cross"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "Nought"), for: .normal)
        }
    }
}
