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
    let typ : String
    let deadline : Date?
    let subject : String
    let description : String
    let difficulty : String
    
    init(name:String, typ:String, deadline:Date?, subject:String, description:String, difficulty: String) {
        self.name = name
        self.typ = typ
        self.deadline = deadline
        self.subject = subject
        self.description = description
        self.difficulty = difficulty
    }
    
    
    
}
