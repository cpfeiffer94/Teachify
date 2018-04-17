//
//  ClassesCollectionViewDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCollectionViewDataSource: NSObject, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == collectionView.numberOfItems(inSection: 0)-1, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as? RoundAddCell2{
            //cell.addLabel.text = "Add Subject"
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath)
        
        return cell
    }
    
    
}
