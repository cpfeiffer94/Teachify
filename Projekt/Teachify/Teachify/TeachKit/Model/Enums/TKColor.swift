//
//  TKColor.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit

enum TKColor {
    case black
    case red
    case yellow
    
    var color: UIColor {
        switch self {
        case .black: return UIColor.black
        case .red: return UIColor.red
        case .yellow: return UIColor.yellow
        }
    }
    
    static let allColors: [TKColor] = [TKColor.black,
                                       .red,
                                       .yellow]
    
    var tkCloudKey: String {
        switch self {
        case .black: return "black"
        case .red: return "red"
        case .yellow: return "yellow"
        }
    }
}
