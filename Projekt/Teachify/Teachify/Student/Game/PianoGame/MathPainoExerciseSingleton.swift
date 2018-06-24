//
//  MathPainoParams.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoExerciseSingleton {
        static let sharedInstance = MathPianoExerciseSingleton()
        fileprivate var exercises : [TKExercise] = []
        
        private init (){}
    }
    
    class MathPianoExerciseController : NSObject {
        fileprivate var model = MathPianoExerciseSingleton.sharedInstance
        
        override init(){
            super.init()
        }
        
        func setExercises(exercises: [TKExercise]){
            model.exercises = exercises
        }
        
        func appendExercises(exercises : [TKExercise]){
            model.exercises.append(contentsOf: exercises)
        }
        
        func getExercises() -> [TKExercise] {
            return model.exercises
        }
        
        func resetExercises() {
            model.exercises = []
        }
}

