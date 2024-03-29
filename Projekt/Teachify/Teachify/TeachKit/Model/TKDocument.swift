//
//  TKDocument.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKDocument: TKCloudObject {
    var exercises: [TKExercise] = []
    var name: String {
        didSet {
            record?[CloudKey.name] = name as CKRecordValue
        }
    }
    var creationDate: Date? {
        return record?.creationDate
    }
    //var exerciseIDs: [String]
    var deadline: Date? {
        didSet {
            if let deadline = deadline {
                record?[CloudKey.deadline] = deadline as CKRecordValue
            } else {
                record?[CloudKey.deadline] = nil
            }
        }
    }
    
    var documentID: String? {
        return record?.recordID.recordName
    }
    
    var subjectID: String?
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, deadline: Date?) {
        self.name = name
        self.deadline = deadline
    }
    
    init?(record: CKRecord) {
        guard let name = record[CloudKey.name] as? String,
        let referenceToSubject = record[CloudKey.referenceToSubject] as? CKReference
        else {
            return nil
        }
        self.deadline = record[CloudKey.deadline] as? Date
        self.name = name
        self.subjectID = referenceToSubject.recordID.recordName
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
        static let deadline = "deadline"
        
        static let referenceToSubject = "subject"
    }
}
