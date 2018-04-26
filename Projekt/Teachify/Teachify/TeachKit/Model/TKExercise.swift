//
//  TKExercise.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKExercise: TKCloudObject {
    var name: String {
        didSet {
            record?[CloudKey.name] = name as CKRecordValue
        }
    }
    var creationDate: Date? {
        return record?.creationDate
    }
    var type: TKExerciseType {
        didSet {
            record?[CloudKey.type] = type.tkCloudKey as CKRecordValue
        }
    }
    var deadline: Date? {
        didSet {
            if let deadline = deadline {
                record?[CloudKey.deadline] = deadline as CKRecordValue
            } else {
                record?[CloudKey.deadline] = nil
            }
        }
    }
    var data: String {
        didSet {
            record?[CloudKey.data] = data as CKRecordValue
        }
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, deadline: Date?, type: TKExerciseType, data: String) {
        self.name = name
        self.deadline = deadline
        self.type = type
        self.data = data
    }
    
    init?(record: CKRecord) {
        guard let name = record[CloudKey.name] as? String,
                let data = record[CloudKey.data] as? String,
                let typeString = record[CloudKey.type] as? String,
                let type = TKExerciseType(tkCloudKey: typeString) else {
            return nil
        }
        self.deadline = record[CloudKey.deadline] as? Date
        self.name = name
        self.data = data
        self.type = type
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
        static let type = "type"
        static let deadline = "deadline"
        static let data = "data"
        
        static let referenceToDocument = "document"
    }
}
