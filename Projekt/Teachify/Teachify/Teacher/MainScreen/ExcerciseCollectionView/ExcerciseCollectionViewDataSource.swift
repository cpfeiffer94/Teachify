//
//  ExcerciseCollectionViewDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExerciseCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
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
    
    
    func sampleSetup(for cell: UICollectionViewCell, at indexPath: IndexPath){
        switch indexPath.item {
        case 0: cell.backgroundColor = .teacherBlue
        case 1: cell.backgroundColor = .teacherRed
        case 2: cell.backgroundColor = .teacherGreen
        default: cell.backgroundColor = .lightGray
        }
    }
    
    
}
