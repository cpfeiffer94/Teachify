//
//  TKExercise.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

struct TKExercise: TKCloudObject {
    var name: String
    var creationDate: Date?
    var hint: String
    var type: TKExerciseType
    var deadline: Date?
    var answers: [String]
    var questions: [String]
}
