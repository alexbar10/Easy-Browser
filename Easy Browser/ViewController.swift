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
        
        setupUI()
        loadUrl()
    }
    
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openAlertSheet))
    }
    
    @objc func openAlertSheet() {
        let vc = UIAlertController(title: "Open...", message: nil, preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "https://twitter.com", style: .default, handler: { action -> Void in
            self.webview.load(URLRequest(url: URL(string: action.title!)!))
        }))
        vc.addAction(UIAlertAction(title: "https://facebook.com", style: .default, handler: { action -> Void in
            self.webview.load(URLRequest(url: URL(string: action.title!)!))
        }))
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func loadUrl() {
        let url = URL(string: "https://google.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

extension ViewController : WKNavigationDelegate {
    
}
