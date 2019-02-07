//
//  WikiViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 07/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    let model: House
    
    init(model: House) {
        self.model = model
        super.init(nibName:nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    func syncModelWithView() {
        loadingView.isHidden = false
        loadingView.startAnimating()
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
}

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
