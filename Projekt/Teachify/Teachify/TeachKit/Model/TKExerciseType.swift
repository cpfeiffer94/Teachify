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
    case mathpiano
    case feedme
    case teachBird
    
    var name: String {
        switch self {
        case .wordTranslation: return "Word Translation"
        case .mathpiano: return "MathPiano"
        case .feedme: return "FeedMe"
        case .teachBird: return "TeachBird"
        }
    }
    
    var tkCloudKey: String {
        switch self {
        case .wordTranslation: return "wordTranslation"
        case .mathpiano: return "MathPiano"
        case .feedme: return "FeedMe"
        case .teachBird: return "TeachBird"
        }
    }
    
    init?(tkCloudKey: String) {
        switch tkCloudKey {
        case "wordTranslation": self = .wordTranslation
        case "MathPiano": self = .mathpiano
        default: return nil
        }
    }
    
    static var allExerciseTypes = [wordTranslation, mathpiano, feedme]
}
