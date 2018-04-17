//
//  RandomQuestionGenerator.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class RandomQuestionGenerator {
    
    func generateGame(numberOfQuestions : Int, lifes : Int) -> MathPianoGame {
        // task must be != 0
    
        var allQuestions : [MathPianoQuestionModel] = []
        
        for index in 1...numberOfQuestions {
            
            let num0 : Int = Int(arc4random_uniform(10)+1)
            let num1 : Int = Int(arc4random_uniform(10)+1)
            
            let leftSide : [String] = [String(num0), "+", String(num1)]
            let rightSide : [String] = ["X"]
            let correctAnswer : Int = num0 + num1
            
            var allAnswers : [Int] = [num0 + num1 + 2, num0 + num1 - 2]
            let leftBound : Int = allAnswers.count + 1
            let randomNr : Int = Int(arc4random_uniform(UInt32(leftBound))) // 0-2
            
            allAnswers.insert(correctAnswer, at: randomNr)
            
            let mathPianoQuestion = MathPianoQuestionModel(leftSide: leftSide, rightSide: rightSide, correctAnswer: correctAnswer, allAnswers: allAnswers)
            
            allQuestions.append(mathPianoQuestion)
            print("### \(index). Question created: \(mathPianoQuestion)")
        }
        
        let mathPianoGame = MathPianoGame(gameQuestions: allQuestions, lifes: lifes)
        
        print("### Game created: \(mathPianoGame)")
        
        return mathPianoGame
    }
}
