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
    fileprivate var followTheOrderVC = FollowTheOrderGameViewController()
    fileprivate var mathpianoVC  = MathPianoGameViewController()
    
//    Paramter der Spiele
    fileprivate var followTheOrderParams : FollowTheOrderParams
    fileprivate var mathPianoParams : MathPianoParams
    
    
    
    
    private init (){
        followTheOrderParams = FollowTheOrderParams.init(param1: "Testrunde")
        mathPianoParams = MathPianoParams.init(param1: "Testrunde")
    }
}

class GameLaunchController {
    let model = GameParamsSingleton.sharedInstance
    
    
    func getViewControllerForGame(game : GameEnum) -> UIViewController {
        switch game {
        case .followTheOrder:
            return model.followTheOrderVC
        case .mathPiano:
            return model.mathpianoVC
        }
    }
    
    func resetInstanceForGame(game : GameEnum){
        switch game {
        case .followTheOrder:
            model.followTheOrderVC = FollowTheOrderGameViewController()
        case .mathPiano:
            model.mathpianoVC = MathPianoGameViewController()
        }
    }
    
    func getFTRParams() -> FollowTheOrderParams{
        return model.followTheOrderParams
    }
    
    func getMathPianoParams() -> MathPianoParams {
        return model.mathPianoParams
    }
    
    func setFTRParams(newParams : FollowTheOrderParams) {
        model.followTheOrderParams = newParams
    }
    
    func setMathPianoParams(newParams : MathPianoParams){
        model.mathPianoParams = newParams
    }
    
}
