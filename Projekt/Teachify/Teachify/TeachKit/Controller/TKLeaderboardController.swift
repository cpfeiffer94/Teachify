//
//  TKLeaderboardController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKLeaderboardController {
//    private var offlineCloud = OfflineCloud.server
    
    func fetchLeaderboard(forExerciseTyp exerciseType: TKExerciseType, withRange range: NSRange, completion: @escaping ([TKLeaderboardEntry], TKError?) -> ()) {
//        randomDelay {
//            if let leaderboard = self.offlineCloud.leaderboards[exerciseType] {
//                let numberOfEntries = leaderboard.count
//                if (range.lowerBound + range.length) > numberOfEntries {
//                    completion([], TKError.rangeOutOfBounds)
//                } else {
//                    var leaderboardEntries: [TKLeaderboardEntry] = []
//                    for score in leaderboard[range.lowerBound..<range.upperBound] {
//                        let dummyRecordID = CKRecordID(recordName: "Leaderboard")
//                        let entry = TKLeaderboardEntry(score: score.scoreValue, user: dummyRecordID, creationDate: Date())
//                        leaderboardEntries.append(entry)
//                    }
//                    completion(leaderboardEntries, nil)
//                }
//            }
//        }
    }
    
    func save(score: TKScore, completion: @escaping (TKScore, TKError?) -> ()) {
//        randomDelay {
//            self.offlineCloud.leaderboards[score.exerciseType]?.append(score) // vlt. TKLeaderboardEntry <--> TKScore | als eine Klasse?
//            self.offlineCloud.sortLeaderboard(forExerciseType: score.exerciseType)
//            completion(score, nil)
//        }
    }
    
    
}
