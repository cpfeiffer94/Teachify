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
    
    var cloudCtrl: TKGenericCloudController<TKExercise>!
    var rank: TKRank!
    
    mutating func initialize(withRank rank: TKRank, completion: @escaping (TKError?) -> ()) {
        self.rank = rank
        
        switch rank {
        case .student:
            if let recordZone = TKGenericCloudController<TKExercise>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                           forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKExercise>(zone: recordZone, database: rank.database)
                completion(nil)
            } else {
                cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
                completion(TKError.noSharedData)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKExercise>(zone: CKRecordZone.teachKitZone, database: rank.database)
            completion(nil)
        }
    }
    
    // MARK: - Solution Operations
    
    // ✅
    func append(exercise: TKExercise, with newSolution: TKSolution, completion: @escaping (TKExercise?, TKError?) -> ()) {
        var exercise = exercise
        exercise.solutions.append(newSolution)
        cloudCtrl.update(object: exercise) { (updatedDocument, error) in
            completion(updatedDocument, error)
        }
    }
    
}
