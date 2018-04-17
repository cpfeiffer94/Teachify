//
//  TKSubject.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKSubject: TKCloudObject {
    var name: String {
        didSet {
            record?[CloudKey.name] = name as CKRecordValue
        }
    }
    var creationDate: Date?
    var color: TKColor
    var participants: [TKUser] = []
    var documentIDs: [String] = []
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, color: TKColor) {
        self.name = name
        self.color = color
    }
    
    init?(record: CKRecord) {
        guard let name = record[CloudKey.name] as? String else {
            return nil
        }
        self.name = name
        self.color = TKColor.red
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
        static let color = "color"
    }
}
