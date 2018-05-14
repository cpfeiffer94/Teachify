//
//  SegmentCell3.swift
//  Teachify
//
//  Created by Bastian Kusserow on 03.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
@IBDesignable
class SegmentCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var count: UILabel!
    
    @IBOutlet var countTitle: UILabel!
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
