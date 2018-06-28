//
//  TestUserCK.swift
//  Teachify
//
//  Created by Normen Krug on 24.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

enum ICloudUserIDResponse {
    case success(record: CKRecordID)
    case failure(error: Error)
    case notSignedIn(accountStatus: CKAccountStatus)
}

class ICloudUserIDProvider: NSObject {
    
    var username = "Peter Zweggat"{
        didSet{
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("userName"), object: nil)
        }
    }
    
    class func getUserID(completion: @escaping (_ response: ICloudUserIDResponse) -> ()) {
        let container = CKContainer.default()
        
        container.accountStatus() { accountStatus, error in
            if accountStatus == .available {
                container.fetchUserRecordID() { recordID, error in
                    guard let recordID = recordID else {
                        
                        let error = error ?? NSError(domain: "", code: 0, userInfo: nil)
                        completion(.failure(error: error))
                        return
                    }
                    completion(.success(record: recordID))
                }
            }
            else {
                completion(.notSignedIn(accountStatus: accountStatus))
            }
        }
    }
    func request(){
        
        ICloudUserIDProvider.getUserID() { response in
            
            switch response {
            case .success(let record):
                print("recordName: \(record.recordName)")
                let container = CKContainer.default()
                container.discoverUserIdentity(withUserRecordID: record) { (info, fetchError) in
                    self.username = (info!.nameComponents!.givenName! + " " + info!.nameComponents!.familyName!)
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            case .notSignedIn(_):
                print("please sign in to iCloud")
            }
        }
    }
}


