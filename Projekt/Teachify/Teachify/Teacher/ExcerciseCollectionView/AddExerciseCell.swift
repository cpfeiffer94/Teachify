//
//  AddExerciseCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseCell: UICollectionViewCell {
    
    @IBOutlet var roundView: UIView! {
        didSet{
            roundView.layer.cornerRadius = roundView.bounds.width/2
            roundView.layer.borderColor = UIColor.white.cgColor
            roundView.layer.borderWidth = 2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        //roundView.layer.cornerRadius = roundView.bounds.width/2
        //roundView.layer.borderColor = UIColor.white.cgColor
        //roundView.layer.borderWidth = 1
        layer.cornerRadius = 20
    }
    
    
}
