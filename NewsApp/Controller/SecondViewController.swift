//
//  SecondViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articlesTable: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var savedButton: UIBarButtonItem!
    
    var selectedArticle: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesTable.tableFooterView = UIView()
        articlesTable.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articlesTableViewCell")
        articlesTable.dataSource = self
        articlesTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVar.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articlesTable.dequeueReusableCell(withIdentifier: "articlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        
        print(MyVar.articles[indexPath.row].title)
        print(MyVar.articles[indexPath.row].description)
        cell.articleTitle.text = MyVar.articles[indexPath.row].title
        cell.articleDescription.text = MyVar.articles[indexPath.row].description
        
        if MyVar.articles[indexPath.row].saved == false {
            cell.savedImage.image = UIImage(named: "004-shapes")
        } else {
            cell.savedImage.image = UIImage(named: "003-shapes")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertPopUp(selected: indexPath.row)
        selectedArticle = indexPath.row
        articlesTable.deselectRow(at: indexPath, animated: true)
    }
    
    func alertPopUp(selected: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { _ in
            print("Action Save")
            MyVar.articles[selected].saved = true
            self.articlesTable.reloadData()
        }
        actionSave.setValue(UIImage(named:"002-save"), forKey: "image")
        alert.addAction(actionSave)
        
        let actionOpen = UIAlertAction(title: "Open", style: .default) { _ in
            print("Action Open")
            
            self.performSegue(withIdentifier: "secondToWeb", sender: self)
        }
        actionOpen.setValue(UIImage(named:"001-open"), forKey: "image")
        alert.addAction(actionOpen)
 
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondToWeb" {
            let targetVC = segue.destination as! WebKitViewController
            
            targetVC.myURL = URL(string: MyVar.articles[selectedArticle!].url)
            print(targetVC.myURL!)
        }
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        MyVar.articles.removeAll()
    }
    
    @IBAction func savedButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "secondToThird", sender: self)
    }
    
}
