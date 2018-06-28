//
//  TKExerciseType.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

enum TKExerciseType {
    case mathpiano
    case feedme
    case teachbird
    
    var name: String {
        switch self {
        case .mathpiano: return "MathPiano"
        case .feedme: return "FeedMe"
        case .teachbird: return "TeachBird"
        }
    }
    
    var tkCloudKey: String {
        switch self {
        case .mathpiano: return "MathPiano"
        case .feedme: return "FeedMe"
        case .teachbird: return "TeachBird"
        }
    }
    
    init?(tkCloudKey: String) {
        switch tkCloudKey {
        case "MathPiano": self = .mathpiano
        case "FeedMe": self = .feedme
        case "TeachBird": self = .teachbird
        default: return nil
        }
    }
    
    static var allExerciseTypes = [mathpiano, feedme, teachbird]
}
