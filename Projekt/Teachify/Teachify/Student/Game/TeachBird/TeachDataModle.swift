//
//  TeachDataModle.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class TeachDataModle {
    
    let aufgaben:[[String]]
    var corectAnsware=0
    
    init() {
        aufgaben = [["consider", "beachten","kontrollieren","können","kennen"],
                    ["this","diese","die","dessen","deselbe","dagegen"],
                    ["dedicated","gewidmet","gesteigert","erkennen","erlösen","gefährdend"],
                    ["sophisticated","hochentwickelt","erlösen","kennen","gesteigert","dagegen"],
                    ["compromise","gefährdend","erlösen","kennen","erkennen","dagegen"],
                    ["ransom","erlösen","kennen","dagegen","gesteigert","gefährdend"],
                    ["increased","gesteigert","erlösen","erkennen","dagegen","kontrollieren"],
                    ["realize","erkennen","gefährdend","kennen","erlösen","dagegen"]
            
        ]
    }
    func getTask(number: Int)->[String]{
        let elementes=aufgaben.count
        let elemtnt=number % elementes
        return aufgaben[elemtnt]
    }
    func addCorrectAnsware(){
        corectAnsware += 1
    }
    func removeCorrectAnsware(){
        corectAnsware=0
    }
}

