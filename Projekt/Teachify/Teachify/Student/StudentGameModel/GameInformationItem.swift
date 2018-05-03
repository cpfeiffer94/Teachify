//
//  GameInformationItem.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

struct GameInformationItem {
    
    let name : String
    let type : String
    let deadline : Date?
    let subject : String
    let tries : Int
    
    init(name:String, typ:String, deadline:Date?, subject:String, tries:Int) {
        self.name = name
        self.type = typ
        self.deadline = deadline
        self.subject = subject
        self.tries = tries
        
    }
    
    
    
}
