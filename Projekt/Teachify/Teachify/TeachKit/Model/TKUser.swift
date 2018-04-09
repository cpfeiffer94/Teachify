//
//  File.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import UIKit
import CloudKit


struct TKUser {
    var firstname: String? {
        didSet {
            record[CloudKey.firstname] = firstname as CKRecordValue?
        }
    }
    var lastname: String? {
        didSet {
            record[CloudKey.lastname] = lastname as CKRecordValue?
        }
    }
    var image: UIImage? {
        didSet {
            if let image = image {
                let fileURL = saveImageToFile(image, withFileName: record.recordID.recordName)
                let asset = CKAsset(fileURL: fileURL)
                record[CloudKey.image] = asset
            }
        }
    }
    var email: String? {
        didSet {
            record[CloudKey.email] = email as CKRecordValue?
        }
    }
    private(set) var recordID: CKRecordID
    private(set) var record: CKRecord
    
    init(record: CKRecord) {
        self.record = record
        self.recordID = record.recordID
    }
    
    struct CloudKey {
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let image = "image"
        static let email = "email"
    }
    
    func saveImageToFile(_ image: UIImage, withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = dirPaths[0].appendingPathComponent("\(fileName).jpg")
        if let renderedJPEGData = UIImageJPEGRepresentation(image, 1.0) {
            try? renderedJPEGData.write(to: fileURL)
        }
        return fileURL
    }
}

extension TKUser {
    init?(ofRecord record: CKRecord?) {
        guard let record = record else { return nil }
        
        var user = TKUser(record: record)
        
        user.firstname = record[CloudKey.firstname] as? String
        user.lastname = record[CloudKey.lastname] as? String
        user.image = record[CloudKey.image] as? UIImage
        if let imageAsset = record[CloudKey.image] as? CKAsset {
            let imageAssetPath = imageAsset.fileURL.path
            let image = UIImage(contentsOfFile: imageAssetPath)
            user.image = image
        }
        user.email = record[CloudKey.email] as? String
        user.recordID = record.recordID
        user.record = record
        
        self = user
    }
}
