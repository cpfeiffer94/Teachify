//
//  SubjectCollectionViewDelegate.swift
//  Teachify
//
//  Created by Bastian Kusserow on 25.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit


class SubjectCollectionViewDelegate : CenteredCollectionViewDelegate {
    
    private let delegate : CVIndexChanged!
    private var currentSelectedCell = 0
    var callback : ItemSelectedCallback?
    
    init(delegate: CVIndexChanged){
        self.delegate = delegate
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedCell = indexPath.item
        callback?.didSelectItem(at: currentSelectedCell)
        delegate.didChangeSubjectIndex(to: indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        callback?.didSelectItem(at: currentSelectedCell)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        callback?.didSelectItem(at: currentSelectedCell)
    }
}
