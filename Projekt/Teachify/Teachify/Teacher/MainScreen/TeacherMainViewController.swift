//
//  TeacherMainViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import CloudKit

class TeacherMainViewController: UIViewController, CVIndexChanged {

    @IBOutlet var   classesCollectionView: UICollectionView!
    let             dataSource = ClassesCollectionViewDataSource()
    @objc var       delegate : ClassesCollectionViewDelegate!
    var             titleView : UILabel!
    
    
    @IBOutlet var subjectCollectionView: SubjectCollectionView!
    var subjectDelegate : SubjectCollectionViewDelegate!
    
    @IBOutlet var excerciseCollectionView: UICollectionView!
    let excerciseDataSource = ExerciseCollectionViewDataSource()
    let excerciseDelegate = ExcerciseCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleView.text = "Excercises"
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        navigationItem.titleView = titleView
        navigationController?.navigationBar.barTintColor = .barBlue
        
//        CKContainer.default().fetchUserRecordID { (recordId, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            print(recordId)
//            CKContainer.default().discoverUserIdentity(withUserRecordID: recordId!, completionHandler: { (identity, error) in
//                if let error = error {
//                    print(error)
//                }
//                print(identity?.lookupInfo?.emailAddress)
//                self.navigationItem.prompt = identity?.lookupInfo?.emailAddress
//            })
//        }
        //get Rid of Background Shaodw Image in iOS 10
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        classesCollectionView.dataSource = dataSource
        delegate = ClassesCollectionViewDelegate(delegate: self)
        classesCollectionView.delegate = delegate
        
        subjectDelegate = SubjectCollectionViewDelegate(delegate: self)
        subjectCollectionView.delegate = subjectDelegate
        
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
       // if keyPath == #keyPath(delegate.selectedIndex) {
            print("Changed Index")
       //     subjectCollectionView.dataSource.selectedClass = delegate.selectedIndex
            TKModelSingleton.sharedInstance.downloadedClasses[0].subjects.append(TKSubject(name: "A Test name", color: TKColor.yellow))
            //subjectCollectionView.collectionView.reloadData()
            subjectCollectionView.collectionView.insertItems(at: [IndexPath(row: 1, section: 0)])
            subjectCollectionView.collectionView.collectionViewLayout.invalidateLayout()
            subjectCollectionView.collectionView.layoutIfNeeded()
            subjectCollectionView.didSelectItem(at: 0)
      //  }
    }
    
    func didChangeClassIndex(to: Int) {
        print("changed Index")
        subjectCollectionView.dataSource.selectedClass = to
        excerciseDataSource.selectedClass              = to
        subjectCollectionView.collectionView.reloadData()
        subjectCollectionView.collectionView.collectionViewLayout.invalidateLayout()
        subjectCollectionView.collectionView.layoutIfNeeded()
        subjectCollectionView.didSelectItem(at: 0)
    }
    
    func didChangeSubjectIndex(to: Int) {
        print("Changed subject Index")
        excerciseDataSource.selectedSubject = to
        excerciseCollectionView.reloadData()
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


protocol CVIndexChanged {
    func didChangeClassIndex(to: Int)
    func didChangeSubjectIndex(to: Int)
}

