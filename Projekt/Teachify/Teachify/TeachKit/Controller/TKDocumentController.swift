//
//  TKDocumentController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

struct TKDocumentController {

    // MARK: - Document Operations
    func fetchDocuments(forSubject subject: TKSubject,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKDocument], TKError?) -> ()) {
    }
    
    func create(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
    }
    
    func update(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
    }
    
    func delete(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
    }
    
    
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
