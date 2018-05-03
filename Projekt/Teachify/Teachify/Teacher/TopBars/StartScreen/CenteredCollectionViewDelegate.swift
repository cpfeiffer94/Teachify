//
//  CenteredCollectionView.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class CenteredCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout{

    private var cellSize : CGFloat!
    private var currentSelectedCell = 0
    var callback : ItemSelectedCallback?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout, let cellSize=cellSize{
            let cellWidth = cellSize//flowLayout.itemSize.width

            let spacing = flowLayout.minimumLineSpacing
            let count = CGFloat(collectionView.numberOfItems(inSection: 0))
            let width = count * cellWidth + (count-1)*spacing
            var inset = collectionView.frame.width - width
            inset = max(inset, 0.0)
            return UIEdgeInsets(top: 0, left: inset/2, bottom: 0, right:inset/2)
        }
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize = collectionView.frame.height
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedCell = indexPath.item
        callback?.didSelectItem(at: currentSelectedCell)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        callback?.didSelectItem(at: currentSelectedCell)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        callback?.didSelectItem(at: currentSelectedCell)
    }
    
}
