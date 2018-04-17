//
//  TKSubjectController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

struct TKSubjectController {
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    var cloudCtrl = TKGenericCloudController<TKSubject>(zone: CKRecordZone.teachKitZone)
    
    // MARK: - Subject Operations
    // ✅
    func fetchSubject(forClass tkClass: TKClass,
                      withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKSubject], TKError?) -> ()) {
        guard let record = tkClass.record else {
            completion([], TKError.dooooImplement)
            return
        }
        
        let predicate = NSPredicate(format: "%K == %@", "class", CKReference(record: record, action: CKReferenceAction.none))
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.subjectes, predicate: predicate) { (fetchedSubjects, error) in
            completion(fetchedSubjects, error)
        }
    }
    
    // ✅
    func add(subject: TKSubject, toTKClass tkClass: TKClass, completion: @escaping (TKSubject?, TKError?) -> ()) {
        cloudCtrl.create(object: subject) { (createdSubject, error) in
            guard let createdSubject = createdSubject else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            self.cloudCtrl.add(object: createdSubject,
                               parentObject: tkClass,
                               withReferenceKey: "class",
                               andAction: CKReferenceAction.deleteSelf,
                               completion: { (subject, error) in
                completion(subject, error)
            })
        }
    }
    
    // ✅
    func update(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
        cloudCtrl.update(object: subject) { (updatedSubject, error) in
            completion(updatedSubject, error)
        }
    }
    
    // ✅
    func delete(subject: TKSubject, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: subject) { (error) in
            completion(error)
        }
    }
}





