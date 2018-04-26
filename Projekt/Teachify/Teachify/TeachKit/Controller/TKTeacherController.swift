//
//  TKTeacherController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

// ✅
struct TKTeacherController {
    
    var cloudCtrl = TKGenericCloudController<TKStudent>(zone: CKRecordZone.teachKitZone)
    
    // MARK: - Student Group Operations
    // ✅
    func fetchStudents(forTKClass tkClass: TKClass? = nil, withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                         completion: @escaping ([TKStudent], TKError?) -> ()) {
        
        var predicate = NSPredicate(format: "TRUEPREDICATE")
        if let classRecord = tkClass?.record {
            guard let classKey = tkClass?.recordTypeID else {
                completion([], nil)
                return
            }
            predicate = NSPredicate(format: "%K == %@", classKey, CKReference(record: classRecord, action: CKReferenceAction.none))
        }
        
        cloudCtrl.fetch(forRecordType: TKCloudKey.RecordType.students, withFetchSortOptions: fetchSortOptions, predicate: predicate) { (fetchedStudents, error) in
            completion(fetchedStudents, error)
        }
    }
    
    // ✅
    func update(student: TKStudent, completion: @escaping (TKStudent?, TKError?) -> ()) {
        cloudCtrl.update(object: student) { (updatedStudent, error) in
            completion(updatedStudent, error)
        }
    }
    
    // ✅
    func delete(student: TKStudent, completion: @escaping (TKError?) -> ()) {
        cloudCtrl.delete(object: student) { (error) in
            completion(error)
        }
    }
    
    // ✅ Wichtig: Mehrere Studenten können gleichzeit einer Klasse zugewiesen werden,
    //             aber ein Student, kann nicht gleichzeit mehreren Klassen zugewiesen werden
    //             --> "Server Record Changed"
    func add(student: TKStudent, toTKClass tkClass: TKClass, completion: @escaping (TKStudent?, TKError?) -> ()) {
        guard let recordTypeID = tkClass.recordTypeID else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        cloudCtrl.add(object: student, parentObject: tkClass,
                      withReferenceKey: recordTypeID, andAction: .none) { (updatedStudent, error) in
                        completion(updatedStudent, error)
        }
    }
    
    // ✅
    func create(student: TKStudent, completion: @escaping (TKStudent?, TKError?) -> ()) {
        cloudCtrl.create(object: student) { (createdStudent, error) in
            completion(createdStudent, error)
        }
    }
    
    // ✅
    func remove(student: TKStudent, fromClass tkClass: TKClass, completion: @escaping (TKStudent?, TKError?) -> ()) {
        guard let recordTypeID = tkClass.recordTypeID else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        cloudCtrl.remove(object: student, referenceKey: recordTypeID) { (updatedStudent, error) in
            completion(updatedStudent, error)
        }
    }
}








