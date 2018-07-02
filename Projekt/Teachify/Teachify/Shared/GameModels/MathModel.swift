//
//  MathModel.swift
//  Teachify
//
//  Created by Philipp on 28.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct MathModel : Codable {
    var firstNumber : Int?
    var secondNumber : Int?
    var operation : String?
    var correctAnswer : Int?
    var falseAnswers : [Int]?
}
