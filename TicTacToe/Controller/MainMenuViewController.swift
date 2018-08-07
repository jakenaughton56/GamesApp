//
//  MainMenuViewController.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 6/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeStrings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func localizeStrings() {
        menuTitleLabel.text = NSLocalizedString("Tic Tac Toe", comment: "Tic Tac Toe is the name of the app")
        startGameButton.setTitle(NSLocalizedString("Start Game", comment: "Start the game"), for: .normal)
    }
    
}
