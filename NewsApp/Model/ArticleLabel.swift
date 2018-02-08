//
//  ArticleLabel.swift
//  NewsApp
//
//  Created by Jan Moravek on 07/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArticleLabel {
    
    var sourceID: String!
    var author: String!
    var title: String!
    var description: String!
    var url: String!
    var publishedAt: String!
    var saved: Bool = false
    
    
    init(json: JSON) {
        self.sourceID = json["source"]["id"].string
        self.author = json["author"].string
        self.title = json["title"].string
        self.description = json["description"].string
        self.url = json["url"].string
        self.publishedAt = json["publishedAt"].string
    }
    
    
}
