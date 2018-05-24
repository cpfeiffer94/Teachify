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
    private var shareTitle: String = ""
    
    init(view: UIView) {
        self.view = view
    }
    
    
    func createCloudSharingController(forSubject subject: TKSubject,
                                      withShareOption shareOption: TKShareOption,
                                      completion: @escaping (UIViewController?, TKError?) -> ()) {
        
        guard let recordToShare = subject.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        shareTitle = subject.name
        
        switch shareOption {
        case .addParticipant:
            print("Cloud Add Participants")
            createAppleDefaultShareViewController(withSubject: subject, andRecordToShare: recordToShare) { (sharingVCtrl, error) in
                completion(sharingVCtrl, error)
            }
        case .removeParticipant:
//            let vCtrl = createViewController(withText: "Cloud Remove Participants")
//            vCtrl.view.backgroundColor = UIColor.white
//            completion(vCtrl, nil)
            createAppleDefaultRemoveParticipantsViewController(withSubject: subject) { (removeCtrl, error) in
                completion(removeCtrl, error)
            }
        }
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
    
    private func createAppleDefaultShareViewController(withSubject subject: TKSubject,
                                                       andRecordToShare recordToShare: CKRecord, completion: @escaping (UIViewController?, TKError?) -> ()) {
        let controller = UICloudSharingController { controller, preparationCompletionHandler in
            let share = CKShare(rootRecord: recordToShare)
            share.publicPermission = CKShareParticipantPermission.readWrite
            
            let configuration = CKOperationConfiguration()
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            
            let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [share, recordToShare], recordIDsToDelete: nil)
            modifyRecordsOperation.configuration = configuration
            modifyRecordsOperation.modifyRecordsCompletionBlock = { records, recordIDs, error in
                print("Sharing completion")
                
                if error != nil {
                    completion(nil, TKError.dooooImplement)
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
        
        let share = CKShare(rootRecord: subject.record!, shareID: (subject.record?.recordID)!)
        print("SHARRRERERERE", share.participants.count)
        
        completion(controller, nil)
    }
    
    private func createAppleDefaultRemoveParticipantsViewController(withSubject subject: TKSubject, completion: @escaping (UIViewController?, TKError?) -> ()) {
        guard let sharedReference = subject.record?.share else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        privateDatabase.fetch(withRecordID: sharedReference.recordID) { (sharedRecord, error) in
            if let error = error {
                completion(nil, TKError.dooooImplement)
            }
            
            if let sharedRecord = sharedRecord as? CKShare  {
                let controller = UICloudSharingController(share: sharedRecord, container: CKContainer.default())
                
                controller.popoverPresentationController?.sourceView = self.view
                controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                controller.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                controller.delegate = self
                
                completion(controller, nil)
            }
            
        }
        
        
        print("ENDE :)")
    }
    
//    private func fetchShare(fromMetadata metadata: CKShareMetadata) {
//        let operation = CKFetchRecordsOperation(recordIDs: [metadata.rootRecordID])
//
//        operation.perRecordCompletionBlock = { record, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            if let record = record {
//                print("Implement: Has fetched shared record :) - \(record)")
//            }
//        }
//
//        operation.fetchRecordsCompletionBlock = { _, error in
//            if let error = error {
//                print("Completion Error: \(error.localizedDescription)")
//            }
//
//        }
//
//        CKContainer.default().sharedCloudDatabase.add(operation)
//    }
}

extension TKShareController: UICloudSharingControllerDelegate {
    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("failedToSaveShareWithError: \(error)")
    }

    func itemTitle(for csc: UICloudSharingController) -> String? {
        return shareTitle
    }
    
    func cloudSharingControllerDidStopSharing(_ csc: UICloudSharingController) {
        print("Did Stop Sharing :)")
    }
}










