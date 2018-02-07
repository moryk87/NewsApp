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
    
//    var title: String
//    var description: String
//    var url: String
//    var publishedAt: TimeZone
//    var sourceID: String
//
//    init(title: String, description: String, url: String, publishedAt: TimeZone, sourceID: String) {
//        self.title = title
//        self.description = description
//        self.url = url
//        self.publishedAt = publishedAt
//        self.sourceID = sourceID
//    }
    var author: String!
    var description: String!
    var publishedAt: String!
    var title: String!
    var url: String!
    var sourceID: String!
    var saved: Bool = false
    
    
    init(json: JSON) {
        self.publishedAt = json["publishedAt"].string
        self.author = json["author"].string
        self.title = json["title"].string
        self.description = json["desctiption"].string
        self.url = json["url"].string
        self.sourceID = json["source"]["id"].string
    }
    
    
}
