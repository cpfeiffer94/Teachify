//
//  SubjectCollectionViewCell.swift
//  Teachify
//
//  Created by Philipp on 24.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddSubjectReuseableCell: UICollectionViewCell {
    
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var subjectIcon: UIImageView!{
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectIcon.transform = CGAffineTransform(rotationAngle: rotateBy)

        }
        
    }
    
    
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? backgroundColor?.withAlphaComponent(1) : backgroundColor?.withAlphaComponent(0.5)
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isSelected ? backgroundColor?.withAlphaComponent(1) : backgroundColor?.withAlphaComponent(0.5)
        }
    }
    
}
