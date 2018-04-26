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
    }
    
    private func fetchUserRecord(forRecordID recordID: CKRecordID, completion: @escaping (TKUser?, TKError?) -> ()) {
    }
    
    func update(user: TKUser, completion: @escaping (TKUser?, TKError?) -> ()) {
    }
}
