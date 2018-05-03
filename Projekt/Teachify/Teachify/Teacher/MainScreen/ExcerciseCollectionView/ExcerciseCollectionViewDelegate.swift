//
//  ExcerciseCollectionViewDelegate.swift
//  Teachify
//
//  Created by Bastian Kusserow on 03.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExcerciseCollectionViewDelegate: NSObject,UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let restWidth = calculateRestWidth(for: collectionView, layout: collectionViewLayout)
        return UIEdgeInsets(top: 20, left: restWidth/2, bottom: 0, right: restWidth/2)
        // }
        
        
        //return UIEdgeInsets.zero
    }
    
    
    
    private func calculateRestWidth(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return 0.0}
        let width = collectionView.frame.width
        let spacing = flowLayout.minimumInteritemSpacing
        
        let cell = flowLayout.itemSize

        let totalCellWidth = cell.width + spacing
        let restWidth = width.truncatingRemainder(dividingBy: totalCellWidth)

        return restWidth + spacing
    }
}
