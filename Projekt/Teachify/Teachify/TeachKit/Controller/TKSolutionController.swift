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
    
    var cloudCtrl: TKGenericCloudController<TKSolution>!
    var rank: TKRank!
    
    mutating func initialize(withRank rank: TKRank, completion: @escaping (Bool) -> ()) {
        self.rank = rank
        
        switch rank {
        case .student:
            if let recordZone = TKGenericCloudController<TKSolution>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                          forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKSolution>(zone: recordZone, database: rank.database)
                completion(true)
            } else {
                completion(false)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKSolution>(zone: CKRecordZone.teachKitZone, database: rank.database)
            completion(true)
        }
    }
    
    
    // MARK: - Solution Operations
    // ✅
    func fetchSolutions(forExercise exercise: TKExercise? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKSolution], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let exerciseRecord = exercise?.record {
            predicate = NSPredicate(format: "%K == %@", TKSolution.CloudKey.referenceToExercise, CKReference(record: exerciseRecord, action: CKReferenceAction.none))
        }
        
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.solution, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedDocuments, error) in
            completion(fetchedDocuments, error)
        }
    }
    
    // ✅
    func create(solution: TKSolution, toExercise exercise: TKExercise, completion: @escaping (TKSolution?, TKError?) -> ()) {
        cloudCtrl.create(object: solution) { (createdSolution, error) in
            guard let createdSolution = createdSolution else {
                completion(nil, TKError.dooooImplement)
                return
            }

            self.cloudCtrl.add(object: createdSolution,
                               parentObject: exercise,
                               withReferenceKey: TKSolution.CloudKey.referenceToExercise,
                               andAction: CKReferenceAction.deleteSelf,
                               completion: { (addedSolution, error) in
                                completion(addedSolution, error)
            })
        }
    }
    
    // ✅
    func update(solution: TKSolution, completion: @escaping (TKSolution?, TKError?) -> ()) {
        cloudCtrl.update(object: solution) { (updatedSolution, error) in
            completion(updatedSolution, error)
        }
    }
    
    // ✅
    func delete(solution: TKSolution, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: solution) { (error) in
            completion(error)
        }
    }
}
