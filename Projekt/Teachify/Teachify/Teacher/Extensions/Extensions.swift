//
//  Extensions.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let teacherBlue = UIColor.rgb(red: 48, green: 98, blue: 165)
    static let teacherRed = UIColor.rgb(red: 171, green: 26, blue: 64)
    static let teacherGreen = UIColor.rgb(red: 137, green: 201, blue: 98)
    
}

extension UIView {
    
    func addConstraints(withFormat format: String, forViews views : UIView...){
        
        var viewDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views:viewDictionary))
    }
}
