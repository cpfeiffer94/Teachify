//
//  MathPianoGameFeedbackModel.swift
//  Teachify
//
//  Created by Normen Krug on 11.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class MathPianoGameFeedbackModel: NSObject, Codable{
    
    var userAnswer: [String]!
    var pianoModel: MathPianoGame!
    
    init(gameModel: MathPianoGame, userAnswer: [String]) {
        self.pianoModel = gameModel
        self.userAnswer = userAnswer
    }
    
    func toJSON() -> String{
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)!
            
        } catch {
            print("toJSON error")
            fatalError()
        }
    }
    
    func fromJSON(fromStr: String){
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MathPianoGameFeedbackModel.self, from: fromStr.data(using: .utf8)!)
            pianoModel = data.pianoModel
            userAnswer = data.userAnswer
        } catch {
            print("fromJSON error")
            fatalError()
        }
    }
    
    
}
