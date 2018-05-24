//
//  SubjectCollectionViewCell.swift
//  Teachify
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet var subjectName: UILabel!
    
    @IBOutlet var subjectImage: UIImageView!{
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectImage.transform = CGAffineTransform(rotationAngle: rotateBy)
        }
    }
    
}
