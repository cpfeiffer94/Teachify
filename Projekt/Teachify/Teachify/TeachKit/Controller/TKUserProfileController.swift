//
//  TKUserProfileController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import CloudKit

struct TKUserProfileController {
    private let container = CKContainer.default()
    private let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func fetchUserProfile(completion: @escaping (TKUser?, TKError?) -> ()) {
        
        container.fetchUserRecordID { (userRecordId, error) in
            if let error = error as? CKError {
                if let tkError = TKError(ckError: error) {
                    completion(nil, tkError)
                } else {
                    // TODO: ✅ do error handling
                    completion(nil, nil)
                }
            } else {
                if let userRecordID = userRecordId {
                    self.fetchUserRecord(forRecordID: userRecordID, completion: { (user, error) in
                        completion(user, error)
                    })
                } else {
                    print("Error located: TKUserProfileController.fetchUserProfile")
                    completion(nil, TKError.dooooImplement)
                }
            }
        }
    }
    
    private func fetchUserRecord(forRecordID recordID: CKRecordID, completion: @escaping (TKUser?, TKError?) -> ()) {
        publicDatabase.fetch(withRecordID: recordID) { (record, error) in
            if let record = record {
                let user = TKUser(ofRecord: record)
                completion(user, nil)
            } else {
                print("Error located: TKUserProfileController.fetchUserRecord")
                completion(nil, TKError.dooooImplement)
            }
        }
    }
    
    func update(user: TKUser, completion: @escaping (TKUser?, TKError?) -> ()) {
        let userRecord = user.record
        
        publicDatabase.save(userRecord) { (savedUserRecord, error) in
            if let error = error as? CKError {
                if let tkError = TKError(ckError: error) {
                    completion(nil, tkError)
                } else {
                    print("Error located: TKUserProfileController.update")
                    completion(nil, TKError.dooooImplement)
                }
            } else {
                let savedUserRecord = TKUser(ofRecord: savedUserRecord)
                completion(savedUserRecord, nil)
            }
        }
    }
}
