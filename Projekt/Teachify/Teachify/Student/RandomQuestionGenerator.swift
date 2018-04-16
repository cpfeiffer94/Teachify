//
//  RandomQuestionGenerator.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class RandomQuestionGenerator {
    
    func generateGame(numberOfTasks : Int, lifes : Int) -> MathPianoGame {
        // task must be != 0
    
        var allQuestions : [MathPianoQuestionModel] = []
        
        for index in 1...numberOfTasks {
            
            let num0 : Int = Int(arc4random_uniform(10)+1)
            let num1 : Int = Int(arc4random_uniform(10)+1)
            
            let leftSide : [String] = [String(num0), "+", String(num1)]
            let rightSide : [String] = ["X"]
            let correctAnswer : Int = num0 + num1
            let wrongAnswers : [Int] = [num0 + num1 + 2, num0 + num1 - 2]
            
            let mathPianoQuestion = MathPianoQuestionModel(leftSide: leftSide, rightSide: rightSide, correctAnswer: correctAnswer, wrongAnswers: wrongAnswers)
            
            allQuestions.append(mathPianoQuestion)
            print("### \(index). Question created: \(mathPianoQuestion)")
        }
        
        let mathPianoGame = MathPianoGame(gameQuestions: allQuestions, lifes: lifes)
        
        print("Game created: \(mathPianoGame)")
        
        return mathPianoGame
    }
}
