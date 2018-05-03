//
//  ExerciseViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 17.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ExerciseInfoViewController: UIViewController {

    @IBOutlet var customSegmentedControl: CustomSegmentedControl!
    @IBOutlet var pupilStatisticsTableView: UITableView!
    let pupilStatisticsDataSource = PupilStatisticsTableViewDataSource()
    fileprivate let customSegmentedControlDataSource = CustomSegmentedControlDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .teacherLightBlue
        navigationItem.prompt = " "
        customSegmentedControl.addTarget(action: didChangeIndex)
        customSegmentedControl.dataSource = customSegmentedControlDataSource
        pupilStatisticsTableView.dataSource = pupilStatisticsDataSource
        
    }

  
    func didChangeIndex(){
        print("Changed index \(customSegmentedControl.selectedSegmentIndex)")
    }
    
}
