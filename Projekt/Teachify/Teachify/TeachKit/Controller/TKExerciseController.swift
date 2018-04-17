//
//  TKExerciseController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct TKExerciseController {
    

    
    // MARK: - Exercise Operations
    func fetchExercises(forDocument document: TKDocument,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKExercise], TKError?) -> ()) {
    }
    
    func create(exercise: TKExercise, completion: @escaping (TKExercise?, TKError?) -> ()) {
        
    }
    
    func update(exercise: TKExercise, completion: @escaping (TKExercise?, TKError?) -> ()) {
        
    }
    
    func delete(exercise: TKExercise, completion: @escaping (TKExercise?, TKError?) -> ()) {
    }
}
