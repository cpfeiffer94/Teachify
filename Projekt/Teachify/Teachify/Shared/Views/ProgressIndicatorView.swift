//
//  ProgressIndicatorView.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ProgressIndicatorView: UIVisualEffectView{
    
    
    var actInd = UIActivityIndicatorView()
    var msg : String!
    let label = UILabel()
    
    
    init(msg: String) {
        super.init(effect: UIBlurEffect(style: .light))
        
        self.msg = msg
        // Make corners rounded and set background Color
        self.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.49, alpha: 0.5)
        layer.masksToBounds = true
        layer.cornerRadius = 8
        
        
    }
    
    /// Sets the Message that is displayed when the Progress Indicator is shown
    func setMessage(msg: String){
        self.msg = msg
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview{
            
            // Setting position of activityIndicator
            actInd.activityIndicatorViewStyle = .white
            let activityIndicatorSize : CGFloat = 40.0
            self.frame = CGRect(x: superview.frame.midX-100, y: superview.frame.midY - 30, width: 200, height: 60)
            actInd.frame = CGRect(x: self.bounds.origin.x + 6, y: self.bounds.origin.y + 10, width: activityIndicatorSize, height: activityIndicatorSize)
            
            // Adding Indicator to View
            //self.addSubview(actInd)
            self.contentView.addSubview(actInd)
            
            // Setting position and Font, etc.
            label.frame = CGRect(x: activityIndicatorSize-5, y: 0, width: self.frame.size.width - activityIndicatorSize, height: 60)
            label.text = msg
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.gray
            self.contentView.addSubview(label)
            //start animation the Indicator
            actInd.startAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Hides the ProgressIndicator View with an animation.
     * - Returns: Void
     */
    func hide()
    {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0
            
        }, completion: { finished in
            self.isHidden = true
        }
        )
    }
    
    /**
     * Shows the ProgressIndicatorView if it was hidden.
     If Progress Indicator wasn't hidden, nothing will happen.
     * - Returns: Void
     */
    func show()
    {
        self.alpha = 1
        self.isHidden = false
    }
    
}
