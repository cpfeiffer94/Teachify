//
//  GameDetailTableDelegate.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 24.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameDetailTableDelegate: NSObject,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise :[Int : Int] = [0:indexPath.row]
        
        NotificationCenter.default.post(name: .setDetailedExercise, object: nil, userInfo: selectedExercise)
    }

}
