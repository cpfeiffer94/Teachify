//
//  FeedMeExerciseSingleton.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 24.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class FeedMeExerciseSingleton {
    static let sharedInstance = FeedMeExerciseSingleton()
    fileprivate var exercises : [TKExercise] = []
    
    private init (){}
}

class FeedMeExerciseController : NSObject {
    fileprivate var model = FeedMeExerciseSingleton.sharedInstance
    
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
