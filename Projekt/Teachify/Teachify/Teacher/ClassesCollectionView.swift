//
//  ClassesCollectionView.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ClassesCollectionView: CenteredCollectionViewDelegate, UICollectionViewDataSource {
//    let classController : TKClassController!
//    
//    override init() {
//     classController = TKClassController()
//     }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var count = 0
//        classController.fetchDirectories(withFetchSortOptions: [.name]) { (classes, error) in
//         if let _ = error{
//         print("Error Fetching Classes")
//         }
//         count = classes.count
//         }
//        print("COUNT: \(count)")
//         return count + 1
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
        if indexPath.item != collectionView.numberOfItems(inSection: 0)-1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
        }
        return cell
    }
}
