//
//  TKDocumentController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKDocumentController {
    
    var cloudCtrl = TKGenericCloudController<TKDocument>(zone: CKRecordZone.teachKitZone)

    // MARK: - Document Operations
    // ✅
    func fetchDocuments(forSubject subject: TKSubject? = nil,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKDocument], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let classRecord = subject?.record {
            predicate = NSPredicate(format: "%K == %@", TKDocument.CloudKey.referenceToSubject, CKReference(record: classRecord, action: CKReferenceAction.none))
        }
        
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.documents, predicate: predicate) { (fetchedDocuments, error) in
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









