//
//  TKClass.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKClass: TKCloudObject {
    var name: String {
        didSet {
            record?[CloudKey.name] = name as CKRecordValue
        }
    }
    var creationDate: Date? {
        return record?.creationDate
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String) {
        self.name = name
    }
    
    init(record: CKRecord) {
        self.name = record[CloudKey.name] as? String ?? "TKClass-init-Error"
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
    }
}
