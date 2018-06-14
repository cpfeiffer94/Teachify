//
//  EnglishVocabularyViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 07.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class EnglishVocabularyViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet var word: UITextField!
    @IBOutlet var correctAnswer: UITextField!
    @IBOutlet var falseAnswer1: UITextField!
    @IBOutlet var falseAnswer2: UITextField!
    @IBOutlet var falseAnswer3: UITextField!
    @IBOutlet var exerciseName: UITextField!
    
    //MARK: Variables
    private var vocabularyBook = [VocabularyModel]()
    var selectedClass: TKClass!
    var selectedSubject: TKSubject!
    var selectedGame: TKExerciseType!
    var selectedOperation: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup stuff
        word.clearButtonMode = UITextFieldViewMode.always
    }


    //MARK: IBActions


    @IBAction func saveAndContinueToNext(_ sender: Any) {
        let falseAnswers = [falseAnswer1.text, falseAnswer2.text, falseAnswer3.text]
        vocabularyBook.append(VocabularyModel(word: word.text, correctAnswer: correctAnswer.text, falseAnswers: falseAnswers))
        word.text           = ""
        correctAnswer.text  = ""
        falseAnswer1.text   = ""
        falseAnswer2.text   = ""
        falseAnswer3.text   = ""
        
    }
    
    func acceptAnswer() {
        var doc = TKDocument(name: exerciseName.text!, deadline: nil)
        
        var exercises = [TKExercise]()
        
        for (i,exercise) in vocabularyBook.enumerated() {
            let data = try! JSONEncoder().encode(exercise)
            let dataString = String(data: data, encoding: .utf8)!
            let exercise = TKExercise(name: "\(doc.name)\(i)", deadline: nil, type: selectedGame, data: dataString)
            exercises.append(exercise)
        }
        
        var uploadCtrl = TKDocumentController()
        uploadCtrl.initialize(withRank: .teacher) { (success) in
            print("init uploadCtrl \(success)")
        }
        var exerciseUploadCtrl = TKExerciseController()
        exerciseUploadCtrl.initialize(withRank: .teacher) { (success) in
            print("init ExerciseUploadCtrl \(success)")
        }
        
        uploadCtrl.add(document: doc, toSubject: selectedSubject) { (document, error) in
            print(self.selectedSubject)
            exerciseUploadCtrl.create(exercises: exercises, toDocument: document!, completion: { (exercises, error) in
                print("Upload success")
            })
        }

    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        acceptAnswer()
    }
    
}
