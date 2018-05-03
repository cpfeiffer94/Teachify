//
//  TKClassController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit


// ✅
struct TKClassController {
    
    var cloudCtrl: TKGenericCloudController<TKClass>!
    var rank: TKRank!
    
    mutating func initialize(withRank rank: TKRank, completion: @escaping (Bool) -> ()) {
        self.rank = rank
        
        switch rank {
        case .student:
            if let recordZone = TKGenericCloudController<TKClass>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                        forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKClass>(zone: recordZone, database: rank.database)
                completion(true)
            } else {
                completion(false)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKClass>(zone: CKRecordZone.teachKitZone, database: rank.database)
            completion(true)
        }
    }
    
    // MARK: - Class Operations
    // ✅
    func fetchClasses(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKClass], TKError?) -> ()) {
        
        let recordType = TKCloudKey.RecordType.classes
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        cloudCtrl.fetch(forRecordType: recordType, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedClasses, error) in
            completion(fetchedClasses, error)
        }
    }
    
    // ✅
    func create(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        cloudCtrl.create(object: tkClass) { (tkClass, error) in
            completion(tkClass, error)
        }
    }
    
    // TODO: ✅ werfe ein ERROR, wenn --> Record noch nicht vorhanden!
    // ✅
    func update(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        cloudCtrl.update(object: tkClass) { (tkClass, error) in
            completion(tkClass, error)
        }
    }
    
    // ✅
    func delete(tkClass: TKClass, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: tkClass) { (error) in
            completion(error)
        }
    }
}
