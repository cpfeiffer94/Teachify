//
//  WebViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var myURL = URL(string: "")
    
    override func viewDidLoad() {
        let urlreq = URLRequest(url: myURL!)
        webView.load(urlreq)
        
        super.viewDidLoad()
    }
    
    

}
