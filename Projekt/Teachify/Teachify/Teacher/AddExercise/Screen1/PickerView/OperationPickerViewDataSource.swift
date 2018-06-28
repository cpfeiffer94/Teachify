//
//  OperationPickerViewDataSource.swift
//  Teachify
//
//  Created by Philipp on 01.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class OperationPickerViewDataSource: NSObject, UIPickerViewDataSource{
  
    var selectedSubject : TKSubject = TKSubject(name: "Math",color: TKColor.yellow)
    var selectedOperation : String = ""
    var subjectTypes = ["Math", "English"]
    
    let operationsMath = ["Add", "Subtract", "Multiply", "Divide"]
    let operationsEnglish = ["Vocabulary", "Grammar", "Synonyms"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return subjectTypes.count
        }else{
            return getSelectedOperations().count
        }
    }
    
    func getSelectedOperations() -> [String]{
        switch selectedSubject.name {
        case "Math":
            return operationsMath
        case "English":
            return operationsEnglish
        default:
            return []
        }
    }
    
    
}
