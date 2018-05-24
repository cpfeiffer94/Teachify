//
//  ClassesCollectionView.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ClassesCollectionViewDelegate: CenteredCollectionViewDelegate {
    
    @objc dynamic var selectedIndex = 0

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        selectedIndex = indexPath.item
    }
}
