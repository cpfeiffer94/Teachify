//
//  ExcerciseCollectionViewCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExcerciseCollectionViewCell: UICollectionViewCell {
    //MARK: IBOutlets
    @IBOutlet var subjectTitle: UILabel!
    @IBOutlet var excerciseTitle: UILabel!
    @IBOutlet var dueDate: UILabel!
    @IBOutlet var subjectImage: UIImageView! {
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectImage.transform = CGAffineTransform(rotationAngle: rotateBy)
        }
    }
    
    //MARK: Variables
    var subject: TKSubject!
    
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
        UIMenuController.shared.menuItems = [UIMenuItem(title: "Share", action: #selector(test))]
    }
    
    override var canBecomeFirstResponder: Bool {return true}
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(test) {
            return true
        }
        return false
    }
    

    
    @objc func test(){
        let shareCtrl = TKShareController(view: UIApplication.shared.keyWindow!.visibleViewController()!.view)
        shareCtrl.createCloudSharingController(forSubject: subject, withShareOption: .addParticipant) { (shareVC, error) in
            if let error = error {
                print("Error creating Share VC")
                return
            }
            UIApplication.shared.keyWindow!.visibleViewController()!.present(shareVC!, animated: true)
        }
    }
}
