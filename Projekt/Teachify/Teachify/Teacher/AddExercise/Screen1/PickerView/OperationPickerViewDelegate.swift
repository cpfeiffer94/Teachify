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
        if component == 0 {
          return dataSource.subjectTypes[row]
        }
        
        return dataSource.getSelectedOperations()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dataSource = pickerView.dataSource as! OperationPickerViewDataSource
        if component == 0 {
            dataSource.selectedSubject = TKSubject(name: dataSource.subjectTypes[row], color: .black)
            pickerView.reloadComponent(1)
        }
        if component == 1{
            dataSource.selectedOperation = dataSource.getSelectedOperations()[row]
        }
    }
}
