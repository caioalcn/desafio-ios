//
//  PRWebViewController.swift
//  AwesomeRepo
//
//  Created by Caio Alcântara on 12/05/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit

class PRWebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var prUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if prUrl == "" {
            
            let alert = UIAlertController(title: "URL Invalid", message: "Please try again later!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                
                self.navigationController?.popViewController(animated: true)
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            let url = NSURL (string: prUrl)
            let requestObj = NSURLRequest(url: url! as URL)
            webView.loadRequest(requestObj as URLRequest)
            
            KRProgressHUD.show()
            
        }
        
    }
    
}

extension PRWebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        KRProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        KRProgressHUD.showError()
    }
}
