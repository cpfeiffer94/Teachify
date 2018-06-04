//
//  AddExerciseFirstScreenViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseFirstScreenViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addExerciseFirstScreenCollectionView: UICollectionView!
    
    //MARK: DataSource/Delegates
    var subjectCollectionViewDelegate: AddExerciseSubjectCollectionViewDelegate!
    var subjectCollectionViewDataSource: AddExerciseSubjectCollectionViewDataSource!
    
    var operationPickerViewDelegate: OperationPickerViewDelegate!
    var operationPickerViewDataSource: OperationPickerViewDataSource!
    
    var gameCollectionViewDelegate: GameCollectionViewDelegate!
    var gameCollectionViewDataSource: GameCollectionViewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupData(){
        
        //NiBs
        addExerciseFirstScreenCollectionView.register(UINib(nibName: "AddSubjectReuseableCell", bundle: nil), forCellWithReuseIdentifier: "AddSubjectReuseableCell")
        gameCollectionView.register(UINib(nibName: "AddSubjectReuseableCell", bundle: nil), forCellWithReuseIdentifier: "AddSubjectReuseableCell")
        
        //DataSource/Delegates
        subjectCollectionViewDelegate = AddExerciseSubjectCollectionViewDelegate()
        subjectCollectionViewDataSource = AddExerciseSubjectCollectionViewDataSource()
        addExerciseFirstScreenCollectionView.delegate = subjectCollectionViewDelegate
        addExerciseFirstScreenCollectionView.dataSource = subjectCollectionViewDataSource
        
        operationPickerViewDelegate = OperationPickerViewDelegate()
        operationPickerViewDataSource = OperationPickerViewDataSource()
        pickerView.delegate = operationPickerViewDelegate
        pickerView.dataSource = operationPickerViewDataSource
        
        gameCollectionViewDelegate = GameCollectionViewDelegate()
        gameCollectionViewDataSource = GameCollectionViewDataSource()
        gameCollectionView.delegate = gameCollectionViewDelegate
        gameCollectionView.dataSource = gameCollectionViewDataSource
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
