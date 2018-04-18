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
    var name: String
    var creationDate: Date?
    //var exerciseIDs: [String]
    var deadline: Date?
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, deadline: Date?) {
        self.name = name
        self.deadline = deadline
    }
    
    init?(record: CKRecord) {
        guard let name = record[CloudKey.name] as? String else {
            return nil
        }
        self.deadline = record[CloudKey.deadline] as? Date
        self.name = name
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
