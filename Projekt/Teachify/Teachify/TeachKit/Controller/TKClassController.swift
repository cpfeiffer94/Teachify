//
//  TKClassController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecord {
    
    convenience init(tkClass: TKClass, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.classes, zoneID: recordZoneID)
        self[TKClass.CloudKey.name] = tkClass.name as CKRecordValue
    }
    
    convenience init(student: TKStudent, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.students, zoneID: recordZoneID)
        self[TKStudent.CloudKey.firstname] = student.firstname as CKRecordValue
        self[TKStudent.CloudKey.lastname] = student.lastname as CKRecordValue
        self[TKStudent.CloudKey.email] = student.email as CKRecordValue
    }
    
}

struct TKCloudKey {
    private init() {}
    
    struct RecordType {
        private init() {}
        static let classes = "Classes"
        static let subjectes = "Subjects"
        static let students = "Students"
    }
    
}

extension CKRecordZone {
    
    static var teachKitZone: CKRecordZone {
        return CKRecordZone(zoneName: "ClassZoneID")
    }
}

protocol TeachKitCloudController {
}

extension TeachKitCloudController {
    func fetchTeachKitRecordZone(completion: @escaping (CKRecordZone?, TKError?) -> ()) {
        CKContainer.default().privateCloudDatabase.fetchAllRecordZones { (recordZones, error) in
            guard let recordZones = recordZones else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            let classRecordZones = recordZones.compactMap { $0.zoneID.zoneName == CKRecordZone.teachKitZone.zoneID.zoneName ? $0 : nil }
            guard let classRecordZone = classRecordZones.first else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            completion(classRecordZone, nil)
        }
    }
}


struct TKClassController: TeachKitCloudController {
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    // MARK: - Class Operations
    func fetchClasses(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKClass], TKError?) -> ()) {
        
        fetchTeachKitRecordZone { (teachKitRecordZone, error) in
            guard let teachKitRecordZone = teachKitRecordZone else {
                completion([], TKError.dooooImplement)
                return
            }
            
            let predicate = NSPredicate(format: "TRUEPREDICATE")
            let query = CKQuery(recordType: TKCloudKey.RecordType.classes, predicate: predicate)
            self.privateDatabase.perform(query, inZoneWith: teachKitRecordZone.zoneID, completionHandler: { (fetchedClasses, error) in
                let tkClasses = fetchedClasses?.compactMap { TKClass(record: $0) } ?? []
                if error == nil {
                    completion(tkClasses, nil)
                } else {
                    completion([], TKError.dooooImplement)
                }
            })
        }
    }
    
    func create(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        var tkClass = tkClass
        let zone = CKRecordZone.teachKitZone
        
        privateDatabase.save(zone) { (savedZone, error) in
            guard let savedZone = savedZone else { return }
            
            tkClass.record = CKRecord(tkClass: tkClass, withRecordZoneID: savedZone.zoneID)
            
            guard let record = tkClass.record else { return }
            
            self.privateDatabase.save(record, completionHandler: { (savedRecord, error) in
                if error == nil {
                    tkClass.record = savedRecord
                    completion(tkClass, nil)
                } else {
                    completion(nil, TKError.dooooImplement)
                }
            })
        }
    }
    
    // TODO: ✅ werfe ein ERROR, wenn --> Record noch nicht vorhanden!
    func update(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        guard let record = tkClass.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        privateDatabase.save(record) { (savedRecord, error) in
            if let savedRecord = savedRecord {
                let savedClass = TKClass(record: savedRecord)
                completion(savedClass, nil)
            } else {
                completion(nil, TKError.dooooImplement)
            }
        }
    }
    
    func delete(tkClass: TKClass, completion: @escaping (TKError?) -> ()) {
        guard let record = tkClass.record else {
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
    
    
    // MARK: - Subject Operations
    func fetchSubject(forClass: TKClass,
                      withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKSubject], TKError?) -> ()) {
        
    }
    
    func create(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
    }
    
    func update(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
    }
    
    func delete(subject: TKSubject, completion: @escaping (TKSubject) -> ()) {
    }
}
