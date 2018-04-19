//
//  CustomSegmentedControl.swift
//  Teachify
//
//  Created by Bastian Kusserow on 17.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegmentedControl: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var action : (() -> Void)?
    var selectedSegmentIndex = 0
    
    func addTarget(action: @escaping () -> Void){
        self.action = action
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segmentCell", for: indexPath)
        cell.layer.cornerRadius = 15

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let action = action {
            action()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        selectedSegmentIndex = indexPath.item
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    
    private func setup(){
        backgroundColor = .teacherLightBlue
        
        self.dataSource = self
        self.delegate = self
        self.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4, height: collectionView.bounds.height*4/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            let spacing = self.collectionView(self, layout: layout, minimumInteritemSpacingForSectionAt: 0)
            
            return UIEdgeInsets(top: 0, left: collectionView.bounds.width/8 - 10 - spacing, bottom: 0, right: collectionView.bounds.width/8 - spacing)
        }
        return UIEdgeInsets.zero
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    
}
