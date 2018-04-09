//
//  Others.swift
//  Teachify
//
//  Created by Marcel Hagmann on 09.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

protocol TKCloudObject {
    var name: String { get set }
    var creationDate: Date? { get set }
}


func randomDelay(completion: @escaping () -> Void) {
    let time: TimeInterval = Double(arc4random_uniform(4) + 1)
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}


struct TKStudent {
    var firstname: String?
    var lastname: String?
}

extension TKStudent: Equatable {
    static func == (lhs: TKStudent, rhs: TKStudent) -> Bool {
        return lhs.firstname == rhs.firstname && lhs.lastname == rhs.lastname
    }
}


enum TKShareOption {
    case addParticipant
    case removeParticipant
}
