//
//  OperationPickerViewDelegate.swift
//  Teachify
//
//  Created by Philipp on 01.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class OperationPickerViewDelegate: NSObject, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dataSource = pickerView.dataSource as! OperationPickerViewDataSource
        return dataSource.operations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
