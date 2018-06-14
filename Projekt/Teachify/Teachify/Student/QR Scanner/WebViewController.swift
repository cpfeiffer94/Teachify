//
//  WebViewController.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 06.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    var myURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = createURL(with: myURL)
        let urlreq = URLRequest(url: url)
        webView.load(urlreq)
    }
    
    override func loadView() {
        let webConf = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConf)
        webView.uiDelegate = self
        view = webView
    }
    
    fileprivate func createURL(with string: String) -> URL{
        if myURL!.contains("https://"){
            return URL(string: string)!
        }
        return URL(string: "https://\(string)")!
    }
    
    

}
