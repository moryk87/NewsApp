//
//  FirstViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import PKHUD
//import Alamofire
//import SwiftyJSON

//protocol FirstViewControllerDelegate {
//    func didFinishGetArticles(finished: Bool)
//}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetArticlesDelegate  {
    
    @IBOutlet weak var sourceTable: UITableView!
    
    let sourceArray = ["CNN","Bloomberg","Business Insider","BBC News","IGN"]
    let urlShortcut = ["cnn","bloomberg","business-insider","bbc-new","ign"]
//    let shortURL = "https://newsapi.org/v2/top-headlines?sources="
//    let APIKey = "&apiKey=e5f010b0e6d143b1a93c6567939c721d"
    var selectedSource: String  = ""
    var getArticles = GetArticles ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceTable.tableFooterView = UIView()
        sourceTable.register(UINib(nibName: "SourceTableViewCell", bundle: nil), forCellReuseIdentifier: "sourceTableViewCell")
        sourceTable.delegate = self
        sourceTable.dataSource = self
        
        getArticles.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourceTable.dequeueReusableCell(withIdentifier: "sourceTableViewCell", for: indexPath) as! SourceTableViewCell
        
        cell.sourceLabel.text = sourceArray[indexPath.row]
        cell.sourceImage.image = UIImage(named: sourceArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sourceTable.deselectRow(at: indexPath, animated: true)
        selectedSource = sourceArray[indexPath.row]
        getArticles.getArticles(selected: urlShortcut[indexPath.row])
        HUD.show(.progress)
        
        print(selectedSource)
    }
    
    func didFinishGetArticles(finished: Bool) {
        HUD.hide()
        performSegue(withIdentifier: "firstToSecond", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "firstToSecond" {
//            let destinationNavigationController = segue.destination as! UINavigationController
//            let targetVC = destinationNavigationController.topViewController as! SecondViewController
//
////            let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
////            targetVC.delegate = self
//        }
//    }
                          

    
}

