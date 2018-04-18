//
//  TKExercise.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKExercise: TKCloudObject {
    var name: String
    var creationDate: Date?
    var type: TKExerciseType
    var deadline: Date?
    var data: String
    var record: CKRecord?
    
    init?(record: CKRecord) {
        return nil
    }
}
