//
//  TKExerciseType.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

enum TKExerciseType {
    case wordTranslation
    
    var name: String {
        switch self {
        case .wordTranslation: return "Word Translation"
        }
    }
    
    var tkCloudKey: String {
        switch self {
        case .wordTranslation: return "wordTranslation"
        }
    }
    
    init?(tkCloudKey: String) {
        switch tkCloudKey {
        case "wordTranslation": self = .wordTranslation
        default: return nil
        }
    }
    
    static var allExerciseTypes = [TKExerciseType.wordTranslation]
}
