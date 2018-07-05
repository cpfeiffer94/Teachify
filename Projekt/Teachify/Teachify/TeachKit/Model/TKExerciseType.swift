//
//  TKExerciseType.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import UIKit

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
    
    var description: String {
        switch self {
        case .mathpiano: return "Finde die richtige Lösung bevor die Welle deine Badesachen wegspült."
        case .feedme: return "Füttere den süßen Drachen mit den richtigen Matheaufgaben, damit er groß und stark wird."
        case .teachbird: return "Leite den kleinen Teachbird durch die richtigen Englischaufgaben"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .mathpiano: return #imageLiteral(resourceName: "mathpiano_icon")
        case .feedme: return #imageLiteral(resourceName: "FeedMe-Drache")
        case .teachbird: return #imageLiteral(resourceName: "teachbird_icon")
        }
    }
    
    static var allExerciseTypes = [mathpiano, feedme, teachbird]
}
