//
//  ViewController.swift
//  Easy Browser
//
//  Created by Alejandro Barranco on 01/05/20.
//  Copyright © 2020 Alejandro Barranco. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webview: WKWebView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUrl()
    }
    
    func loadUrl() {
        let url = URL(string: "https://google.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
}

extension ViewController : WKNavigationDelegate {
    
}
