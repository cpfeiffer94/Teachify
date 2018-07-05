//
//  SubjectCollectionViewDataSource.swift
//  Teachify
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseSubjectCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var subjects = [TKSubject]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSubjectReuseableCell", for: indexPath) as! AddSubjectReuseableCell
        cell.subjectName.text = subjects[indexPath.row].name
        let color = subjects[indexPath.row].color.color.withAlphaComponent(0.5)
        cell.backgroundColor = color
        return cell
    }
    

}
