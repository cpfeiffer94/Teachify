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
            } else {
                print("ERROR: Record Zone not found ")
                cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
        }
    }
    
    // MARK: - Exercise Operations
    // ✅
    func fetchExercises(forDocument document: TKDocument? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKExercise], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let classRecord = document?.record {
            predicate = NSPredicate(format: "%K == %@", TKExercise.CloudKey.referenceToDocument, CKReference(record: classRecord, action: CKReferenceAction.none))
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
