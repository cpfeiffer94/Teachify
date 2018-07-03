//
//  GameDetailListDataSource.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 24.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameDetailListDataSource: NSObject, UITableViewDataSource {
    var exercises : [TKExercise]? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myExercises = exercises {
            return myExercises.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! GameDetailListTableViewCell
        
        if let myEx = exercises {
            cell.exerciseNameLabel.text = myEx[indexPath.row].name
            cell.exerciseCountLabel.text = ""
        }
        return cell
    }
    
    func setExercises(exc : [TKExercise]){
        exercises = exc
    }
}
