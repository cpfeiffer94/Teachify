//
//  GameLaunchController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class GameController : NSObject {
    
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
            mathpianoVC = MathPianoGameViewController()
            return mathpianoVC
        case .feedme:
            feedmeVC = FeedMeViewController()
            return feedmeVC
        case .teachbird:
            teachBirdVC = TeachBirdViewController()
            return teachBirdVC
        }
    }
    
    func setExercisesForGame(game: TKExerciseType, exercises: [TKExercise]){
        switch game {
        case .mathpiano:
            mathPianoCtrl.setExercises(exercises: exercises)
        case .feedme:
            feedmeCtrl.setExercises(exercises: exercises)
        case .teachbird:
            teachbirdCtrl.setExercises(exercises: exercises)
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
