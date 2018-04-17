//
//  ClassCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ClassCell: UICollectionViewCell {
    
    @IBOutlet var className: UILabel!
    @IBOutlet var rightImageView: UIImageView!  {
        didSet{
            rightImageView.layer.borderWidth = 1
            rightImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    @IBOutlet var middleImageView: UIImageView!{
        didSet{
            middleImageView.layer.borderWidth = 1
            middleImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    
    @IBOutlet var leftImageView: UIImageView!{
        didSet{
            leftImageView.layer.borderWidth = 1
            leftImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    
    override var isSelected: Bool {
        didSet{
            className.font = isSelected ? UIFont.boldSystemFont(ofSize: className.font.pointSize) : UIFont.systemFont(ofSize: className.font.pointSize)
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            className.font = isSelected ? UIFont.boldSystemFont(ofSize: className.font.pointSize) : UIFont.systemFont(ofSize: className.font.pointSize)
        }
    }
}
