//
//  AppDelegate.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 05.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        askForUserPushNotifications(application: application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

// MARK: - TeachKit - Share
extension AppDelegate {
    func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShareMetadata) {
        let acceptSharesOperation = CKAcceptSharesOperation(shareMetadatas: [cloudKitShareMetadata])
        acceptSharesOperation.perShareCompletionBlock = { metadata, share, error in
            if error != nil {
                print("ERROR-AppDelegate-userDidAcceptCloudKitShareWith: \(error?.localizedDescription)")
            } else {
                self.fetchShare(fromMetadata: metadata)
            }
        }
        CKContainer(identifier: cloudKitShareMetadata.containerIdentifier).add(acceptSharesOperation)
    }
    
    private func fetchShare(fromMetadata metadata: CKShareMetadata) {
        let operation = CKFetchRecordsOperation(recordIDs: [metadata.rootRecordID])
        operation.perRecordCompletionBlock = { record, _, error in
            if let error = error {
                print("Fetch error: \(error)")
                return
            } else {
                print("Fetched successfully - \(record)")
                if let subject = TKSubject(record: record!) {
                    // TODO: ✅ sollen wir das neue geteilte Subject an das Model/Singleton schicken,
                    // damit dort der Rest nachgeladen werden kann???
                }
            }
        }
        CKContainer.default().sharedCloudDatabase.add(operation)
    }
}


// MARK: - TeachKit - Notifications
extension AppDelegate {
    func askForUserPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Push-Request-Success")
            } else {
                print("Push-Request-Error")
            }
        }
        
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let userInfo = userInfo as? [String:NSObject] {
            let notification: CKNotification = CKNotification(fromRemoteNotificationDictionary: userInfo)
            if notification.notificationType == CKNotificationType.query {
                let queryNotification = notification as! CKQueryNotification
                let recordID = queryNotification.recordID
                print("Record to fetch: \(recordID)")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registerd Successfully - \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\nSomething went wrong... \(error) \n")
    }
}



