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

        //navigationController?.navigationBar.barTintColor = .teacherLightBlue
        //navigationItem.prompt = " "
        customSegmentedControl.addTarget(action: didChangeIndex)
        customSegmentedControl.register(UINib(nibName: String(describing: SegmentCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: "segmentCell")
        customSegmentedControl.dataSource = customSegmentedControlDataSource
        pupilStatisticsTableView.dataSource = pupilStatisticsDataSource
        customSegmentedControl.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
        
    }

  
    func didChangeIndex(){
        print("Changed index \(customSegmentedControl.selectedSegmentIndex)")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.navigationController?.navigationBar.barTintColor = .teacherLightBlue
            self.navigationController?.navigationBar.layoutIfNeeded()
            self.customSegmentedControl.backgroundColor = .teacherLightBlue
            self.customSegmentedControl.layoutIfNeeded()

        }
    }
}
