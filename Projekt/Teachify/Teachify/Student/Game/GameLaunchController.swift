//
//  GameLaunchController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class GameLaunchController : NSObject {
    
    //    Instanzen der Spiel ViewController
    var mathpianoVC  = MathPianoGameViewController()
    var feedmeVC = FeedMeViewController()
    var teachBirdVC = TeachBirdViewController()
    
    //    Singleton Klassen in der die Exercises der Spiele gehalten werden
    var mathPianoCtrl = MathPianoExerciseController()
    var feedmeCtrl = FeedMeExerciseController()
    var teachbirdCtrl = TeachBirdExerciseController()
    
    
    func getViewControllerForGame(game : TKExerciseType) -> UIViewController {
        switch game {
        case .mathpiano:
            return mathpianoVC
        case .feedme:
            return feedmeVC
        case .teachbird:
            return teachBirdVC
        }
    }
    
    func resetInstanceForGame(game : TKExerciseType){
        switch game {
        case .mathpiano:
            mathpianoVC = MathPianoGameViewController()
        case .feedme:
            feedmeVC = FeedMeViewController()
        case .teachbird:
            teachBirdVC = TeachBirdViewController()
        }
    }
    
    
    
}
