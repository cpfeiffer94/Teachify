//
//  StudenMainMenuViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 08.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class StudentMainMenuViewController: UIViewController {
    @IBOutlet weak var GameCollectionView: UICollectionView!
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var openExercisesLabel: UILabel!
    @IBOutlet weak var solvedExercisesLabel: UILabel!
    @IBOutlet weak var TeachifyProgressLabel: UILabel!
    
    var collectionDS: UICollectionViewDataSource!
    var collectionDel: UICollectionViewDelegate!
    let gamedwnldctrl = TKFetchController()
    
    override func viewDidLoad() {
        
        print(GameEnum.mathPiano)
        collectionDS = GameCollectionDataSource()
        collectionDel = GameCollectionDelegate()
        
        GameCollectionView.dataSource = collectionDS
        GameCollectionView.delegate = collectionDel
        
        gamedwnldctrl.fetchDatabase(aRank: TKRank.teacher)
        
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleView.text = "Games"
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        titleView.font = UIFont.systemFont(ofSize: 33, weight: .black)
        navigationItem.titleView = titleView
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame), name: .startGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAvailableGames), name: .reloadGameCards, object: nil)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
    }
    
    @IBAction func GameModeChangeAction(_ sender: Any) {
    }
    
    @objc func launchGame(){
        let gameVC = MathPianoGameViewController()
        self.present(gameVC,animated: true)
    }
    
    @objc func reloadAvailableGames(){
        GameCollectionView.reloadData()
    }
    
    
}
