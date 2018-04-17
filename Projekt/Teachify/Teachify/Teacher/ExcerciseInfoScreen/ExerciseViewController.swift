//
//  ExerciseViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 17.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet var customSegmentedControl: CustomSegmentedControl!
    @IBOutlet var pupilStatisticsTableView: UITableView!
    let pupilStatisticsDataSource = PupilStatisticsTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .teacherLightBlue
        navigationItem.prompt = " "
        customSegmentedControl.addTarget(action: didChangeIndex)
        pupilStatisticsTableView.dataSource = pupilStatisticsDataSource
    }

  
    func didChangeIndex(){
        print("Changed index \(customSegmentedControl.selectedSegmentIndex)")
    }
    
}
