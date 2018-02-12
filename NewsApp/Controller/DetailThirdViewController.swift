//
//  DetailThirdViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 09/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

class DetailThirdViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var myHTML: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if myHTML != nil {
            webView.loadHTMLString(myHTML!, baseURL: nil)
            webView.navigationDelegate = self
        }

        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        HUD.flash(.progress)
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }


}


//extension DetailThirdViewController: MasterToDetail {
//
//    func selectedSavedArticle(html: String) {
//
//        webView.loadHTMLString(html, baseURL: nil)
//        webView.navigationDelegate = self
//
//        self.view.addSubview(webView)
//        self.view.sendSubview(toBack: webView)
//    }
//
//}

