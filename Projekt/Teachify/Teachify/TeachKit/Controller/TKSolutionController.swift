//
//  TKSolutionController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 26.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

struct TKSolutionController {
    
    var cloudCtrl = TKGenericCloudController<TKSolution>(zone: CKRecordZone.teachKitZone)
    
    // MARK: - Solution Operations
    func fetchExercises(forDocument document: TKDocument? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKExercise], TKError?) -> ()) {
        
    }
    
    func create(exercise: TKExercise, toDocument document: TKDocument, completion: @escaping (TKExercise?, TKError?) -> ()) {
    }
    
    func update(exercise: TKExercise, completion: @escaping (TKExercise?, TKError?) -> ()) {
    }
    
    func delete(exercise: TKExercise, completion: @escaping (TKError?) -> ()) {
    }
}
