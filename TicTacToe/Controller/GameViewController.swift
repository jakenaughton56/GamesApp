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
    
    let game = Game()
    var isItPlayerOnesTurn: Bool = true
    var gameMode: GameMode?
    var gameState: GameState?
    
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
        localizeStrings()
        setInitialScores()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func localizeStrings() {
        newGameButton.setTitle(NSLocalizedString("New Game", comment: "Start a new game"), for: .normal)
        backButton.setTitle(NSLocalizedString("Back", comment: "Go back to main menu"), for: .normal)
        guard let unwrappedGameMode = gameMode else {
            print("Game Mode was never intiated")
            return
        }
        if unwrappedGameMode == .humanVsHuman {
            gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player Ones turn to move")
            playerOneTitleLabel.text = NSLocalizedString("Player One", comment: "Player One's Title")
            playerTwoTitleLabel.text = NSLocalizedString("Player Two", comment: "Player Two's Title")
        } else {
            gameStateLabel.text = NSLocalizedString("Your Turn", comment: "User's turn to move")
            playerOneTitleLabel.text = NSLocalizedString("You", comment: "User's score title")
            playerTwoTitleLabel.text = NSLocalizedString("Computer", comment: "Computers score title")
        }
        
    }
    
    private func setInitialScores() {
        playerOneScore = 0
        playerTwoScore = 0
    }

    @IBAction func squareTapped(_ sender: UIButton) {
        guard let square = getSquareFromButton(sender) else {
            print("Couldn't match square to button in squareTapped")
            return
        }
        play(square)
    }
    
    @IBAction func newGameTapped() {
        newGame()
        isItPlayerOnesTurn = true
        gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player One's turn to move")
    }
    
    @IBAction func backButtonTapped() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func play(_ square: Square) {
        guard let unwrappedGameMode = gameMode else {
            print("Game Mode was never intialised")
            return
        }
        
        var squareType: SquareType
        if isItPlayerOnesTurn {
            squareType = Constants.playerOneSquareType
        } else {
            squareType = Constants.playerTwoSquareType
        }
        
        gameState = playMove(square, squareType: squareType)
        updateViewForNew(square)

        if gameState == .nextMove {
            isItPlayerOnesTurn = !isItPlayerOnesTurn
            switch unwrappedGameMode {
            case .humanVsHuman:
                break
            case .easy:
                let computerPlayer = EasyAIPlayer(squareType: Constants.playerTwoSquareType)
                computersMove(computerPlayer)
            case .medium:
                let computerPlayer = MediumAIPlayer(squareType: Constants.playerTwoSquareType)
                computersMove(computerPlayer)
            case .impossible:
                let computerPlayer = ImpossibleAIPlayer(squareType: Constants.playerTwoSquareType)
                computersMove(computerPlayer)
            }
        }
    }
    
    func computersMove(_ computerPlayer: AIPlayer) {
        buttonsEnabled(false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.computerThinkTime) {
            let computerMove = computerPlayer.chooseMove(self.game.gameBoard)
            guard let square = computerMove else {
                print("Computer failed to make a move in computerMove")
                return
            }
            self.gameState = self.playMove(square, squareType: Constants.playerTwoSquareType)
            self.updateViewForNew(square)
            self.buttonsEnabled(true)
            if self.gameState == .nextMove {
                self.isItPlayerOnesTurn = !self.isItPlayerOnesTurn
            }
        }
    }
    
    func playMove(_ move: Square, squareType: SquareType) -> GameState {
        return game.play(move, squareType: squareType)
    }
    
    
    
    func updateViewForNew(_ square: Square) {
        guard let unwrappedGameMode = gameMode else {
            print("Update view failed as Game Mode was never intiated")
            return
        }
        guard let unwrappedGameState = gameState else {
            print("Game State wasn't set")
            return
        }
        switch unwrappedGameState {
        case .nextMove:
            drawOnSquare(square: square, isItPlayerOnesTurn: isItPlayerOnesTurn)
            if unwrappedGameMode == .humanVsHuman {
                if isItPlayerOnesTurn {
                    gameStateLabel.text = NSLocalizedString("Player Two's Turn", comment: "Player Two's turn to move")
                } else {
                    gameStateLabel.text = NSLocalizedString("Player One's Turn", comment: "Player One's turn to move")
                }
            } else {
                if isItPlayerOnesTurn {
                    gameStateLabel.text = NSLocalizedString("Computer's Turn", comment: "User's turn to move")
                } else {
                    gameStateLabel.text = NSLocalizedString("Your Turn", comment: "Computer's turn to move")
                }
            }
        case .gameBoardFull:
            drawOnSquare(square: square, isItPlayerOnesTurn: isItPlayerOnesTurn)
            gameStateLabel.text = NSLocalizedString("Draw!", comment: "Game was drawn")
        case .playerWins:
            drawOnSquare(square: square, isItPlayerOnesTurn: isItPlayerOnesTurn)
            if unwrappedGameMode == .humanVsHuman {
                if isItPlayerOnesTurn {
                    gameStateLabel.text = NSLocalizedString("Player One Wins!", comment: "Player One Won the game")
                    updateScore(player: .playerOne)
                } else {
                    gameStateLabel.text = NSLocalizedString("Player Two Wins!", comment: "Player Two Won the game")
                    updateScore(player: .playerTwo)
                }
            } else {
                if isItPlayerOnesTurn {
                    gameStateLabel.text = NSLocalizedString("You Win!", comment: "Player One Won the game")
                    updateScore(player: .playerOne)
                } else {
                    gameStateLabel.text = NSLocalizedString("Computer Beat You!", comment: "Player Two Won the game")
                    updateScore(player: .playerTwo)
                }
            }
        case .squareTaken:
        break // Don't need to do anything
        case .playerAlreadyWon:
        break // Don't need to do anything
        case .error:
            print("Error With GameState")
            return
        }
    }
    
    func newGame() {
        game.startNewGame()
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
    
    private func buttonsEnabled(_ isEnabled: Bool) {
        topLeftButton.isEnabled = isEnabled
        topButton.isEnabled = isEnabled
        topRightButton.isEnabled = isEnabled
        leftButton.isEnabled = isEnabled
        centreButton.isEnabled = isEnabled
        rightButton.isEnabled = isEnabled
        bottomLeftButton.isEnabled = isEnabled
        bottomButton.isEnabled = isEnabled
        bottomRightButton.isEnabled = isEnabled
    }
    
    private func getSquareFromButton(_ button: UIButton) -> Square? {
        var square: Square?
        switch button {
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
        }
        return square
    }
    
    private func drawOnSquare(square: Square, isItPlayerOnesTurn: Bool) {
        var image: UIImage
        if isItPlayerOnesTurn {
            image = #imageLiteral(resourceName: "Cross")
        } else {
            image = #imageLiteral(resourceName: "Nought")
        }
        switch square {
        case .topLeft:
            topLeftButton.setImage(image, for: .normal)
        case .top:
            topButton.setImage(image, for: .normal)
        case .topRight:
            topRightButton.setImage(image, for: .normal)
        case .left:
            leftButton.setImage(image, for: .normal)
        case .centre:
            centreButton.setImage(image, for: .normal)
        case .right:
            rightButton.setImage(image, for: .normal)
        case .bottomLeft:
            bottomLeftButton.setImage(image, for: .normal)
        case .bottom:
            bottomButton.setImage(image, for: .normal)
        case .bottomRight:
            bottomRightButton.setImage(image, for: .normal)
        }
    }
}
