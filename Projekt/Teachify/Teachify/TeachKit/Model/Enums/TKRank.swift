//
//  TKRank.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

enum TKRank {
    case teacher
    case student
    
    var database: CKDatabase {
        switch self {
        case .teacher: return CKContainer.default().privateCloudDatabase
        case .student: return CKContainer.default().sharedCloudDatabase
        }
    }
}
