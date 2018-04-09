//
//  TKShareController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import UIKit

struct TKShareController {
    
//    func createCloudSharingController(forSubject subject: TKSubject, withShareOption shareOption: TKShareOption) -> UICloudSharingController? {
    func createCloudSharingController(forSubject subject: TKSubject, withShareOption shareOption: TKShareOption) -> UIViewController {
        switch shareOption {
        case .addParticipant:
            let vCtrl = createViewController(withText: "Cloud Add Participants")
            vCtrl.view.backgroundColor = UIColor.white
            return vCtrl
        case .removeParticipant:
            let vCtrl = createViewController(withText: "Cloud Remove Participants")
            vCtrl.view.backgroundColor = UIColor.white
            return vCtrl
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
}
