//
//  FirstViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol FirstViewControllerDelegate {
    func didFinishGetData(finished: Bool)
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var sourceTable: UITableView!
    
    let sourceArray = ["CNN","Bloomberg","Business Insider","BBC News","IGN"]
    let urlShortcut = ["cnn","bloomberg","business-insider","bbc-new","ign"]
    let shortURL = "https://newsapi.org/v2/top-headlines?sources="
    let APIKey = "&apiKey=e5f010b0e6d143b1a93c6567939c721d"
    var articles: [ArticleLabel] = []
    
    var selectedSource: String  = ""
    var delegate: FirstViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceTable.tableFooterView = UIView()
        sourceTable.register(UINib(nibName: "SourceTableViewCell", bundle: nil), forCellReuseIdentifier: "sourceTableViewCell")
        sourceTable.delegate = self
        sourceTable.dataSource = self
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
        
        performSegue(withIdentifier: "firstToSecond", sender: self)
        selectedSource = sourceArray[indexPath.row]
        getArticles(selected: urlShortcut[indexPath.row])
        
        print(selectedSource)
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func getArticles(selected: String) {
        let finalURL = shortURL+selected+APIKey
        print("finalURL:")
        print(finalURL)
        
        Alamofire.request(finalURL, method: .get).responseJSON {
            response in
            
            if response.result.isSuccess {
                
                let dataJSON: JSON = JSON(response.result.value!)
                let articleArray = dataJSON["articles"].arrayValue
                
                articleArray.forEach {(dataJSON) in
                    self.articles.append(ArticleLabel(json: dataJSON))
                    print(self.articles)
                }
                
                print("/***************************************************************/")
                print(self.articles[0].sourceID)
                
//                self.delegate?.didFinishGetData(finished: true)
                
            } else {
                print("Error \(String(describing: response.result.error))")
//                    MyVariables.timeStamp = "Connection issues"
            }

        }
    }
                          

    
}

