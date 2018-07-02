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
    @IBOutlet weak var exerciseName: UITextField!
    
    //MARK: Private Properties
    
    private var rangeDataSourceDelegate : RangePickerViewDataSourceDelegate!
    private var countExerciseDataSourceDelegate : CountExercisePickerViewDataSourceDelegate!
    private var mathExercises : [MathModel] = []
    
    //MARK: Public Properties
    
    var selectedClass: TKClass!
    var selectedSubject: TKSubject!
    var selectedGame: TKExerciseType!
    var selectedOperation: String!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeDataSourceDelegate = RangePickerViewDataSourceDelegate()
        setupRangeDataSourceDelegate()
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
        let lower = rangeDataSourceDelegate.from
        let upper = rangeDataSourceDelegate.to
        let count = countExerciseDataSourceDelegate.count
        
        for _ in 0..<count{
            addExercise(from: lower, to: upper)
        }
        
        print(mathExercises)
        uploadDocument()
    }
    
    private func addExercise(from lower : Int, to upper : Int){
        let firstNumber = createRandomNumber(from: lower, to: upper)
        let secondNumber = createRandomNumber(from: lower, to: upper)
        
        switch selectedOperation{
        case "Add":
            let falseAnswers = createFalseAnswers(from: firstNumber+secondNumber)
            let exercise = MathModel(firstNumber: firstNumber, secondNumber: secondNumber, operation: "+", correctAnswer: (firstNumber+secondNumber), falseAnswers: falseAnswers)
            mathExercises.append(exercise)
        case "Subtract":
            let falseAnswers = createFalseAnswers(from: firstNumber-secondNumber)
            let exercise = MathModel(firstNumber: firstNumber, secondNumber: secondNumber, operation: "-", correctAnswer: firstNumber-secondNumber, falseAnswers: falseAnswers)
            mathExercises.append(exercise)
        case "Multiply":
            let falseAnswers = createFalseAnswers(from: firstNumber*secondNumber)
            let exercise = MathModel(firstNumber: firstNumber, secondNumber: secondNumber, operation: "*", correctAnswer: (firstNumber*secondNumber), falseAnswers: falseAnswers)
            mathExercises.append(exercise)
        case "Divide":
            let falseAnswers = createFalseAnswers(from: firstNumber/secondNumber)
            let exercise = MathModel(firstNumber: firstNumber, secondNumber: secondNumber, operation: "/", correctAnswer: (firstNumber/secondNumber), falseAnswers: falseAnswers)
            mathExercises.append(exercise)
        default:
            let falseAnswers = createFalseAnswers(from: firstNumber+secondNumber)
            let exercise = MathModel(firstNumber: firstNumber, secondNumber: secondNumber, operation: "+", correctAnswer: (firstNumber+secondNumber), falseAnswers: falseAnswers)
            mathExercises.append(exercise)
        }
    }
    
    private func createFalseAnswers(from result : Int) -> [Int]{
        var falseAnswers : [Int] = []
        for _ in 0..<4{
            let lower = createRandomNumber(from: 0, to: 20)
            let upper = createRandomNumber(from: 0, to: 20)
            let first = result - lower
            let second = result + upper
            falseAnswers.append(createRandomNumber(from: first, to: second))
        }
        return falseAnswers
    }
    
    private func createRandomNumber(from lower : Int, to upper : Int) -> Int{
        let diff = upper - lower
        let randomNumber = Int(arc4random_uniform(UInt32(diff)))
        let randomToPass = randomNumber + lower
        return randomToPass
    }
    
    private func uploadDocument(){
        var doc = TKDocument(name: exerciseName.text!, deadline: nil)
        
        var exercises = [TKExercise]()
        
        for (i,exercise) in mathExercises.enumerated() {
            let data = try! JSONEncoder().encode(exercise)
            let dataString = String(data: data, encoding: .utf8)!
            var exercise = TKExercise(name: "\(doc.name)\(i)", deadline: nil, type: selectedGame, data: dataString)
            exercises.append(exercise)
        }
        
        var uploadCtrl = TKDocumentController()
        uploadCtrl.initialize(withRank: .teacher) { (success) in
            if let done = success{
                print("init uploadCtrl \(done)")
            }
        }
        var exerciseUploadCtrl = TKExerciseController()
        exerciseUploadCtrl.initialize(withRank: .teacher) { (success) in
            if let done = success{
                print("init ExerciseUploadCtrl \(done)")
            }
        }
        
        uploadCtrl.add(document: doc, toSubject: selectedSubject) { (document, error) in
            print(self.selectedSubject)
            exerciseUploadCtrl.create(exercises: exercises, toDocument: document!, completion: { (exercises, error) in
                if let newError = error {
                    print(newError)
                }else{
                    print("Upload success")
                }
            })
        }
    }
    
    private func setupRangeDataSourceDelegate(){
        if negativeResultsSwitch.isOn {
            rangeDataSourceDelegate.from = -50
            rangeDataSourceDelegate.to = -50
            rangeDataSourceDelegate.maxRange = 100
        }else{
            rangeDataSourceDelegate.from = 0
            rangeDataSourceDelegate.to = 0
            rangeDataSourceDelegate.maxRange = 50
        }
        rangeDataSourceDelegate.negativeResultsAllowed = negativeResultsSwitch.isOn
        rangePickerView.selectRow(0, inComponent: 0, animated: true)
        rangePickerView.selectRow(0, inComponent: 1, animated: true)
        rangePickerView.reloadAllComponents()
    }
    
    @IBAction func changedNegativeResultsAllowed(_ sender: Any) {
        setupRangeDataSourceDelegate()
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
