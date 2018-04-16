//
//  MathPianoModel.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoQuestionModel : NSObject {
    
    var leftSide : [String]?
    var rightSide : [String]?
    
    var correctAnswer : Int?
    var wrongAnswers : [Int]?
    
    
    init(leftSide : [String], rightSide : [String], correctAnswer : Int, wrongAnswers : [Int]) {
        self.leftSide = leftSide
        self.rightSide = rightSide
        self.correctAnswer = correctAnswer
        self.wrongAnswers = wrongAnswers
    }
    
}
