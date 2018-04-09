//
//  TKSettingsController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation

struct TKSettingsController {
    
    // MARK: Request Permission
    func requestUserDiscoverabilityPermission() {
    }
    
    func requestNotificationPermission() {
    }
    
    
    // MARK: Document Subscription
    func addSubscription(toDocument document: TKDocument, hoursBeforeDeadline hours: Int) {
    }
    
    func removeSubscription(ofDocument document: TKDocument) {
    }
    
    
    // MARK: Subject Subscription
    func addSubscription(toSubject subject: TKSubject) {
    }
    
    func removeSubscription(ofSubject subject: TKSubject) {
    }
}
