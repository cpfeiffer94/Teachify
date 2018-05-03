//
//  TKShareController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class TKShareController: NSObject {
    private let privateDatabase = CKContainer.default().privateCloudDatabase
    private weak var view: UIView!
    
    init(view: UIView) {
        self.view = view
    }
    
//    func createCloudSharingController(forSubject subject: TKSubject, withShareOption shareOption: TKShareOption) -> UICloudSharingController? {
    func createCloudSharingController(forSubject subject: TKSubject,
                                      withShareOption shareOption: TKShareOption,
                                      completion: @escaping (UIViewController?, TKError?) -> ()) {
        
        guard let recordToShare = subject.record else {
            print("doooImplement")
            return
        }
        
        switch shareOption {
        case .addParticipant:
            print("Cloud Add Participants")
            let vCtrl = createAppleDefaultShareViewController(withSubject: subject, andRecordToShare: recordToShare)
            completion(vCtrl, nil)
        case .removeParticipant:
            let vCtrl = createViewController(withText: "Cloud Remove Participants")
            vCtrl.view.backgroundColor = UIColor.white
            completion(vCtrl, nil)
        }
        
        completion(nil, TKError.dooooImplement)
    }
    
    private func createViewController(withText text: String) -> UIViewController {
        let vCtrl = UIViewController()
        let frame = vCtrl.view.frame
        let label = UILabel(frame: frame)
        label.text = text
        label.textAlignment = .center
        vCtrl.view.addSubview(label)
        return vCtrl
    }
    
    private func createAppleDefaultShareViewController(withSubject subject: TKSubject, andRecordToShare recordToShare: CKRecord) -> UIViewController {
        let controller = UICloudSharingController { controller, preparationCompletionHandler in
            
            let share = CKShare(rootRecord: recordToShare)
            share[CKShareTitleKey] = "Hello world! :)" as CKRecordValue
            share.publicPermission = .readOnly
            
            let configuration = CKOperationConfiguration()
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            
            let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [share, recordToShare], recordIDsToDelete: nil)
            modifyRecordsOperation.configuration = configuration
            modifyRecordsOperation.modifyRecordsCompletionBlock = { records, recordIDs, error in
                print("Sharing completion")
                
                if error != nil {
                    print("ERROR APPEARD WHILE SHARING... \(error)")
                }
                
                preparationCompletionHandler(share, CKContainer.default(), error)
            }
            
            self.privateDatabase.add(modifyRecordsOperation)
            
        }
        
        controller.availablePermissions = [.allowPublic, .allowReadWrite]
        controller.popoverPresentationController?.sourceView = view
        controller.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        controller.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        controller.delegate = self
        
        return controller
    }
    
    private func share(subject: TKSubject) {
        guard let recordToShare = subject.record else {
            print("doooImplement")
            return
        }
        
        let share = CKShare(rootRecord: recordToShare)
        share[CKShareTitleKey] = subject.name as CKRecordValue
        share.publicPermission = .readWrite
        
        let configuration = CKOperationConfiguration()
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        
        let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [share, recordToShare], recordIDsToDelete: nil)
        modifyRecordsOperation.configuration = configuration
        modifyRecordsOperation.completionBlock = {
            print("Sharing completion")
        }
        
        privateDatabase.add(modifyRecordsOperation)
    }
    
    private func fetchShare(fromMetadata metadata: CKShareMetadata) {
        let operation = CKFetchRecordsOperation(recordIDs: [metadata.rootRecordID])
        
        operation.perRecordCompletionBlock = { record, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let record = record {
                print("Implement: Has fetched shared record :) - \(record)")
            }
        }
        
        operation.fetchRecordsCompletionBlock = { _, error in
            if let error = error {
                print("Completion Error: \(error.localizedDescription)")
            }
            
        }
        
        CKContainer.default().sharedCloudDatabase.add(operation)
    }
}

extension TKShareController: UICloudSharingControllerDelegate {
    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("failedToSaveShareWithError: \(error)")
    }
    
    func itemTitle(for csc: UICloudSharingController) -> String? {
        print("itemTitle")
        return nil
    }
}










