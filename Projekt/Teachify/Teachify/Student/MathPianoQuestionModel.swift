//
//  MathPianoModel.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoQuestionModel : NSObject, Codable {
    
    var leftSide : [String] = []
    var rightSide : [String] = []
    
    var correctAnswer : Int?
    var allAnswers : [Int]?
    
    
    init(leftSide : [String], rightSide : [String], correctAnswer : Int, allAnswers : [Int]) {
        self.leftSide = leftSide
        self.rightSide = rightSide
        self.correctAnswer = correctAnswer
        self.allAnswers = allAnswers
    }
    
    func getLeftSideAsString() -> String {
        var assembled : String = ""
        
        for item in leftSide {
//            print(item)
            assembled = assembled + item
            assembled = assembled + " "
        }
//        print(assembled)
        return assembled
    }
    
    func getRightSideAsString() -> String {
        var assembled : String = ""
        
        for item in rightSide {
            assembled = assembled + item
            assembled = assembled + " "
        }
//        print(assembled)
        return assembled
    }
    
    func getQuestionAsString() -> String {
        return getLeftSideAsString() + " = " + getRightSideAsString()
    }
}
