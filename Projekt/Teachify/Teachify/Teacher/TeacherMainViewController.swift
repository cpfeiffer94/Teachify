//
//  TeacherMainViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class TeacherMainViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    let dataSource = ClassesCollectionView()
    
    @IBOutlet var subjectCollectionView: SubjectCollectionView!
    
    @IBOutlet var excerciseCollectionView: UICollectionView!
    let excerciseDataSource = ExerciseCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleView.text = "Excercises"
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        titleView.font = UIFont.systemFont(ofSize: 48)
        navigationItem.titleView = titleView
        navigationItem.prompt = " "
    
        
        //get Rid of Background Shaodw Image in iOS 10
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        collectionView.register(RoundAddCell2.self, forCellWithReuseIdentifier: "addCell2")
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        setupExcerciseCollectionView()
        
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).first as? SegmentedControlHeaderView, let filterSegmentedControl = headerView.filterSegmentedControl {
            //do Stuff
        }
    
    }
    
    func setupExcerciseCollectionView(){
        
        excerciseCollectionView.dataSource = excerciseDataSource

    }
    
    override func viewDidAppear(_ animated: Bool) {
        subjectCollectionView.didSelectItem(at: 0)
    }
   

   

}
