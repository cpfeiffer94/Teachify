//
//  TKDocumentController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKDocumentController {

    // MARK: - Document Operations
    func fetchDocuments(forSubject subject: TKSubject,
                        withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                        completion: @escaping ([TKDocument], TKError?) -> ()) {
    }
    
    func add(document: TKDocument, toSubject subject: TKSubject, completion: @escaping (TKDocument?, TKError?) -> ()) {
        
    }
    
    func update(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
    }
    
    func delete(document: TKDocument, completion: @escaping (TKDocument?, TKError?) -> ()) {
    }
    
}









