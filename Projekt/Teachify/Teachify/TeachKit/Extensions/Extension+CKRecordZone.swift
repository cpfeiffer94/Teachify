//
//  Extension+CKRecordZone.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecordZone {
    
    static var teachKitZone: CKRecordZone {
        return CKRecordZone(zoneName: "ClassZoneID")
    }
}
