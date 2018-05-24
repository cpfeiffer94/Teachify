//
//  AddExerciseFirstScreenViewController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 14.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class AddExerciseFirstScreenViewController: UIViewController {

    @IBOutlet weak var addExerciseFirstScreenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExerciseFirstScreenCollectionView.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCollectionViewCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
