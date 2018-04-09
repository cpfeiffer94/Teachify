//
//  TKLeaderboardEntry.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKLeaderboardEntry {
    var score: Int
    var user: CKRecordID
    var creationDate: Date?
}
