//
//  ClassesCollectionViewDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var subjects : [TKSubject] = []
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allSubjectsCell", for: indexPath)
            //All Subjects Cell setup
            return cell
        }
        
        if indexPath.item == collectionView.numberOfItems(inSection: 0)-1, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as? RoundAddCell2{
            //Add Subject Cell Setup
            cell.addLabel.text = "Add Subject"
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! SubjectCell
        cell.setup(with: subjects[indexPath.item-1])
        
        return cell
    }
    
    
}
