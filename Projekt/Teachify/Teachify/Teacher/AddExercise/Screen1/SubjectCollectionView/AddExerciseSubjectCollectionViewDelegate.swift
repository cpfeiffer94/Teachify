//
//  SubjectCollectionViewDelegate.swift
//  Teachify
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseSubjectCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var delegate : CVChangedSubject!
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource = collectionView.dataSource as! AddExerciseSubjectCollectionViewDataSource
        let selectedSubject = dataSource.subjects[indexPath.row]
        delegate.didChangeSubject(to: selectedSubject)
    }
}


//MARK:  - LayoutDelegate
extension AddExerciseSubjectCollectionViewDelegate: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
