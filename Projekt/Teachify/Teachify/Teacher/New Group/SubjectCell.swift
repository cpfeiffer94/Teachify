//
//  SubjectCell2.swift
//  Teachify
//
//  Created by Bastian Kusserow on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCell: UICollectionViewCell {
    
    let background : UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = UIColor.rgb(red: 137, green: 201, blue: 98)
        return view
    }()
    
    let iconView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "testTube").withRenderingMode(.alwaysTemplate)
        return iv
    }()
    
    let subjectLabel : UILabel = {
        let label = UILabel()
        label.text = "Science"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(subjectLabel)
        
       //Height & Width Constraint iconView
        addConstraints(withFormat: "H:[v0(28)]", forViews: iconView)
        addConstraints(withFormat: "V:[v0(28)]", forViews: iconView)
        //Left & Right Constriant SubjectLabel
        addConstraints(withFormat: "H:|[v0]|", forViews: subjectLabel)
        //Bottom Constriant subjectLabel
        addConstraints(withFormat: "V:[v0]-20-|", forViews: subjectLabel)
        
        //Center iconView X & Y
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: background, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: background, attribute: .centerY, multiplier: 1, constant: 0))
        
        //Center Background X
        addConstraint(NSLayoutConstraint(item: background, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Top Background
        addConstraint(NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 8))
        
        //bottom Background to SubjectLabel
        addConstraint(NSLayoutConstraint(item: subjectLabel, attribute: .topMargin, relatedBy: .equal, toItem: background, attribute: .bottom, multiplier: 1, constant: 8))
        
        //Aspect Ratio Background
        addConstraint(NSLayoutConstraint(item: background, attribute: .height, relatedBy: .equal, toItem: background, attribute: .width, multiplier: 1, constant: 0))
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.layer.cornerRadius = background.frame.width/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override var isHighlighted: Bool {
        didSet {
            iconView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 55, green: 105, blue: 182)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 55, green: 105, blue: 182)
        }
    }
    
}
