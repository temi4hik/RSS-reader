//
//  DetailNewsViewController.swift
//  RSS-reader
//
//  Created by Artem on 19/01/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit
import WebKit

class DetailNewsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: news.link)
        self.webView.navigationDelegate = self
        self.webView.load(request)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = barButton
        activityIndicator.startAnimating()
    }
}
extension DetailNewsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
