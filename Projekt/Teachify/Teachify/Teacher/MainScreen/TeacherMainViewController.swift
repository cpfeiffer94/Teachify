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
    @objc let delegate = ClassesCollectionViewDelegate()
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
        addObserver(self, forKeyPath: #keyPath(delegate.selectedIndex), options: [], context: nil)
        
        setupExcerciseCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: .excerciseLoaded, object: nil)
        loadData()
        
        if let headerView = classesCollectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).first as? SegmentedControlHeaderView, let filterSegmentedControl = headerView.filterSegmentedControl {
            //do Stuff
        }
    
    }
    
    @objc func reloadTable(){
        print("Notified")
        DispatchQueue.main.async {[weak self] in
            self?.classesCollectionView.reloadData()
            self?.subjectCollectionView.collectionView.reloadData()
            self?.excerciseCollectionView.reloadData()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(delegate.selectedIndex) {
            print("Changed Index")
            subjectCollectionView.dataSource.selectedClass = delegate.selectedIndex
            subjectCollectionView.collectionView.reloadData()
        }
    }
    
    func loadData(){
        
        let fetchCtrl = TKFetchController(rank: .teacher)
        fetchCtrl.fetchAll(notificationName: .excerciseLoaded)
        
        
        
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


