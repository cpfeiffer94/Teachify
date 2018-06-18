//
//  TKSolutionList.swift
//  Teachify
//
//  Created by Philipp Knoblauch on 14.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import CloudKit

struct TKSolutionList: TKCloudObject {
    var creationDate: Date? {
        return record?.creationDate
    }

    var solutions: [TKSolution] {
        didSet {
            record?[CloudKey.solutions] = solutions as CKRecordValue
        }
    }
    
    var record: CKRecord?
    
    
    // MARK: - Initializer
    init(solutions: [TKSolution]) {
        self.solutions = solutions

    }
    
    init?(record: CKRecord) {
        guard let solutions = record[CloudKey.solutions] as? [TKSolution]
            else {
                return nil
        }
        
        self.solutions = solutions
        self.record = record
    }
    
    
    // MARK: Keys
    struct CloudKey {
        private init() {}
        static let solutions = "solutions"
        
        static let referenceToExercise = "exercise"
    }
}
