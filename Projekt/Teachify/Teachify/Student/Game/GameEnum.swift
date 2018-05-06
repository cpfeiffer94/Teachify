//
//  GameEnum.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 04.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

enum GameEnum : String {
    
    case mathPiano = "MathPianoGameViewController"
    case followTheOrder = "FollowTheOrderGameViewController"
    
    var gameViewControllerClass : AnyClass {
        return NSClassFromString(self.rawValue)!
    }
}
