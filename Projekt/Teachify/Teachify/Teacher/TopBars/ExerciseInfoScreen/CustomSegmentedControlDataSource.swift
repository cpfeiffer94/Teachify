//
//  CustomSegmentedControlDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 26.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class CustomSegmentedControlDataSource: NSObject, UICollectionViewDataSource {
    
    private let titles = ["DONE", "NOT DONE", "STATISTICS"]
    private let countTitles = ["Students", "Students", "% correct"]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segmentCell", for: indexPath)
        
        if let cell = cell as? SegmentCell {
            cell.layer.cornerRadius = 15
            cell.cellTitle.text = titles[indexPath.item]
            cell.countTitle.text = countTitles[indexPath.item]
        }
        
        
        return cell
    }
}
