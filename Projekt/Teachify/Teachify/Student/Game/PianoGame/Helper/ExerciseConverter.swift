//
//  Exercise Converter.swift
//  Teachify
//
//  Created by Normen Krug on 02.07.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class ExerciseConverter{
    
    let pianoSingeltonController =  MathPianoExerciseController()
    
    func convert() -> (MathPianoGame,Bool){
        
        var isContinous = false
        let exerxises = pianoSingeltonController.getExercises()
        var pianoModels: [MathPianoQuestionModel] = []
        
        if exerxises.first?.name == "Continous Play MathPiano"{
            isContinous = true
        }
        else{
            for item in exerxises{
            
            if let jsonData = item.data.data(using: .utf8){
                let mathModel = try? JSONDecoder().decode(MathModel.self, from: jsonData)
                var leftSide: [String] = []
                leftSide.append(String(mathModel!.firstNumber!))
                leftSide.append(String(mathModel!.operation!))
                leftSide.append(String(mathModel!.secondNumber!))
                var rightSide: [String] = []
                rightSide.append("?")
                var allAnswer = mathModel!.falseAnswers!
                allAnswer.removeLast()
                let randomNumber = arc4random_uniform(3)
                allAnswer[Int(randomNumber)] = mathModel!.correctAnswer!
                
                let pianoEntry = MathPianoQuestionModel(leftSide: leftSide, rightSide: rightSide, correctAnswer: mathModel!.correctAnswer!, allAnswers: allAnswer)
                pianoModels.append(pianoEntry)
                
            }
        }
            
        }
     
       
        let mathPianoGame = MathPianoGame(gameQuestions: pianoModels, lifes: 3)
        return (mathPianoGame,isContinous)
    }
    
}
