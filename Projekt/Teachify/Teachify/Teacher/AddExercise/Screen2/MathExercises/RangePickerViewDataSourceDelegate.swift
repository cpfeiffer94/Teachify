//
//  RangePickerViewDataSourceDelegate.swift
//  Teachify
//
//  Created by Philipp on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

typealias dataSourceDelegate = UIPickerViewDelegate & UIPickerViewDataSource

//MARK: Do not debug - it`s impossible
class RangePickerViewDataSourceDelegate: NSObject, dataSourceDelegate{
    
    var from : Int = -50
    var to : Int = -50
    var negativeResultsAllowed = true
    
    var maxRange = 100
    
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
            if negativeResultsAllowed{
                return "\(row - (maxRange/2))"
            }
            return "\(row)"
        case 1:
            if negativeResultsAllowed{
                return "\(row - (maxRange/2))"
            }
            return "\(row+1)"
        default:
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if negativeResultsAllowed{
                //left component, not last row and negative results are allowed
                if row > pickerView.selectedRow(inComponent: 1) && row != maxRange-1{
                    pickerView.selectRow(row+1, inComponent: 1, animated: true)
                    to = (row+1 - maxRange/2)
                }
                //left component, last row and negative results are allowed
                if row == maxRange-1{
                    pickerView.selectRow(maxRange-1, inComponent: 1, animated: true)
                    to = (maxRange/2)
                }
                //sets own row value
                from = (row - maxRange/2)
                
            }else{
                //left component and negative results are not allowed
                if row > pickerView.selectedRow(inComponent: 1){
                    pickerView.selectRow(row, inComponent: 1, animated: true)
                    to = row+1
                }
                //sets own row value
                from = row
            }
        case 1:
            if negativeResultsAllowed{
                //right component, not first row and negative results are allowed
                if row < pickerView.selectedRow(inComponent: 0) && row != 0{
                    pickerView.selectRow(row-1, inComponent: 0, animated: true)
                    from = (row-1 - maxRange/2)
                }
                //right component, first row and negatives results are allowed
                if row == 0{
                    pickerView.selectRow(row, inComponent: 0, animated: true)
                    from = (row - maxRange/2)
                }
                //sets own row value
                to = (row - maxRange/2)
                
            }
            
            else{
                //right component and negative results are not allowed
                if row < pickerView.selectedRow(inComponent: 0){
                    pickerView.selectRow(row, inComponent: 0, animated: true)
                    from = row
                }
                //sets own row value
                to = row+1
            }
        default:
            return
        }
    }

}
