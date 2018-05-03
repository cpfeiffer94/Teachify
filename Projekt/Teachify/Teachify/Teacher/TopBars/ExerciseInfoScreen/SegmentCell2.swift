//
//  SegmentCell2.swift
//  Teachify
//
//  Created by Bastian Kusserow on 03.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SegmentCell2: UICollectionViewCell {
    
    @IBOutlet var cellTitle: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.teacherSelectedLightBlue : UIColor.teacherLightBlue
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.teacherSelectedLightBlue : UIColor.teacherLightBlue
        }
    }
}
