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
    
    var solutions = [TKSolution]() {
        didSet {
            if let solutionData = try? JSONEncoder().encode(solutions) {
                record?[CloudKey.solutions] = solutionData as CKRecordValue
            }
        }
    }
    
    var exerciseID: String? {
        return record?.recordID.recordName
    }
    
    var documentID: String?
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, deadline: Date?, type: TKExerciseType, data: String) {
        self.name = name
        self.deadline = deadline
        self.type = type
        self.data = data
        self.solutions = []
    }
    
    init?(record: CKRecord) {
        guard let name = record[CloudKey.name] as? String,
                let data = record[CloudKey.data] as? String,
                let typeString = record[CloudKey.type] as? String,
                let type = TKExerciseType(tkCloudKey: typeString),
                let referenceToDocument = record[CloudKey.referenceToDocument] as? CKReference else {
            return nil
        }
        
        if let solutionsData = record[CloudKey.solutions] as? Data {
            let solutions = try! JSONDecoder().decode([TKSolution].self, from: solutionsData)
            self.solutions = solutions
        }
        
        self.deadline = record[CloudKey.deadline] as? Date
        self.name = name
        self.data = data
        self.type = type
        self.documentID = referenceToDocument.recordID.recordName
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
        static let type = "type"
        static let deadline = "deadline"
        static let data = "data"
        static let solutions = "solutions2"
        
        static let referenceToDocument = "document"
    }
}
