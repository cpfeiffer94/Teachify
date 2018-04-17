//
//  MathPianoGame.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoGame : NSObject {
    
    var gameQuestions : [MathPianoQuestionModel]
    var lifes : Int
    
    init(gameQuestions : [MathPianoQuestionModel], lifes : Int) {
        self.gameQuestions = gameQuestions
        self.lifes = lifes
        
    }
}
