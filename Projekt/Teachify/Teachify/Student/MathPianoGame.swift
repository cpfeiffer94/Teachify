//
//  MathPianoGame.swift
//  Teachify
//
//  Created by Johannes Franz on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoGame : NSObject, Codable {
    
    var gameQuestions : [MathPianoQuestionModel]
    var lifes : Int
    var currentQuestionPointer: Int
        
    
    init(gameQuestions : [MathPianoQuestionModel], lifes : Int) {
        self.gameQuestions = gameQuestions
        self.lifes = lifes
        self.currentQuestionPointer = 0
    }
    
    func toJSON() -> String {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
        
            return String(data: data, encoding: .utf8)!
        
        } catch {
            print("toJSON error")
            fatalError()
        }
    }
    
    func fromJSON(jsonStr : String) {
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MathPianoGame.self, from: jsonStr.data(using: .utf8)!)
            gameQuestions = data.gameQuestions
            lifes = data.lifes
        } catch {
            print("fromJSON error")
            fatalError()
        }
    }
}
