//
//  GameInformationItem.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

struct ContinousGameInformationItem {
    
    let name : String
    let type : TKExerciseType
    let subject : String
    let color : UIColor
    let backgroundImage : UIImage
    
    init(name:String, type : TKExerciseType, subject:String, color : UIColor, image : UIImage) {
        self.name = name
        self.type = type
        self.subject = subject
        self.color = color
        self.backgroundImage = image
    }
    
    
    
}
