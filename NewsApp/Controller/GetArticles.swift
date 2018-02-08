//
//  GetArticles.swift
//  NewsApp
//
//  Created by Jan Moravek on 08/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GetArticlesDelegate {
    func didFinishGetArticles(finished: Bool)
}

class GetArticles {
    
    let shortURL = "https://newsapi.org/v2/top-headlines?sources="
    let APIKey = "&apiKey=e5f010b0e6d143b1a93c6567939c721d"
    
    var delegate: GetArticlesDelegate?
    
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
                    MyVar.articles.append(ArticleLabel(json: dataJSON))
                    print(MyVar.articles)
                }
                
                print("/***************************************************************/")
                print(MyVar.articles[0].sourceID)
                
                self.delegate?.didFinishGetArticles(finished: true)
                
//                let newVC = UIViewController()
//                newVC.view.backgroundColor = UIColor.red
//                self.navigationController?.pushViewController(newVC, animated: true)
                
//                let secondViewController:SecondViewController = SecondViewController()
//                self.present(secondViewController, animated: true, completion: nil)
//                let newViewController = SecondViewController()
//                self.navigationController?.pushViewController(newViewController, animated: true)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
            
        }
    }
}
