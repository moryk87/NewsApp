//
//  WebKitViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 08/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

//class WebKitViewController: UIViewController, WKUIDelegate {
class WebKitViewController: UIViewController, WKNavigationDelegate {

//    let myURL = URL(string: MyVar.articles[selected].url)
//    let myRequest = URLRequest(url: myURL!)
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var myURL: URL?
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let myURL = URL(string: "https://www.apple.com")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myRequest = URLRequest(url: myURL!)

        webView.navigationDelegate = self
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK:- WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
//        HUD.flash(.progress)
        HUD.show(.progress)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        HUD.hide()
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
  
}
