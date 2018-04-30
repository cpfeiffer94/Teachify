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
    
    var collectionDS: UICollectionViewDataSource!
    var collectionDel: UICollectionViewDelegate!
    let gamedwnldctrl = TKFetchController()

    
    
    override func viewDidLoad() {
        
        collectionDS = GameCollectionDataSource()
        collectionDel = GameCollectionDelegate()
        
        GameCollectionView.dataSource = collectionDS
        GameCollectionView.delegate = collectionDel
        
//        gamedwnldctrl.addGame(name: "Mathekniffel", typ: "Mathe", deadline: Date.init(), subject: "Mathematik", description: "Test dich in dem spannenden Mathespiel", difficulty: "Mittel")
        
        gamedwnldctrl.fetchDatabase()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame), name: .startGame, object: nil)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
    }
    
    @objc func launchGame(){
        let gameVC = GameViewController()
        self.present(gameVC,animated: true)
    }
    
    
}
