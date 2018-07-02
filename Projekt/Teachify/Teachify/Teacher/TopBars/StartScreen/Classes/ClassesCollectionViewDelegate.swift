//
//  ClassesCollectionView.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ClassesCollectionViewDelegate: CenteredCollectionViewDelegate {
    
    private let delegate: CVIndexChanged
    
    init(delegate: CVIndexChanged){
        self.delegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //super.collectionView(collectionView, didSelectItemAt: indexPath)
        //if let _ = collectionView.cellForItem(at: indexPath) as? ClassCell{
            delegate.didChangeClassIndex(to: indexPath.item)
        //}
    }
    

}
