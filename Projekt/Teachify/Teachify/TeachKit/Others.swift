//
//  Others.swift
//  Teachify
//
//  Created by Marcel Hagmann on 09.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

protocol TKCloudObject {
    var creationDate: Date? { get }
    var record: CKRecord? { get set }
    init?(record: CKRecord)
}


func randomDelay(completion: @escaping () -> Void) {
    let time: TimeInterval = Double(arc4random_uniform(4) + 1)
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}


struct TKStudent: TKCloudObject {
    var firstname: String {
        didSet {
            record?[CloudKey.firstname] = firstname as CKRecordValue
        }
    }
    var lastname: String {
        didSet {
            record?[CloudKey.lastname] = lastname as CKRecordValue
        }
    }
    var email: String {
        didSet {
            record?[CloudKey.email] = email as CKRecordValue
        }
    }
    var creationDate: Date? {
        return record?.creationDate
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(firstname: String, lastname: String, email: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
    
    init?(record: CKRecord) {
        self.firstname = record[CloudKey.firstname] as? String ?? "TKStudent-init-Error"
        self.lastname = record[CloudKey.lastname] as? String ?? "TKStudent-init-Error"
        self.email = record[CloudKey.email] as? String ?? "TKStudent-init-Error"
        
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let email = "email"
    }
}

extension TKStudent: Equatable {
    static func == (lhs: TKStudent, rhs: TKStudent) -> Bool {
        return lhs.firstname == rhs.firstname && lhs.lastname == rhs.lastname
    }
}


enum TKShareOption {
    case addParticipant
    case removeParticipant
}

