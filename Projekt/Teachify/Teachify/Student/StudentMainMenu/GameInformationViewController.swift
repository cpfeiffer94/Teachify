//
//  GameInformationViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 02.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameInformationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: .startGame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func startGame(){
        let gameVCtype  = GameEnum.mathPiano.gameViewControllerClass as! UIViewController.Type
        let gameVC = gameVCtype.init(coder: NSCoder())
        self.present(gameVC!,animated: true)
    }
}
