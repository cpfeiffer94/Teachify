//
//  ViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 05.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func ShowGame(_ sender: UIButton) {
        let gameVC = GameViewController()
        self.present(gameVC,animated: true)
    }
    
    
    

}

