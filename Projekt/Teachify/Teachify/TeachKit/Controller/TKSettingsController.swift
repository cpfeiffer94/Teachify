//
//  TKSettingsController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKSettingsController {
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    
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
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let subscription = CKQuerySubscription(recordType: TKCloudKey.RecordType.subjectes,
                                               predicate: predicate, options: .firesOnRecordCreation)
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "Es wurde ein neues Fach angelegt, öffne die App und schaue nach :)"
        notificationInfo.shouldBadge = true
        
        subscription.notificationInfo = notificationInfo
        privateDatabase.save(subscription) { (savedSubscription, error) in
            if let error = error {
                print("Subscription-Error: \(error.localizedDescription)")
            } else {
                print("Subscription erfolgreich angelegt :)")
            }
        }
    }
    
    func removeSubscription(ofSubject subject: TKSubject) {
    }
}
