//
//  AboutUsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 28/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import WebKit

class AboutUsVC: UIViewController,WKNavigationDelegate,WKUIDelegate {
    var webload : WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
      
        webload = WKWebView()
        webload.navigationDelegate = self
        webload.uiDelegate = self
        view = webload
        self.WebviewCalling()
        
    }
}

extension AboutUsVC {
    
    func WebviewCalling() {
        
       
        
        let web_url =  URL(string:About_US)!
        let web_request = URLRequest(url: web_url)
        webload.load(web_request)
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        ProgressHUD.show(interaction: false)
        print(#function)
    }
    
    
    func webView(_ webView: WKWebView, didFinish  navigation: WKNavigation!)
    {
        ProgressHUD.dismiss()
        let url = webView.url?.absoluteString
        print("---Hitted URL--->\(url!)") // here you are getting URL
    }
    
}
