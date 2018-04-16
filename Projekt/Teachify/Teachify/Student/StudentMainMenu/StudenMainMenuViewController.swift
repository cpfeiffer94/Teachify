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
    
    
    override func viewDidLoad() {
        
        collectionDS = GameCollectionDataSource()
        collectionDel = GameCollectionDelegate()
        
        GameCollectionView.dataSource = collectionDS
        GameCollectionView.delegate = collectionDel
        super.viewDidLoad()
        
        
        let randomQuestionGenerator = RandomQuestionGenerator()
        
        //randomQuestionGenerator.generateGame(numberOfTasks: 3, lifes: 9)
        print("### Return: \(randomQuestionGenerator.generateGame(numberOfTasks: 3, lifes: 9))")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
