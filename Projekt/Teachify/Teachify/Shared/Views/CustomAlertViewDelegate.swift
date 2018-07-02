//
//  CustomAlertViewDelegate.swift
//  Teachify
//
//  Created by Philipp on 14.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate {
    func okButtonTapped( textFieldValue: String, subjectColor: TKColor, with caller : CustomAlertViewCallers)
    func cancelButtonTapped()
}
