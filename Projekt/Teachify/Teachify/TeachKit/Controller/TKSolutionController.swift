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
    
    var cloudCtrl: TKGenericCloudController<TKSolution>
    var rank: TKRank
    
    init(rank: TKRank) {
        self.rank = rank
        
        switch rank {
        case .student:
            // Wichtig fürs Sharing: die sharedReczoneZone muss zuerst gefetched werden um darin arbeiten zu können.
            if let recordZone = TKGenericCloudController<TKSolution>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                           forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKSolution>(zone: recordZone, database: rank.database)
            } else {
                print("ERROR: Record Zone not found ")
                cloudCtrl = TKGenericCloudController<TKSolution>(zone: CKRecordZone.teachKitZone, database: rank.database)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKSolution>(zone: CKRecordZone.teachKitZone, database: rank.database)
        }
    }
    
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
