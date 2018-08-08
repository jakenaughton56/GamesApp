//
//  GameModeMenuViewController.swift
//  TicTacToe
//
//  Created by Jake Mobile Dev on 7/8/18.
//  Copyright © 2018 JakeMobileDev. All rights reserved.
//

import UIKit

class GameModeMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var humanVsHumanButton: UIButton!
    @IBOutlet weak var easyModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeStrings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func localizeStrings() {
        menuTitleLabel.text = NSLocalizedString("Game Mode", comment: "Type of Game to play")
        humanVsHumanButton.setTitle(NSLocalizedString("Human Vs Human", comment: "Human plays another Human"), for: .normal)
        easyModeButton.setTitle(NSLocalizedString("Easy", comment: "Vs Computer in Easy Mode"), for: .normal)
    }
    
    @IBAction func gameModeTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        switch sender {
        case humanVsHumanButton:
            vc.gameMode = .humanVsHuman
        case easyModeButton:
            vc.gameMode = .easy
        default:
            print("Error: Button is not accosiated with a game mode")
            return
        }
        self.present(vc, animated: true, completion: nil)
    }

}
