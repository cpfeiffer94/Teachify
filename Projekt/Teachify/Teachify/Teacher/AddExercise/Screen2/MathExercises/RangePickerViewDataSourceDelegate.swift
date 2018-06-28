//
//  RangePickerViewDataSourceDelegate.swift
//  Teachify
//
//  Created by Philipp on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class RangePickerViewDataSourceDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var from : Int = 0
    var to : Int = 0
    
    private let maxRange = 100
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return maxRange
        case 1:
            return maxRange
        default:
            return maxRange
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row - (maxRange/2))"
        case 1:
            return "\(row - (maxRange/2))"
        default:
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            from = row
        case 1:
            to = row
        default:
            return
        }
    }

}
