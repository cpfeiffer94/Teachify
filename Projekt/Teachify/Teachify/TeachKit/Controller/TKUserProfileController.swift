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
        container.fetchUserRecordID { (loggedInUserID, error) in
            if let loggedInUserRecoordID = loggedInUserID {
                self.publicDatabase.fetch(withRecordID: loggedInUserRecoordID, completionHandler: { (userRecord, error) in
                    
                    if let userRecord = userRecord {
                        let user = TKUser(record: userRecord)
                        completion(user, nil)
                    } else {
                        print("TKUserProfileController-fetchUserProfile-Error: \(String(describing: error))")
                        completion(nil, TKError.userCouldNotLoad)
                    }
                })
            } else {
                completion(nil, TKError.networkFailure)
                print("TKUserProfileController-fetchUserProfile-Error: \(String(describing: error))")
                if let cloudError = error as? CKError, let tkError = TKError(ckError: cloudError) {
                    completion(nil, tkError)
                } else {
                    completion(nil, TKError.userCouldNotLoad)
                }
            }
        }
    }
    
    func update(user: TKUser, completion: @escaping (TKUser?, TKError?) -> ()) {
        guard let record = user.record else {
            print("TKUserProfileController-update-Error)")
            completion(nil, TKError.userCouldNotLoad)
            return
        }
        
        self.publicDatabase.save(record, completionHandler: { (updatedRecord, error) in
            if let updatedRecord = updatedRecord, let user = TKUser(record: updatedRecord) {
                completion(user, nil)
            } else {
                print("TKUserProfileController-update-Error: \(String(describing: error))")
                if let cloudError = error as? CKError, let tkError = TKError(ckError: cloudError) {
                    completion(nil, tkError)
                } else {
                    completion(nil, TKError.userCouldNotLoad)
                }
            }
        })
    }
}
