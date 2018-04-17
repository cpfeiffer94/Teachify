//
//  TKSubjectController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

struct TKSubjectController: TeachKitCloudController {
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    
    // MARK: - Subject Operations
    // ✅
    func fetchSubject(forClass tkClass: TKClass,
                      withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKSubject], TKError?) -> ()) {
        
        fetchTeachKitRecordZone { (teachKitRecordZone, error) in
            guard let teachKitRecordZone = teachKitRecordZone else {
                completion([], TKError.dooooImplement)
                return
            }
            
            let predicate = NSPredicate(format: "TRUEPREDICATE")
            let query = CKQuery(recordType: TKCloudKey.RecordType.subjectes, predicate: predicate)
            self.privateDatabase.perform(query, inZoneWith: teachKitRecordZone.zoneID, completionHandler: { (subjectRecords, error) in
                let subjects = subjectRecords?.compactMap { TKSubject(record: $0) } ?? []
                if error == nil {
                    completion(subjects, nil)
                } else {
                    completion([], TKError.dooooImplement)
                }
            })
        }
    }
    
    // ✅
    func add(subject: TKSubject, toTKClass tkClass: TKClass, completion: @escaping (TKSubject?, TKError?) -> ()) {
        guard let classRecord = tkClass.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        let recordZoneID = CKRecordZone.teachKitZone.zoneID
        let subjectRecord = CKRecord(subject: subject, withRecordZoneID: recordZoneID)
        subjectRecord["class"] = CKReference(record: classRecord, action: .deleteSelf)
        
        privateDatabase.save(subjectRecord) { (savedSubjectRecord, error) in
            if let savedSubjectRecord = savedSubjectRecord {
                let subject = TKSubject(record: savedSubjectRecord)
                completion(subject, nil)
            } else {
                completion(nil, TKError.dooooImplement)
            }
        }
        
    }
    
    // ✅
    func update(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
        guard let record = subject.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        privateDatabase.save(record) { (savedRecord, error) in
            if let savedRecord = savedRecord {
                let subject = TKSubject(record: savedRecord)
                completion(subject, nil)
            } else {
                completion(nil, TKError.dooooImplement)
            }
        }
    }
    
    // ✅
    func delete(subject: TKSubject, completion: @escaping (TKError?) -> ()) {
        guard let record = subject.record else {
            completion(TKError.dooooImplement)
            return
        }
        privateDatabase.delete(withRecordID: record.recordID) { (deletedRecordID, error) in
            if error == nil {
                completion(nil)
            } else {
                completion(TKError.dooooImplement)
            }
        }
    }
}





