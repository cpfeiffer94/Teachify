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
    
    @IBOutlet weak var gamelistTableView: UITableView!
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    let tabledelegate = GameDetailTableDelegate()
    let tabledatasource = GameDetailListDataSource()
    
    var myExercises : [TKExercise]? = nil
    
    override func viewDidLoad() {
        gamelistTableView.delegate = tabledelegate
        gamelistTableView.dataSource = tabledatasource
        
        print("View did Load!")
        
        super.viewDidLoad()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame(_:)), name: .launchGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setExercises(_:)), name: .exerciseSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setDetailedExercise(_:)), name: .setDetailedExercise, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
//    sets a detailed Document
    @objc func setDetailedExercise(_ notification: Notification){
        if let myExDic = notification.userInfo as Dictionary? {
            if let myExIndex = myExDic[0] as? Int {
                if let exercises = myExercises {
                    let gametyp = exercises[myExIndex].type
                    gameImage.image = gametyp.icon
                    gameDescriptionLabel.text = gametyp.description
                    gameTitleLabel.text = gametyp.name
                    print("new Exercise selected in CardDetail: \(gametyp.name) 🔝")
                }
            }
        }
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
    
//    sets the Game Detail according to the index of the selected Exercise Cell
    @objc func setExercises(_ notification:Notification) {
        if let myDictionary = notification.userInfo as Dictionary? {
            if let newExercises = myDictionary[0] as? [TKExercise] {
                    myExercises = newExercises
                    let gametyp = newExercises[0].type
                    gameImage.image = gametyp.icon
                    gameDescriptionLabel.text = gametyp.description
                    gameTitleLabel.text = gametyp.name
                    tabledatasource.setExercises(exc: newExercises)
                    gamelistTableView.reloadData()
                    gamelistTableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition(rawValue: 0)!)
            }
        }
    }
}
