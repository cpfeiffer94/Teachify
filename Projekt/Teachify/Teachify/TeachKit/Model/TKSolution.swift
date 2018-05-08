//
//  TKSolution.swift
//  Teachify
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import CloudKit

struct TKSolution: TKCloudObject {
    var creationDate: Date? {
        return record?.creationDate
    }
    var status: TKSolutionStatus {
        didSet {
            record?[CloudKey.status] = status.tkCloudKey as CKRecordValue
        }
    }
    var userSolution: String {
        didSet {
            record?[CloudKey.userSolution] = userSolution as CKRecordValue
        }
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(userSolution: String, status: TKSolutionStatus) {
        self.userSolution = userSolution
        self.status = status
    }
    
    init?(record: CKRecord) {
        guard let userSolution = record[CloudKey.userSolution] as? String,
            let statusCloudKey = record[CloudKey.status] as? String,
            let status = TKSolutionStatus(tkCloudKey: statusCloudKey) else {
                return nil
        }
        
        self.userSolution = userSolution
        self.status = status
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let status = "status"
        static let userSolution = "userSolution"
        
        static let referenceToExercise = "exercise"
    }
}
