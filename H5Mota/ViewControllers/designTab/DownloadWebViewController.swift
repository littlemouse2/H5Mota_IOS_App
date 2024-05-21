//
//  DownloadWebViewController.swift
//  H5MOTA
//
//  This code is aimed for the web view
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

import UIKit
import WebKit

class DownloadWebViewController : UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    //WEBKIT
    
    //start animation
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        loading.startAnimating()
    }
    
    //stop animation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
        
    }
    
    //stop animation
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        loading.stopAnimating()
    }
    
    //load the webview
    override func viewDidLoad() {
        //data persistance
        let userDefaults = UserDefaults.standard
        var savedURL = userDefaults.string(forKey: "downloadURL")
        if(savedURL != "https://h5mota.com/otherNew.php")
        {
            savedURL = "https://h5mota.com/otherNew.php"
        }
        
        loading.hidesWhenStopped = true
        webView.navigationDelegate = self
        // Load url into webview
        let request = URLRequest(url: URL(string: savedURL!)!)
        webView.load(request)
        
        //data persistence for small chunk of data
        let h5MotaDownloadURL = "https://h5mota.com/otherNew.php"
        userDefaults.set(h5MotaDownloadURL, forKey: "downloadURL")
    }
}
