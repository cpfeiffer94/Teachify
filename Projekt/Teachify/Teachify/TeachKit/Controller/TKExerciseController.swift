//
//  TKExerciseController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

struct TKExerciseController {
    
    var cloudCtrl: TKGenericCloudController<TKExercise>!
    var rank: TKRank!
    
    mutating func initialize(withRank rank: TKRank, completion: @escaping (Bool) -> ()) {
        self.rank = rank
        
        switch rank {
        case .student:
            if let recordZone = TKGenericCloudController<TKExercise>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                           forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKExercise>(zone: recordZone, database: rank.database)
                completion(true)
            } else {
                cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
                completion(false)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
            completion(true)
        }
    }
    
    // MARK: - Exercise Operations
    // ✅
    func fetchExercises(forDocument document: TKDocument? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKExercise], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let documentRecord = document?.record {
            predicate = NSPredicate(format: "%K == %@", TKExercise.CloudKey.referenceToDocument, CKReference(record: documentRecord, action: CKReferenceAction.none))
        }
        
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.exercises, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedDocuments, error) in
            completion(fetchedDocuments, error)
        }
    }
    
    // ✅
    func create(exercise: TKExercise, toDocument document: TKDocument, completion: @escaping (TKExercise?, TKError?) -> ()) {
        cloudCtrl.create(object: exercise) { (createdExercise, error) in
            guard let createdExercise = createdExercise else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            self.cloudCtrl.add(object: createdExercise,
                               parentObject: document,
                               withReferenceKey: TKExercise.CloudKey.referenceToDocument,
                               andAction: CKReferenceAction.deleteSelf,
                               completion: { (addedExercise, error) in
                                completion(addedExercise, error)
            })
        }
    }
    
    func create(exercises: [TKExercise], toDocument: TKDocument, completion: @escaping ([TKExercise?], TKError?) -> ()){
        var allExercises = [TKExercise?]()
        var aError: TKError?
        let group = DispatchGroup()
        exercises.forEach { (exercise) in
            group.enter()
            self.create(exercise: exercise, toDocument: toDocument, completion: {
                (addedExercise, error) in
                allExercises.append(addedExercise)
                aError = error
                group.leave()
            })
        }
        
        group.notify(queue: DispatchQueue.main){
            completion(allExercises, aError)
        }
        
    }
    
    // ✅
    func update(exercise: TKExercise, completion: @escaping (TKExercise?, TKError?) -> ()) {
        cloudCtrl.update(object: exercise) { (updatedDocument, error) in
            completion(updatedDocument, error)
        }
    }
    
    // ✅
    func delete(exercise: TKExercise, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: exercise) { (error) in
            completion(error)
        }
    }
}
