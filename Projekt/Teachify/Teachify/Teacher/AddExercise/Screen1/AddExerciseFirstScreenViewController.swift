//
//  AddExerciseFirstScreenViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseFirstScreenViewController: UIViewController, CVChangedSubject{
    
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
    
    var selectedClass : TKClass!
    
    @IBAction func goToDetailsScreen(_ sender: Any) {
        let selectedSubject = operationPickerViewDataSource.selectedSubject
        switch selectedSubject.name {
        case "English":
            performSegue(withIdentifier: "AddExercise2ExerciseDetails", sender: self)
        default:
            print("Mathe ist noch nicht verfügbar, siehe AddExerciseFirstScreenViewController")
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private func setupData(){
        
        //NiBs
        addExerciseFirstScreenCollectionView.register(UINib(nibName: "AddSubjectReuseableCell", bundle: nil), forCellWithReuseIdentifier: "AddSubjectReuseableCell")
        gameCollectionView.register(UINib(nibName: "AddSubjectReuseableCell", bundle: nil), forCellWithReuseIdentifier: "AddSubjectReuseableCell")
        
        //DataSource/Delegates
        subjectCollectionViewDelegate                   = AddExerciseSubjectCollectionViewDelegate()
        subjectCollectionViewDataSource                 = AddExerciseSubjectCollectionViewDataSource()
        subjectCollectionViewDataSource.subjects        = selectedClass.subjects
        addExerciseFirstScreenCollectionView.delegate   = subjectCollectionViewDelegate
        addExerciseFirstScreenCollectionView.dataSource = subjectCollectionViewDataSource
        
        
        operationPickerViewDelegate     = OperationPickerViewDelegate()
        operationPickerViewDataSource   = OperationPickerViewDataSource()
        pickerView.delegate             = operationPickerViewDelegate
        pickerView.dataSource           = operationPickerViewDataSource
        
        gameCollectionViewDelegate      = GameCollectionViewDelegate()
        gameCollectionViewDataSource    = GameCollectionViewDataSource()
        gameCollectionView.delegate     = gameCollectionViewDelegate
        gameCollectionView.dataSource   = gameCollectionViewDataSource
        
        
        subjectCollectionViewDelegate.delegate = self
    }
    
    
    func didChangeSubject(to subject: TKSubject) {
        operationPickerViewDataSource.selectedSubject = subject
        pickerView.setNeedsLayout()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddExercise2ExerciseDetails":
            let destVC = segue.destination as! EnglishVocabularyViewController
           
           
            if let indexPaths = addExerciseFirstScreenCollectionView.indexPathsForSelectedItems,
                let indexPath = indexPaths.first{
                destVC.selectedClass        = selectedClass
                destVC.selectedSubject      = selectedClass.subjects[indexPath.item]
                destVC.selectedGame         = TKExerciseType.allExerciseTypes[(gameCollectionView.indexPathsForSelectedItems?.first?.row)!]
                
                destVC.selectedOperation    = operationPickerViewDataSource.getSelectedOperations()[pickerView.selectedRow(inComponent: 0)]
            }
            
        default:
            return
        }
    }
    
    override func viewWillLayoutSubviews() {
        gameCollectionView.collectionViewLayout.invalidateLayout()
        gameCollectionView.layoutIfNeeded()
        addExerciseFirstScreenCollectionView.collectionViewLayout.invalidateLayout()
        addExerciseFirstScreenCollectionView.layoutIfNeeded()
        addExerciseFirstScreenCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
        gameCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    
}

protocol CVChangedSubject{
    func didChangeSubject(to subject:TKSubject)
}
