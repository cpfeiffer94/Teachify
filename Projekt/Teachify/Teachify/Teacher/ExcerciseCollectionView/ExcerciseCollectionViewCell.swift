//
//  ExcerciseCollectionViewCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExcerciseCollectionViewCell: UICollectionViewCell {
    @IBOutlet var subjectTitle: UILabel!
    @IBOutlet var excerciseTitle: UILabel!
    @IBOutlet var dueDate: UILabel!
    @IBOutlet var subjectImage: UIImageView! {
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectImage.transform = CGAffineTransform(rotationAngle: rotateBy)
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
        layer.cornerRadius = 20
    }
}
