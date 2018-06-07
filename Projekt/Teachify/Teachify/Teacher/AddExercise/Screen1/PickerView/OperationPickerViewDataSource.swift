//
//  OperationPickerViewDataSource.swift
//  Teachify
//
//  Created by Philipp on 01.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class OperationPickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    var operations = ["Add", "Subtract", "Multiply", "Divide"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return operations.count
    }
}
