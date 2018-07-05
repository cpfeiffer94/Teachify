//
//  SubjectCell2.swift
//  Teachify
//
//  Created by Bastian Kusserow on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class SubjectCell: UICollectionViewCell {
    
    
    var delegate : CellMenuDelegate?
    
    private func setupGestureRecognizer(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(openMenu(_:)))
        gestureRecognizer.minimumPressDuration = 1.0
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func openMenu(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let actionSheet = UIAlertController(title: "Aktionen", message: "Wollen Sie die Klasse wirklich löschen?", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Löschen", style: .destructive, handler: { [unowned self] (action) in
                self.delegate?.delete(cell: self)
            }))
            
            actionSheet.popoverPresentationController?.sourceView = contentView
            actionSheet.popoverPresentationController?.sourceRect=contentView.frame
            UIApplication.shared.keyWindow?.visibleViewController()?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
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
        setup()
        setupGestureRecognizer()
    }
    
    func setup(with subject : TKSubject){
        subjectLabel.text = subject.name
        background.backgroundColor = subject.color.color
    }
    
    fileprivate func setup(){
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
            //iconView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 55, green: 105, blue: 182)
            iconView.tintColor = UIColor.white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            //iconView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 55, green: 105, blue: 182)
            iconView.tintColor = UIColor.white
        }
    }
    
}

class AllSubjectsCell : SubjectCell {
    
    let secondBg : UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = .teacherBlue
        return view
    }()
    
    let thirdBg : UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = .teacherRed
        return view
    }()
    
    override func setup() {
        
        
        addSubview(thirdBg)
        addSubview(secondBg)
        addSubview(background)
        addSubview(iconView)
        addSubview(subjectLabel)
        addSubview(iconView)
        
        addConstraints(withFormat: "H:|[v0]|", forViews: subjectLabel)
        addConstraints(withFormat: "V:|-16-[v0][v1]-20-|", forViews: background, subjectLabel)
        addConstraints(withFormat: "V:|-16-[v0][v1]-20-|", forViews: secondBg, subjectLabel)
        addConstraints(withFormat: "V:|-16-[v0][v1]-20-|", forViews: thirdBg, subjectLabel)
        addConstraints(withFormat: "H:|-16-[v0]", forViews: background)
        addConstraints(withFormat: "H:[v0]-16-|", forViews: thirdBg)
        addConstraint(NSLayoutConstraint(item: secondBg, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: background, attribute: .width, relatedBy: .equal, toItem: background, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: secondBg, attribute: .width, relatedBy: .equal, toItem: secondBg, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thirdBg, attribute: .width, relatedBy: .equal, toItem: thirdBg, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraints(withFormat: "V:[v0(28)]", forViews: iconView)
        addConstraints(withFormat: "H:[v0(28)]", forViews: iconView)
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: background, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: background, attribute: .centerY, multiplier: 1, constant: 0))
        
        subjectLabel.text = "All"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        secondBg.layer.cornerRadius = secondBg.frame.width/2
        thirdBg.layer.cornerRadius = thirdBg.frame.width/2
    }
}




























