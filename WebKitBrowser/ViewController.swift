//
//  ViewController.swift
//  WebKitBrowser
//
//  Created by Егор Глезденёв on 06.09.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.google.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        urlTextField.text = homePage
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlHasHttpPrefix = urlTextField.text?.hasPrefix("http://") == true
        let urlHasHttpsPrefix = urlTextField.text?.hasPrefix("https://") == true

        func addHttpPrefix() -> String {
            var urlString = ""
            if urlHasHttpPrefix || urlHasHttpsPrefix {
                urlString = textField.text!
            } else {
                urlString = "http://\(textField.text!)"
            }
            return urlString
        }
        
        
        
        let url = URL(string: addHttpPrefix())!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
}
