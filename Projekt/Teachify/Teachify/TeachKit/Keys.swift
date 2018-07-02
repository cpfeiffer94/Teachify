//
//  Keys.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct TKCloudKey {
    private init() {}
    
    struct RecordType {
        private init() {}
        static let classes = "Classes"
        static let subjectes = "Subjects"
        static let students = "Students"
        static let documents = "Documents"
        static let exercises = "Exercises"
        static let solution = "Solutions"
    }
}
