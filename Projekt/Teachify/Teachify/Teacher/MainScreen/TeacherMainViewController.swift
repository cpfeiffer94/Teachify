//
//  TeacherMainViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class TeacherMainViewController: UIViewController {

    @IBOutlet var classesCollectionView: UICollectionView!
    let dataSource = ClassesCollectionViewDataSource()
    let delegate = ClassesCollectionViewDelegate()
    var titleView : UILabel!
    
    
    @IBOutlet var subjectCollectionView: SubjectCollectionView!
    
    @IBOutlet var excerciseCollectionView: UICollectionView!
    let excerciseDataSource = ExerciseCollectionViewDataSource()
    let excerciseDelegate = ExcerciseCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleView.text = "Excercises"
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        //titleView.font = UIFont.systemFont(ofSize: 48)
        navigationItem.titleView = titleView
        //navigationItem.prompt = " "
        navigationController?.navigationBar.barTintColor = .barBlue

    
        
        //get Rid of Background Shaodw Image in iOS 10
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
       //classesCollectionView.register(RoundAddCell2.self, forCellWithReuseIdentifier: "addCell2")
        classesCollectionView.dataSource = dataSource
        classesCollectionView.delegate = delegate
        setupExcerciseCollectionView()
        loadData()
        
        if let headerView = classesCollectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).first as? SegmentedControlHeaderView, let filterSegmentedControl = headerView.filterSegmentedControl {
            //do Stuff
        }
    
    }
    
    func loadData(){
        
//        let fetchCtrl = TKFetchController()
 //       fetchCtrl.fetchDatabase(aRank: TKRank.teacher)
        
        var classController = TKClassController()
        classController.initialize(withRank: .teacher) { (_) in}
        classController.fetchClasses(withFetchSortOptions: [.name]) { [unowned self, weak dataSource = dataSource] (classes, error) in
            if let error = error {
                print("Error fetching classes \(error)")
            }
            dataSource?.classes = classes

            DispatchQueue.main.async {
                self.classesCollectionView.reloadData()
                self.classesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
            }
            var subjectController = TKSubjectController()
            subjectController.initialize(withRank: .teacher, completion: { (sucess) in
                print("Init \(sucess)")
            })

            subjectController.fetchSubject(forClass: self.dataSource.classes[1], withFetchSortOptions: [.name]) { [unowned self] (subjects, error) in
                if let error = error {
                    print("Error fetching Subjects \(error)")
                }

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
        excerciseCollectionView.delegate = excerciseDelegate

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .barBlue
    }
  
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //When device is rotated, the layout of te cv should be updated
        excerciseCollectionView.collectionViewLayout.invalidateLayout()
        classesCollectionView.collectionViewLayout.invalidateLayout()
        subjectCollectionView.collectionView.collectionViewLayout.invalidateLayout()
        subjectCollectionView.collectionView.layoutIfNeeded()
        subjectCollectionView.didSelectItem(at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subjectCollectionView.didSelectItem(at: 0)
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.titleView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
   

   

}


