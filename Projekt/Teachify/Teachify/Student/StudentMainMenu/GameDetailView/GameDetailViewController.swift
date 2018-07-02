//
//  GameInformationViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 02.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    let gameController : GameController = GameController()
    
    @IBOutlet weak var GamelistTableView: UITableView!
    
    @IBOutlet weak var GameImage: UIImageView!
    @IBOutlet weak var GameDescriptionLabel: UILabel!
    @IBOutlet weak var GameTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame(_:)), name: .launchGame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    Only launches the first Exercise in the Notification contained Dictionary
    @objc func launchGame(_ notification: Notification){
        if let myDictionary = notification.userInfo as Dictionary? {
            if let myExercise = myDictionary[0] as? TKExercise {
                gameController.resetInstanceForGame(game: myExercise.type)
                let gameVC = gameController.getViewControllerForGame(game: myExercise.type)
                self.present(gameVC,animated: true)
            }
        }
    }
    
    func setGameDetail(gametyp : TKExerciseType) {
        GameImage.image = gametyp.icon
        GameDescriptionLabel.text = gametyp.description
        GameTitleLabel.text = gametyp.name
    }
}
