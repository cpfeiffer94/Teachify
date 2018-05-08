//
//  TKDocumentController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

//protocol TKTeachKitController {
//    associatedtype T
//    var rank: TKRank { get set }
//}
//
//extension TKTeacherController where T == TKCloudObject {
//    func initialize(withRank rank: TKRank, completion: @escaping (Bool) -> ()) {
//        self.rank = rank
//
//        switch rank {
//        case .student:
//            if let recordZone = fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
//                                      forDatabase: CKContainer.default().sharedCloudDatabase) {
//                self.cloudCtrl = TKGenericCloudController<T>(zone: recordZone, database: rank.database)
//            } else {
//                completion(false)
//                cloudCtrl = TKGenericCloudController<T>(zone: CKRecordZone.teachKitZone, database: rank.database)
//            }
//        case .teacher:
//            cloudCtrl = TKGenericCloudController<T>(zone: CKRecordZone.teachKitZone, database: rank.database)
//        }
//    }
//
//    func fetch(recordZone recordZoneName: String, forDatabase database: CKDatabase) -> CKRecordZone? {
//        var result: CKRecordZone? = nil
//
//        let group = DispatchGroup()
//        group.enter()
//
//        fetch(recordZone: recordZoneName, forDatabase: database) { (fetchedRecordZone, error) in
//            result = fetchedRecordZone
//            group.leave()
//        }
//
//        group.wait()
//
//        return result
//    }
//
//    func fetch(recordZone recordZoneName: String, forDatabase database: CKDatabase, completion: @escaping (CKRecordZone?, TKError?) -> ()) {
//
//        database.fetchAllRecordZones { (recordZones, error) in
//            guard let recordZones = recordZones else {
//                completion(nil, TKError.dooooImplement)
//                return
//            }
//
//            let classRecordZones = recordZones.compactMap { $0.zoneID.zoneName == recordZoneName ? $0 : nil }
//            guard let classRecordZone = classRecordZones.first else {
//                completion(nil, TKError.dooooImplement)
//                return
//            }
//
//            completion(classRecordZone, nil)
//        }
//    }
//}

struct TKDocumentController {
    
    var cloudCtrl: TKGenericCloudController<TKDocument>!
    var rank: TKRank!
    
    mutating func initialize(withRank rank: TKRank, completion: @escaping (Bool) -> ()) {
        self.rank = rank
        
        switch rank {
        case .student:
            if let recordZone = TKGenericCloudController<TKDocument>.fetch(recordZone: CKRecordZone.teachKitZone.zoneID.zoneName,
                                                                           forDatabase: CKContainer.default().sharedCloudDatabase) {
                self.cloudCtrl = TKGenericCloudController<TKDocument>(zone: recordZone, database: rank.database)
                completion(true)
            } else {
                completion(false)
            }
        case .teacher:
            cloudCtrl = TKGenericCloudController<TKDocument>(zone: CKRecordZone.teachKitZone, database: rank.database)
            completion(true)
        }
    }

    // MARK: - Document Operations
    // ✅
    func fetchDocuments(forSubject subject: TKSubject? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKDocument], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let subjectRecord = subject?.record {
            predicate = NSPredicate(format: "%K == %@", TKDocument.CloudKey.referenceToSubject, CKReference(record: subjectRecord, action: CKReferenceAction.none))
        }
        
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.documents, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedDocuments, error) in
            completion(fetchedDocuments, error)
        }
    }
    
    // ✅
    func add(document: TKDocument, toSubject subject: TKSubject, completion: @escaping (TKDocument?, TKError?) -> ()) {
        cloudCtrl.create(object: document) { (createdDocument, error) in
            guard let createdDocument = createdDocument else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            self.cloudCtrl.add(object: createdDocument,
                               parentObject: subject,
                               withReferenceKey: TKDocument.CloudKey.referenceToSubject,
                               andAction: CKReferenceAction.deleteSelf,
                               completion: { (addedDocument, error) in
                                completion(addedDocument, error)
            })
        }
    }
    
    // ✅
    func update(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
        cloudCtrl.update(object: document) { (updatedDocument, error) in
            completion(updatedDocument, error)
        }
    }
    
    // ✅
    func delete(document: TKDocument, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: document) { (error) in
            completion(error)
        }
    }
    
}









