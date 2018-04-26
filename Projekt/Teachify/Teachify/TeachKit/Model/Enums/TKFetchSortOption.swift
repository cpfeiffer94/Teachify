//
//  TKFetchSortOption.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

enum TKFetchSortOption {
    case creationDate
    case name
    case firstname
    case lastname
    
    var sortDescriptor: NSSortDescriptor {
        switch self {
        case .creationDate: return NSSortDescriptor(key: "creationDate", ascending: true)
        case .name: return NSSortDescriptor(key: "name", ascending: true)
        case .firstname: return NSSortDescriptor(key: "firstname", ascending: true)
        case .lastname: return NSSortDescriptor(key: "lastname", ascending: true)
        }
    }
}
