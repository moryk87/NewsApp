//
//  FirstViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import PKHUD

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var sourceTable: UITableView!
    
    let sourceArray = ["CNN","Bloomberg","Business Insider","BBC News","IGN"]
    let urlShortcut = ["cnn","bloomberg","business-insider","bbc-news","ign"]
    var selectedSource: String  = ""
    var getArticles = GetArticles ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

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
        cell.sourceImage.image = UIImage(named: urlShortcut[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sourceTable.deselectRow(at: indexPath, animated: true)
        selectedSource = sourceArray[indexPath.row]
        getArticles.getArticles(selected: urlShortcut[indexPath.row])
        HUD.show(.progress)
    }
  
}

extension FirstViewController: GetArticlesDelegate {
    
    func didFinishGetArticles(finished: Bool) {
        HUD.hide()
        performSegue(withIdentifier: "firstToSecond", sender: self)
    }
    
}
