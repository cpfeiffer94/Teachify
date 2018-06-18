//
//  StudenMainMenuViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 08.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class StudentMainMenuViewController: UIViewController {
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var openExercisesLabel: UILabel!
    @IBOutlet weak var solvedExercisesLabel: UILabel!
    @IBOutlet weak var teachifyProgressLabel: UILabel!
    @IBOutlet weak var studentProfileImage: UIImageView!
    @IBOutlet weak var noExerciseStackView: UIStackView!
    
    let collectionDS = GameCollectionDataSource()
    let collectionDel = GameCollectionDelegate()
    let tkfetchctrl = TKFetchController()
    let gamecontroller = GameLaunchController()
    
    override func viewDidLoad() {
        gameCollectionView.dataSource = collectionDS
        gameCollectionView.delegate = collectionDel
        tkfetchctrl.fetchAll(notificationName: Notification.Name.reloadGameCards, rank: .student)
        
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleView.text = "Games"
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        titleView.font = UIFont.systemFont(ofSize: 33, weight: .black)
        navigationItem.titleView = titleView
        
        setupUI()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI(){
        studentProfileImage.layer.masksToBounds=true
        studentProfileImage.layer.borderWidth = 3.0
        studentProfileImage.layer.borderColor = UIColor.white.cgColor
        studentProfileImage.layer.cornerRadius = studentProfileImage.bounds.width/2
        studentProfileImage.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(launchGame(_:)), name: .launchGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAvailableGames), name: .reloadGameCards, object: nil)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func GameModeChangeToggled(_ sender: UISegmentedControl, forEvent event: UIEvent) {
        if (sender.selectedSegmentIndex == 0) {
            collectionDS.setContinousMode(isContinous: false)
            print("deactivated ContinousMode")
            reloadAvailableGames()
        }
        else {
            collectionDS.setContinousMode(isContinous: true)
            print("activated ContinousMode")
            reloadAvailableGames()
            if collectionDS.studentController.getContinousGameCount() == 0{
                noExerciseStackView.isHidden = false
            }
            else{
                noExerciseStackView.isHidden = true
            }
        }
        
    }
    
    @IBAction func SignoutAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    Only launches the first Exercise in the Notification contained Dictionary
    @objc func launchGame(_ notification: Notification){
        if let myDictionary = notification.userInfo as Dictionary? {
            if let myExercise = myDictionary[0] as? TKExercise {
            gamecontroller.resetInstanceForGame(game: myExercise.type)
            let gameVC = gamecontroller.getViewControllerForGame(game: myExercise.type)
                self.present(gameVC,animated: true)
            }
        }
            
        
    }
    
    @objc func reloadAvailableGames(){
        gameCollectionView.reloadData()
        
        if (tkfetchctrl.getSubjectCount() > 0) {
            noExerciseStackView.isHidden = true
        }
            
        else {
            noExerciseStackView.isHidden = false
        }
    }
    
    
}
