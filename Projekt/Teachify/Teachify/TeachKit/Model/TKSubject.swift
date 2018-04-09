//
//  TKSubject.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

struct TKSubject: TKCloudObject {
    var name: String
    var creationDate: Date?
    var color: TKColor
    var participants: [TKUser]
    var documentIDs: [String]
}
