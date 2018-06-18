//
//  VocabularyModel.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct VocabularyModel: Codable {
    var word : String?
    var correctAnswer : String?
    var falseAnswers : [String?]?
}
