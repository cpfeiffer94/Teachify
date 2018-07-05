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
    @IBOutlet var dueDate: UILabel!{
        didSet{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            dueDate.text = formatter.date(from: dueDate.text!)?.description
        }
    }
    @IBOutlet var subjectImage: UIImageView! {
        didSet{
            let rotateBy = CGFloat(Measurement(value: -30, unit: UnitAngle.degrees).converted(to: .radians).value)
            subjectImage.transform = CGAffineTransform(rotationAngle: rotateBy)
        }
    }
    
    //MARK: Variables
    var subject: TKSubject!
    var delegate : CellMenuDelegate?
    
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
        if action == #selector(test) || action == #selector(delete) {
            return true
        }
        return false
    }
    

    
    
    @objc func test(){
        let shareCtrl = TKShareController(view: UIApplication.shared.keyWindow!.visibleViewController()!.view)
        shareCtrl.createCloudSharingController(forSubject: subject, withShareOption: .addParticipant) { (shareVC, error) in
            if error != nil {
                print("Error creating Share VC")
                return
            }
            
            UIApplication.shared.keyWindow!.visibleViewController()!.present(shareVC!, animated: true)
        }
    }

    override func delete(_ sender: Any?) {
        delegate?.delete(cell: self)
    }
    
}

protocol CellMenuDelegate {
    var collectionView: UICollectionView!{get}
    func delete(cell: UICollectionViewCell)
}
