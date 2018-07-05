//
//  GameCollectionViewDataSource.swift
//  Teachify
//
//  Created by Philipp on 01.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let games = ["FeedMe", "Piano", "Flappy"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TKExerciseType.allExerciseTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSubjectReuseableCell", for: indexPath) as! AddSubjectReuseableCell
        cell.backgroundColor = cell.backgroundColor?.withAlphaComponent(0.5)
        cell.subjectName.text = TKExerciseType.allExerciseTypes[indexPath.item].name
        
        return cell
    }

    
}
