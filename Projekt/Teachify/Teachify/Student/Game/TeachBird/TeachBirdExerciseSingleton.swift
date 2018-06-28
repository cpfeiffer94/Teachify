//
//  TeachBirdExerciseSingleton.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 24.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class TeachBirdExerciseSingleton {
        static let sharedInstance = TeachBirdExerciseSingleton()
        fileprivate var exercises : [TKExercise] = []
        
        private init (){}
}

class TeachBirdExerciseController : NSObject {
    fileprivate var model = TeachBirdExerciseSingleton.sharedInstance
    
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
