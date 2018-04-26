//
//  TKClassController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit


// ✅
struct TKClassController {
    
    var cloudCtrl = TKGenericCloudController<TKClass>(zone: CKRecordZone.teachKitZone)
    
    // MARK: - Class Operations
    // ✅
    func fetchClasses(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                      completion: @escaping ([TKClass], TKError?) -> ()) {
        
        let recordType = TKCloudKey.RecordType.classes
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        cloudCtrl.fetch(forRecordType: recordType, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedClasses, error) in
            completion(fetchedClasses, error)
        }
    }
    
    // ✅
    func create(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        cloudCtrl.create(object: tkClass) { (tkClass, error) in
            completion(tkClass, error)
        }
    }
    
    // TODO: ✅ werfe ein ERROR, wenn --> Record noch nicht vorhanden!
    // ✅
    func update(tkClass: TKClass, completion: @escaping (TKClass?, TKError?) -> ()) {
        cloudCtrl.update(object: tkClass) { (tkClass, error) in
            completion(tkClass, error)
        }
    }
    
    // ✅
    func delete(tkClass: TKClass, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: tkClass) { (error) in
            completion(error)
        }
    }
}
