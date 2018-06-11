//
//  ExcerciseCollectionViewDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExerciseCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var selectedClass = 0
    var selectedSubject : Int = 0 {
        didSet{
            selectedSubject = selectedSubject - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard TKModelSingleton.sharedInstance.downloadedClasses.count > selectedClass, TKModelSingleton.sharedInstance.downloadedClasses[selectedClass].subjects.count > selectedSubject else {print("Guard")
            return 0}
        print("Selected subject index = \(selectedSubject)")
        //case All
        if selectedSubject == -1 {
            return TKModelSingleton.sharedInstance.downloadedClasses.flatMap {$0.subjects}.count + 1
        }
        //case classes
        print("case Classes")
        return TKModelSingleton.sharedInstance.downloadedClasses[selectedClass].subjects[selectedSubject].documents.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
        //Item is last Item in VC
        if indexPath.item == collectionView.numberOfItems(inSection: 0)-1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "excerciseCell", for: indexPath)
        }
        if let cell = cell as? ExcerciseCollectionViewCell {
            // do Setup Stuff
            sampleSetup(for: cell, at: indexPath)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var cell : UICollectionReusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
        }
        
        return cell
    }
    
    
    func sampleSetup(for cell: ExcerciseCollectionViewCell, at indexPath: IndexPath){
        var documents : [TKDocument] = [TKDocument]()
        //case All set
        if selectedSubject == -1{
            documents = TKModelSingleton.sharedInstance.downloadedClasses[selectedClass].subjects.flatMap({$0.documents})
        }else{
            documents = TKModelSingleton.sharedInstance.downloadedClasses[selectedClass].subjects[selectedSubject].documents
        }
        
            let data = documents[indexPath.item]
            cell.excerciseTitle.text = data.name
            cell.dueDate.text = data.deadline?.description ?? "No due date set"
        let subject = TKModelSingleton.sharedInstance.downloadedClasses[selectedClass].subjects.first(where:{$0.subjectID == documents[indexPath.item].subjectID})
        cell.subjectTitle.text = subject?.name
            cell.backgroundColor = subject?.color.color
        
        
       
        
        
        
    }
    
    
}
