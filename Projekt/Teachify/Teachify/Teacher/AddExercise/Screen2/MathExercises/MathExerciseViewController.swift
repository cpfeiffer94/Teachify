//
//  MathExerciseViewController.swift
//  Teachify
//
//  Created by Philipp on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class MathExerciseViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var rangePickerView: UIPickerView!
    @IBOutlet weak var countExercisePickerView: UIPickerView!
    @IBOutlet weak var negativeResultsSwitch: UISwitch!
    
    //MARK: Private Properties
    
    private var rangeDataSourceDelegate : RangePickerViewDataSourceDelegate!
    private var countExerciseDataSourceDelegate : CountExercisePickerViewDataSourceDelegate!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeDataSourceDelegate = RangePickerViewDataSourceDelegate()
        rangePickerView.dataSource = rangeDataSourceDelegate
        rangePickerView.delegate = rangeDataSourceDelegate
        
        countExerciseDataSourceDelegate = CountExercisePickerViewDataSourceDelegate()
        countExercisePickerView.dataSource = countExerciseDataSourceDelegate
        countExercisePickerView.delegate = countExerciseDataSourceDelegate
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMathExercise(_ sender: Any) {
        createRandomExercises()
    }
    
    private func createRandomExercises(){
        let from = rangeDataSourceDelegate.from
        let to = rangeDataSourceDelegate.to
        let count = countExerciseDataSourceDelegate.count   
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
