//
//  ViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 05.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
//    Teacher Login Outlets
    @IBOutlet weak var teacherView: UIView!
    @IBOutlet weak var teacherIcon: UIImageView!
    @IBOutlet weak var teacherLabel: UILabel!
    
//    Student Login Outlets
    @IBOutlet weak var studentView: UIView!
    @IBOutlet weak var studentIcon: UIImageView!
    @IBOutlet weak var studentLabel: UILabel!
    
//    Debug Login Outlets
    @IBOutlet weak var debugView: UIView!
    @IBOutlet weak var debugIcon: UIImageView!
    @IBOutlet weak var debugLabel: UILabel!
    
//   Other View Elements
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var loginBackgroundView: UIView!
    @IBOutlet weak var teachifyTitleLabel: UILabel!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    
    
    var selectedRole : String = "student"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI(){
        studentView.layer.borderColor = UIColor.rgb(red: 6, green: 124, blue: 77).cgColor
        studentView.layer.borderWidth = 3.0
        
        teacherView.layer.borderColor = UIColor.rgb(red: 0, green: 94, blue: 111).cgColor
        teacherView.layer.borderWidth = 3.0
        
        debugView.layer.borderColor = UIColor.rgb(red: 124, green: 25, blue: 6).cgColor
        debugView.layer.borderWidth = 3.0
    
        //        setup Teacher View
        teacherView.backgroundColor = UIColor.white
        teacherIcon.image = UIImage(named: "icons8-floating_guru")
        teacherLabel.textColor = UIColor.black
        
        //        setup StudentView (selected)
        studentView.backgroundColor = UIColor.rgb(red: 6, green: 124, blue: 77)
        studentIcon.image = UIImage(named: "icons8-students_filled")
        studentLabel.textColor = UIColor.white
        
        //      setupDebugView
        debugView.backgroundColor = UIColor.white
        debugIcon.image = UIImage(named: "icons8-bug")
        debugLabel.textColor = UIColor.black
        
        loginBackgroundView.layer.cornerRadius = 30
        loginBackgroundView.layer.masksToBounds = true
        
        backgroundView.backgroundColor = UIColor.rgb(red: 5, green: 98, blue: 61)
        loginButtonOutlet.backgroundColor = UIColor.rgb(red: 200, green: 33, blue: 0)
        
        
        
        
    }
    @IBAction func teacherSelection(_ sender: Any) {
//        setup Teacher View (selected)
        teacherView.backgroundColor = UIColor.rgb(red: 0, green: 94, blue: 111)
        teacherIcon.image = UIImage(named: "icons8-floating_guru_filled")
        teacherLabel.textColor = UIColor.white
        
//        setup StudentView
        studentView.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        studentIcon.image = UIImage(named: "icons8-students")
        studentLabel.textColor = UIColor.black
        
//      setupDebugView
        debugView.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        debugIcon.image = UIImage(named: "icons8-bug")
        debugLabel.textColor = UIColor.black
        
        backgroundView.backgroundColor = UIColor.rgb(red: 0, green: 72, blue: 85)
        loginButtonOutlet.backgroundColor = UIColor.rgb(red: 187, green: 85, blue: 0)
        
        selectedRole = "teacher"
        
    }
    @IBAction func studentSelection(_ sender: Any) {
        //        setup Teacher View
        teacherView.backgroundColor = UIColor.white
        teacherIcon.image = UIImage(named: "icons8-floating_guru")
        teacherLabel.textColor = UIColor.black
        
        //        setup StudentView (selected)
        studentView.backgroundColor = UIColor.rgb(red: 6, green: 124, blue: 77)
        studentIcon.image = UIImage(named: "icons8-students_filled")
        studentLabel.textColor = UIColor.white
        
        //      setupDebugView
        debugView.backgroundColor = UIColor.white
        debugIcon.image = UIImage(named: "icons8-bug")
        debugLabel.textColor = UIColor.black
        
        backgroundView.backgroundColor = UIColor.rgb(red: 5, green: 98, blue: 61)
        loginButtonOutlet.backgroundColor = UIColor.rgb(red: 200, green: 33, blue: 0)
        
        selectedRole = "student"
        
    }
    @IBAction func debugSelection(_ sender: Any) {
        //        setup Teacher View
        teacherView.backgroundColor = UIColor.white
        teacherIcon.image = UIImage(named: "icons8-floating_guru")
        teacherLabel.textColor = UIColor.black
        
        //        setup StudentView
        studentView.backgroundColor = UIColor.white
        studentIcon.image = UIImage(named: "icons8-students")
        studentLabel.textColor = UIColor.black
        
        //      setupDebugView
        debugView.backgroundColor = UIColor.rgb(red: 124, green: 25, blue: 6)
        debugIcon.image = UIImage(named: "icons8-bug_filled")
        debugLabel.textColor = UIColor.white
        
        backgroundView.backgroundColor = UIColor.rgb(red: 98, green: 20, blue: 5)
        loginButtonOutlet.backgroundColor = UIColor.rgb(red: 0, green: 200, blue: 119)
        
        selectedRole = "debug"
    }
    
    @IBAction func loginAction(_ sender: Any) {
        switch selectedRole {
        case "student":
            let storyboard = UIStoryboard(name: StudentStoryboardID.class, bundle: nil)
            let studentMainMenuVCtrl = storyboard.instantiateViewController(withIdentifier: StudentStoryboardID.StudentMainMenuID)
            self.present(studentMainMenuVCtrl, animated: true)
        case "teacher":
            let storyboard = UIStoryboard(name: TeacherStoryboardID.´class´, bundle: nil)
            let teacherVC = storyboard.instantiateViewController(withIdentifier: TeacherStoryboardID.TeacherMainMenuID)
            self.present(teacherVC, animated: true)
        case "debug":
            let storyboard = UIStoryboard(name: CloudKitTestVC_ID.´class´, bundle: nil)
            let tkTestVC = storyboard.instantiateViewController(withIdentifier: CloudKitTestVC_ID.TKtestVCID)
            self.present(tkTestVC, animated: true)
            
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StudentLoginAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: StudentStoryboardID.class, bundle: nil)
        let StudentMainMenuVCtrl = storyboard.instantiateViewController(withIdentifier: StudentStoryboardID.StudentMainMenuID)
        self.present(StudentMainMenuVCtrl, animated: true)
    }
    
    @IBAction func TeacherLoginAction(_ sender: Any) {
    }
    
    @IBAction func unwindToLogin(_ sender: UIStoryboardSegue) {
        let sourceViewController = sender.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func ShowGame(_ sender: UIButton) {
        let gameVC = MathPianoGameViewController()
        self.present(gameVC,animated: true)
    }
    
    
    

}

