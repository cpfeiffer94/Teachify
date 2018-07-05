//
//  NotificationNameExtension.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 23.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let launchGame =  Notification.Name("startGame")
    
    //TKDownloader finished Status
    static let showDebugModelPrint = Notification.Name("debugPrint")
    static let reloadGameCards = Notification.Name("reloadGameCards")
    
    static let excerciseLoaded = Notification.Name("exerciseLoaded")
    static let userNameLoaded = Notification.Name("userName")
    static let exerciseSelected = Notification.Name("exerciseSelected")
    static let setDetailedExercise = Notification.Name("setDetailedDocument")
    
    
}

