//
//  CustomAlertViewController.swift
//  Teachify
//
//  Created by Philipp on 14.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class CustomAlertViewController : UIViewController{
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var alertTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButtonView: UIView!
    @IBOutlet weak var saveButtonView: UIView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var subjectType: UISegmentedControl!
    
    var delegate: CustomAlertViewDelegate?
    var caller : CustomAlertViewCallers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTextField.becomeFirstResponder()
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    
    func setupView(){
        createCornerRadius()
        setupText()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        alertTextField.tintColor = UIColor.black
        }
    
    func animateView(){
        alertView.alpha = 0
        alertView.backgroundColor = UIColor.clear
        alertView.frame.origin.y = alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1;
            self.alertView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
        
    }

    @IBAction func onClickCancelButton(_ sender: Any) {
        alertTextField.resignFirstResponder()
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveCancelButton(_ sender: Any) {
        alertTextField.resignFirstResponder()
        let color = getSelectedColor()
        delegate?.okButtonTapped(textFieldValue: alertTextField.text!, subjectColor: color,with: caller)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getSelectedColor() -> TKColor {
        switch subjectType.selectedSegmentIndex {
        case 0: return .mathBlue
        case 1: return .teacherRed
        default:
            return TKColor.black
        }
    }
    
    private func createCornerRadius(){
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 15
        let path = UIBezierPath(roundedRect:cancelButtonView.bounds,
                                byRoundingCorners:[.bottomLeft],
                                cornerRadii: CGSize(width: 15, height:  15))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        cancelButtonView.layer.mask = maskLayer
        let path2 = UIBezierPath(roundedRect:saveButtonView.bounds,
                                 byRoundingCorners:[.bottomRight],
                                 cornerRadii: CGSize(width: 15, height:  15))
        
        let maskLayer2 = CAShapeLayer()
        
        maskLayer2.path = path2.cgPath
        saveButtonView.layer.mask = maskLayer2
    }
    
    private func setupText(){
        guard let caller = caller else {return}
        switch caller {
        case .tkSubject:
            titleLabel.text = "Create a new subject"
            descriptionLabel.text = "Enter subject name"
        case .tkClass:
            titleLabel.text = "Create a new class"
            descriptionLabel.text = "Enter class name"
            heightConstraint.constant = 0
            subjectType.isHidden = true
        }
    }
}

enum CustomAlertViewCallers{
    case tkClass
    case tkSubject
}
