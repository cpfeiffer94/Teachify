//
//  ExcerciseCollectionViewDelegate.swift
//  Teachify
//
//  Created by Bastian Kusserow on 03.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExcerciseCollectionViewDelegate: NSObject,UICollectionViewDelegateFlowLayout {

    
    override init() {
       
        //UIMenuController.shared.menuItems = [UIMenuItem(title: "Share", action: #selector(test))]
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {

        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        //Method is never called explicit, ios only checks for existance
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let restWidth = calculateRestWidth(for: collectionView, layout: collectionViewLayout)
        return UIEdgeInsets(top: 20, left: restWidth/2, bottom: 0, right: restWidth/2)
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
