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

    var websiteDefault: String?
    var webview: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
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
        
        // Toolbar
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        
        // Challenge 2
        let next = UIBarButtonItem(title: "Back", style: .plain, target: webview, action: #selector(webview.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webview, action: #selector(webview.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let customButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [next, forward, customButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // Add observer for track progress
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    @objc func openAlertSheet() {
        let vc = UIAlertController(title: "Open...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            vc.addAction(UIAlertAction(title: "https://\(website)", style: .default, handler: { action -> Void in
                self.webview.load(URLRequest(url: URL(string: action.title!)!))
            }))
        }
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func loadUrl() {
        var url: URL? = nil
        if let websiteDefault = websiteDefault {
            url = URL(string: "https://" + websiteDefault)!
        } else {
            url = URL(string: "https://" + websites[0])!
        }
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
}

extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    print("Allow")
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        // Challenge 1
        let alert = UIAlertController(title: "Error", message: "Site not allowed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
        decisionHandler(.cancel)
    }
}
