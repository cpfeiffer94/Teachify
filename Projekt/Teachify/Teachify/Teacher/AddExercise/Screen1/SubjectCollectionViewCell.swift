//
//  SubjectCollectionViewCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var subjectName: UILabel!
    
    @IBOutlet var subjectImage: UIImageView!{
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectImage.transform = CGAffineTransform(rotationAngle: rotateBy)
        }
    }
    
}
