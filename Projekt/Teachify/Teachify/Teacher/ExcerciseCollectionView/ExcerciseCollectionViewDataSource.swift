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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "excerciseCell", for: indexPath)
        
        if let cell = cell as? ExcerciseCollectionViewCell {
            // do Setup Stuff
            switch indexPath.item {
            case 0: cell.backgroundColor = .teacherBlue
            case 1: cell.backgroundColor = .teacherRed
            case 2: cell.backgroundColor = .teacherGreen
            default: cell.backgroundColor = .lightGray
            }
        }
        
        return cell
    }
    
    
    
}
