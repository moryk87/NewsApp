//
//  SecondViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetArticlesDelegate, ArticlesTableViewCellDelegate {
    
    @IBOutlet weak var articlesTable: UITableView!
    
    let getArticles = GetArticles ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesTable.tableFooterView = UIView()
        articlesTable.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articlesTableViewCell")
        articlesTable.dataSource = self
        articlesTable.delegate = self
        
        getArticles.delegate = self
    }

//    override func viewDidAppear(_ animated: Bool) {
//        articlesTable.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articlesTable.dequeueReusableCell(withIdentifier: "articlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        
        if MyVar.articles.isEmpty == false {
            cell.articleTitle.text = MyVar.articles[indexPath.row].title
            cell.articleDescription.text = MyVar.articles[indexPath.row].description
        }
        
        return cell
    }
    
    func didFinishGetArticles(finished: Bool) {
        print("reload")
        print(MyVar.articles[0].title)
        self.articlesTable.reloadData()
    }
    
    func saveLocalyButtonPressed(didSelect: ArticlesTableViewCell) {
        <#code#>
    }

}
