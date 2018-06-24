//
//  GameInformationViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 02.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    let gameController : GameLaunchController = GameLaunchController()
    
    @IBOutlet weak var GamelistTableView: UITableView!
    
    let 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame), name: .launchGame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func launchGame(){
        gameController.resetInstanceForGame(game: .mathpiano)
        let gameVC = gameController.getViewControllerForGame(game: .mathpiano)
        self.present(gameVC,animated: true)
    }
}
