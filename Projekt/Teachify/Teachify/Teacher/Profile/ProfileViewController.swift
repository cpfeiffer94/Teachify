//
//  ProfileViewController.swift
//  Teachify
//
//  Created by Philipp on 26.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    
    
    fileprivate let customSegmentedControlDataSource = CustomSegmentedControlDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.dataSource = self
        profileTableView.delegate = self
        customSegmentedControl.dataSource = customSegmentedControlDataSource
        
        customSegmentedControl.register(UINib(nibName: String(describing: SegmentCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: "segmentCell")
        customSegmentedControl.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
        customSegmentedControl.addTarget(action: didChangeIndex)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeIndex(){
        print("Changed index ProfileViewController: \(customSegmentedControl.selectedSegmentIndex)")
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

//TableView Extension
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }  
}

class ProfileTableViewCell : UITableViewCell{
    
    @IBOutlet weak var iconView: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        iconView.backgroundColor = selected ? .mathBlue : .mathBlue
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        iconView.backgroundColor = highlighted ? .mathBlue : .mathBlue
    }
    
    
}
