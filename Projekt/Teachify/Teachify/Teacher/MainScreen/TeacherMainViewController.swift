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
    let dataSource = ClassesCollectionViewDataSource()
    let delegate = ClassesCollectionViewDelegate()
    
    
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
        navigationController?.navigationBar.barTintColor = .barBlue

    
        
        //get Rid of Background Shaodw Image in iOS 10
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        collectionView.register(RoundAddCell2.self, forCellWithReuseIdentifier: "addCell2")
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        setupExcerciseCollectionView()
        loadData()
        
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).first as? SegmentedControlHeaderView, let filterSegmentedControl = headerView.filterSegmentedControl {
            //do Stuff
        }
    
    }
    
    func loadData(){
        let classController = TKClassController()
        classController.fetchClasses(withFetchSortOptions: [.name]) { [unowned self, weak dataSource = dataSource] (classes, error) in
            if let error = error {
                print("Error fetching classes \(error)")
            }
            dataSource?.classes = classes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
            }
                let subjectController = TKSubjectController()
                print(self.dataSource.classes)
                subjectController.fetchSubject(forClass: self.dataSource.classes[0], withFetchSortOptions: [.name]) { [unowned self] (subjects, error) in
                    if let error = error {
                        print("Error fetching Subjects \(error)")
                    }
                    print("SUBJECTSCOUNT: \(subjects.count)")
                    self.subjectCollectionView.dataSource.subjects = subjects
                    DispatchQueue.main.async {
                        self.subjectCollectionView.collectionView.reloadData()
                        self.subjectCollectionView.layoutIfNeeded()
                        self.subjectCollectionView.didSelectItem(at: 0)
                        

                }
            }
            
        }
        
        
        
    }
    
    func setupExcerciseCollectionView(){
        
        excerciseCollectionView.dataSource = excerciseDataSource

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .barBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subjectCollectionView.didSelectItem(at: 0)
    }
   

   

}
