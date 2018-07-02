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
    case mathBlue
    case teacherRed
    
    var color: UIColor {
        switch self {
        case .black: return UIColor.black
        case .red: return UIColor.red
        case .yellow: return UIColor.yellow
        case .mathBlue: return UIColor.mathBlue
        case .teacherRed: return UIColor.teacherRed
        }
    }
    
    static let allColors: [TKColor] = [TKColor.black,
                                       .red,
                                       .yellow,
                                       .mathBlue,
                                       .teacherRed]
    
    init?(tkCloudKey: String) {
        switch tkCloudKey {
        case "black": self = .black
        case "red": self = .red
        case "yellow": self = .yellow
        case "mathBlue": self = .mathBlue
        case "teacherRed": self = .teacherRed
        default: return nil
        }
    }
    
    var tkCloudKey: String {
        switch self {
        case .black: return "black"
        case .red: return "red"
        case .yellow: return "yellow"
        case .mathBlue: return "mathBlue"
        case .teacherRed: return "teacherRed"
            
        }
    }
}
