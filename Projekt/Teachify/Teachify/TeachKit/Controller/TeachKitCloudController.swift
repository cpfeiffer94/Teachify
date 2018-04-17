//
//  TeachKitCloudController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

protocol TeachKitCloudController {
}

extension TeachKitCloudController {
    func fetchTeachKitRecordZone(completion: @escaping (CKRecordZone?, TKError?) -> ()) {
        CKContainer.default().privateCloudDatabase.fetchAllRecordZones { (recordZones, error) in
            guard let recordZones = recordZones else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            let classRecordZones = recordZones.compactMap { $0.zoneID.zoneName == CKRecordZone.teachKitZone.zoneID.zoneName ? $0 : nil }
            guard let classRecordZone = classRecordZones.first else {
                completion(nil, TKError.dooooImplement)
                return
            }
            
            completion(classRecordZone, nil)
        }
    }
}
