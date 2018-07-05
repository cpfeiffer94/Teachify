//
//  FHHSwiftyBehaviour.swift
//  Teachify
//
//  Created by Bastian Kusserow on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit


class FHHSwiftyBehaviour: UIControl {
    //! object that this controller life will be bound to
    var timer : Timer!
    
    @IBOutlet weak var owner: AnyObject! {
        willSet{
            //if !self.owner.isEqual(owner){
            if let owner = self.owner {
                releaseLifetime(fromObject: owner)
               
            }
            //}
        }
        didSet{
            bindLifetime(toObject: owner)
        }
    }

    

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Init frame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder")
    }
    
    func setOwner(_ owner: AnyObject) {
        
        if !self.owner!.isEqual(owner) {
            releaseLifetime(fromObject: self.owner)
            self.owner = owner
            bindLifetime(toObject: self.owner)
        }
    }
    
    func releaseLifetime(fromObject: AnyObject){
        //convert self to unmanaged object
        let anUnmanaged = Unmanaged<FHHSwiftyBehaviour>.passUnretained(self)
        //get raw data pointer
        let opaque = anUnmanaged.toOpaque()
        //convert to Mutable to match Swift safe type check
        let voidSelf = UnsafeMutableRawPointer(opaque)
        
        objc_setAssociatedObject(self, voidSelf, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    func bindLifetime(toObject: AnyObject){
        //convert self to unmanaged object
        let anUnmanaged = Unmanaged<FHHSwiftyBehaviour>.passUnretained(self)
        //get raw data pointer
        let opaque = anUnmanaged.toOpaque()
        //convert to Mutable to match Swift safe type check
        let voidSelf = UnsafeMutableRawPointer(opaque)
        
        objc_setAssociatedObject(self, voidSelf, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    deinit {
        print("DEINITIALIZED")
    }

}





class FHHSwiftyTextValidationBehaviour: FHHSwiftyBehaviour {
    @IBOutlet var rules: [FHHSwiftyTextValidationRule]!
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.addTarget(self, action: #selector(updateValidation), for: .editingChanged)
        }
    }
    @IBOutlet var controls: [UIControl]!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBInspectable var invalidTextColor: UIColor?
    let validTextColor : UIColor = .blue
    
    convenience init(rules: [FHHSwiftyTextValidationRule]?) {
        self.init()
        self.rules = rules
    }
    
    
    @objc func updateValidation() {

        let isValid: Bool = validateText()
        if let barButton = barButton{
        barButton.isEnabled = isValid
        }
        for control in controls {
            control.isEnabled = isValid
             print("Update Validation")
        }
       
        if let invalidTextColor = invalidTextColor {
            textField?.textColor = isValid ? validTextColor : invalidTextColor
        }
        
        sendActions(for: .valueChanged)
    }

    
    func validateText() -> Bool {
        let text = textField?.text
        let failingRules = self.rules.filter({!$0.evaluate(with: text) })
        
        return failingRules.count == 0

    }
}

@objc protocol FHHSwiftyTextValidationRule {
    func evaluate(with string: String?) -> Bool
}


class FHHSwiftyLengthRule : NSObject, FHHSwiftyTextValidationRule{
    @IBInspectable var minCharacterCount: Int = 2 {
        didSet{
            self.range = NSMakeRange(minCharacterCount, maxCharacterCount-minCharacterCount)
        }
    }
    @IBInspectable var maxCharacterCount: Int = 20{
        didSet{
            self.range = NSMakeRange(minCharacterCount, maxCharacterCount-minCharacterCount)
        }
    }

    
    
    
    func evaluate(with string: String?) -> Bool {
        return string!.count >= range.lowerBound && string!.count <= range.upperBound

    }
    
    override init() {
        self.range = NSMakeRange(minCharacterCount, maxCharacterCount-minCharacterCount)
    }
    
    var range = NSRange()
    
    convenience init(range: NSRange) {
        self.init()
        self.range = range
    }
}














