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
    var documents: [TKDocument] = []
    var name: String {
        didSet {
            record?[CloudKey.name] = name as CKRecordValue
        }
    }
    var creationDate: Date? {
        return record?.creationDate
    }
    var color: TKColor {
        didSet {
            record?[CloudKey.color] = color.tkCloudKey as CKRecordValue
        }
    }
    
    var classID: String?
    
    var subjectID : String? {
        return record?.recordID.recordName
    }
    // ✅ TODO: wird von Schnittstellenteam noch bearbeitet
//    var participants: [TKUser] = []
//    var documentIDs: [String] = []
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(name: String, color: TKColor) {
        self.name = name
        self.color = color
    }
    
    init?(record: CKRecord) {
        
        guard let name = record[CloudKey.name] as? String,
            let colorKey = record[CloudKey.color] as? String,
            let color = TKColor(tkCloudKey: colorKey),
            let referenceToClass = record[CloudKey.referenceToClass] as? CKReference else {
            return nil
        }
        self.name = name
        self.color = color
        self.record = record
        self.classID = referenceToClass.recordID.recordName
        print(self)
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let name = "name"
        static let color = "color"
        
        static let referenceToClass = "class"
    }
}
