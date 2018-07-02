//
//  ClassesCollectionViewDataSource.swift
//  Teachify
//
//  Created by Bastian Kusserow on 26.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit



class ClassesCollectionViewDataSource: NSObject, UICollectionViewDataSource, CellMenuDelegate {
    var collectionView: UICollectionView!
    
    func delete(cell: UICollectionViewCell) {
        var ctrl = TKClassController()
        ctrl.initialize(withRank: .teacher) { [unowned self] (_) in
            if let indexPath = self.collectionView.indexPath(for: cell){
                let aClass = TKModelSingleton.sharedInstance.downloadedClasses.remove(at: indexPath.item)
                DispatchQueue.main.async{
                    ctrl.delete(tkClass: aClass, completion: { (error) in
                        DispatchQueue.main.async{
                            self.collectionView.deleteItems(at: [indexPath])
                        }
                    })
                }
            }
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TKModelSingleton.sharedInstance.downloadedClasses.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item != collectionView.numberOfItems(inSection: 0)-1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ClassCell
            self.collectionView = collectionView
            cell?.delegate = self
            cell?.className.text = TKModelSingleton.sharedInstance.downloadedClasses[indexPath.item].name
           return cell!
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
            return cell
        }
        
    }
}
