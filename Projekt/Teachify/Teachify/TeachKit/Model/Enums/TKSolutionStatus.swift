//
//  TKSolutionStatus.swift
//  Teachify
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

enum TKSolutionStatus: Int, Codable {
    case correct
    case wrong
    case unreviewed
    
    init?(tkCloudKey: String) {
        switch tkCloudKey {
        case "correct": self = .correct
        case "wrong": self = .wrong
        case "unreviewed": self = .unreviewed
        default: return nil
        }
    }
    
    var tkCloudKey: String {
        switch self {
        case .correct: return "correct"
        case .wrong: return "wrong"
        case .unreviewed: return "unreviewed"
        }
    }
}
