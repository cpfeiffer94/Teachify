//
//  File.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit
import CloudKit


struct TKUser: TKCloudObject {
    var creationDate: Date? {
        return record?.creationDate
    }
    
    var firstname: String? {
        didSet {
            record?[CloudKey.firstname] = firstname as CKRecordValue?
        }
    }
    var lastname: String? {
        didSet {
            record?[CloudKey.lastname] = lastname as CKRecordValue?
        }
    }
    var image: UIImage? {
        didSet {
            if let record = record, let image = image {
                let fileURL = saveImageToFile(image, withFileName: record.recordID.recordName)
                let asset = CKAsset(fileURL: fileURL)
                record[CloudKey.image] = asset
            }
        }
    }
    var email: String? {
        didSet {
            record?[CloudKey.email] = email as CKRecordValue?
        }
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    private init() { }
    
    init?(record: CKRecord) {
        self.firstname = record[CloudKey.firstname] as? String
        self.lastname = record[CloudKey.lastname] as? String
        self.email = record[CloudKey.email] as? String
        if let imageAsset = record[CloudKey.image] as? CKAsset {
            let image = UIImage(contentsOfFile: imageAsset.fileURL.path)
            self.image = image
        }
        
        
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let image = "image"
        static let email = "email"
    }
    
    
    private func saveImageToFile(_ image: UIImage, withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = dirPaths[0].appendingPathComponent("\(fileName).jpg")
        if let renderedJPEGData = UIImageJPEGRepresentation(image, 1.0) {
            try? renderedJPEGData.write(to: fileURL)
        }
        return fileURL
    }
}

