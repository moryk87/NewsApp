//
//  FirstViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON

//protocol FirstViewControllerDelegate {
//    func didFinishGetArticles(finished: Bool)
//}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
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
        
        selectedSource = sourceArray[indexPath.row]
        getArticles.getArticles(selected: urlShortcut[indexPath.row])
        performSegue(withIdentifier: "firstToSecond", sender: self)
        
//        let centerViewController = SecondViewController(nibName: nil, bundle: nil)
//        let centerSideBar = UINavigationController(rootViewController: centerViewController)
//        self.present(centerSideBar, animated: true, completion: nil)
        
//        let secondViewController:SecondViewController = SecondViewController()
//
//        let destinationNavigationController = segue.destination as! UINavigationController
//        let targetVC = destinationNavigationController.topViewController as! SecondViewController
//
//
//        let centerViewController = SecondViewController(nibName: nil, bundle: nil)
//        let centerSideBar = UINavigationController(rootViewController: centerViewController)
        
//        let secondViewController:SecondViewController = SecondViewController()
//        self.present(secondViewController, animated: true, completion: nil)
        
        print(selectedSource)
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
    
    

    
//    class FooOneViewController: UIViewController,FooTwoViewControllerDelegate {
//
//        func myVCDidFinish(controller: FooTwoViewController, text: String) {
//            colorLabel.text = "The Color is " +  text
//            controller.navigationController?.popViewController(animated: true)
//        }
//
//        override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
//            if segue.identifier == "mySegue"{
//                let vc = segue.destination as! FooTwoViewController
//                vc.colorString = colorLabel.text!
//                vc.delegate = self
//            }
//        }
//
//    }
//
//    protocol FooTwoViewControllerDelegate{
//        func myVCDidFinish(controller:FooTwoViewController,text:String)
//    }
//
//    class FooTwoViewController: UIViewController {
//
//        var delegate:FooTwoViewControllerDelegate? = nil
//
//        @IBAction func saveColor(_ sender: UIBarButtonItem) {
//            guard let delegate = self.delegate else {
//                print("Delegate for FooTwoDelegateController not Set")
//                return
//            }
//            delegate.myVCDidFinish(controller: self, text: colorLabel.text!)
//        }
//
//    }
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
//    func getArticles(selected: String) {
//        let finalURL = shortURL+selected+APIKey
//        print("finalURL:")
//        print(finalURL)
//        
//        Alamofire.request(finalURL, method: .get).responseJSON {
//            response in
//            
//            if response.result.isSuccess {
//                
//                let dataJSON: JSON = JSON(response.result.value!)
//                let articleArray = dataJSON["articles"].arrayValue
//                
//                articleArray.forEach {(dataJSON) in
//                    MyVar.articles.append(ArticleLabel(json: dataJSON))
//                    print(MyVar.articles)
//                }
//                
//                print("/***************************************************************/")
//                print(MyVar.articles[0].sourceID)
//                
//                self.delegate?.didFinishGetArticles(finished: true)
//                
//            } else {
//                print("Error \(String(describing: response.result.error))")
////                    MyVariables.timeStamp = "Connection issues"
//            }
//
//        }
//    }
                          

    
}

