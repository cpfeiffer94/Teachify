//
//  CustomAlertViewDelegate.swift
//  Teachify
//
//  Created by Philipp on 14.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

protocol CustomAlertViewDelegate {
    func okButtonTapped( textFieldValue: String, with caller : CustomAlertViewCallers)
    func cancelButtonTapped()
}
