//
//  TKClassController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKClassController {
    private let container = CKContainer.default()
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
    // MARK: - Class Operations
    func fetchDirectories(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKClass], TKError?) -> ()) {
    }
    
    func create(class: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
    }
    
    func update(class: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
    }
    
    func delete(class: TKClass, completion: @escaping (TKError?) -> ()) {
    }
    
    
    // MARK: - Subject Operations
    func fetchSubject(forClass: TKClass,
                      withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKSubject], TKError?) -> ()) {
        
    }
    
    func create(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
    }
    
    func update(subject: TKSubject, completion: @escaping (TKSubject?, TKError?) -> ()) {
    }
    
    func delete(subject: TKSubject, completion: @escaping (TKSubject) -> ()) {
    }
}
