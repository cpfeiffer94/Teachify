//
//  GameLaunchController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class GameParamsSingleton {
    
    static let sharedInstance = GameParamsSingleton()
    
//    Instanzen der Spiel ViewController
    fileprivate var mathpianoVC  = MathPianoGameViewController()
    fileprivate var feedmeVC = FeedMeViewController()
    
//    Paramter der Spiele
    fileprivate var mathPianoParams : MathPianoParams
    fileprivate var feedmeParams : FeedMeParams
    
    
    
    
    private init (){
        mathPianoParams = MathPianoParams.init(param1: "Testrunde")
        feedmeParams = FeedMeParams.init(param1: "Testrunde")
    }
}

class GameLaunchController {
    let model = GameParamsSingleton.sharedInstance
    
    
    func getViewControllerForGame(game : TKExerciseType) -> UIViewController {
        switch game {
        case .mathpiano:
            return model.mathpianoVC
        case .wordTranslation:
            return model.mathpianoVC
        case .feedme:
            return model.feedmeVC
        }
    }
    
    func resetInstanceForGame(game : TKExerciseType){
        switch game {
        case .mathpiano:
            model.mathpianoVC = MathPianoGameViewController()
        case .feedme:
            model.feedmeVC = FeedMeViewController()
        case .wordTranslation:
            print("wordTranslation not implemented!")
        }
    }
    
    func getMathPianoParams() -> MathPianoParams {
        return model.mathPianoParams
    }
    
    func getFeedMeParams() -> FeedMeParams {
        return model.feedmeParams
    }
    
    func setMathPianoParams(newParams : MathPianoParams){
        model.mathPianoParams = newParams
    }
    
    func setFeedMeParams(newParams : FeedMeParams){
        model.feedmeParams = newParams
    }
    
}
