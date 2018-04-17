//
//  RoundAddCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class RoundAddCell: UICollectionViewCell {
    
    @IBOutlet var addLabel: UILabel!
    

}

class RoundAddCell2 : UICollectionViewCell {
    
    let addLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Add Class"
        return label
    }()
    
    let roundView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    let plusLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 80, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "+"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        addSubview(roundView)
        addSubview(addLabel)
        addSubview(plusLabel)
        
        addConstraints(withFormat: "H:|[v0]|", forViews: addLabel)
        addConstraints(withFormat: "V:[v0]-20-|", forViews: addLabel)
        addConstraints(withFormat: "V:|-16-[v0][v1]", forViews: roundView, addLabel)
        addConstraint(NSLayoutConstraint(item: roundView, attribute: .width, relatedBy: .equal, toItem: roundView, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: roundView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: plusLabel, attribute: .centerY, relatedBy: .equal, toItem: roundView, attribute: .centerY, multiplier: 1, constant: -5))
        addConstraints(withFormat: "H:|[v0]|", forViews: plusLabel)
        //addConstraint(NSLayoutConstraint(item: plusLabel, attribute: .centerY, relatedBy: .equal, toItem: roundView, attribute: .centerY, multiplier: 1, constant: 0))
       
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundView.layer.cornerRadius = roundView.frame.width/2
    }
    
}
