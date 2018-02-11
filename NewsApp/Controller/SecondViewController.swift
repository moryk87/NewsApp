//
//  SecondViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 04/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articlesTable: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var savedButton: UIBarButtonItem!
    
    var selectedArticle: Int?
    var html: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesTable.tableFooterView = UIView()
        articlesTable.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articlesTableViewCell")
        articlesTable.dataSource = self
        articlesTable.delegate = self
        
        retrieveArticle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articlesTable.reloadData()
        print("viewDidAppear reload")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVar.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articlesTable.dequeueReusableCell(withIdentifier: "articlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        
        cell.articleTitle.text = MyVar.articles[indexPath.row].title
        cell.articleDescription.text = MyVar.articles[indexPath.row].description
        
        checkIfSaved(position: indexPath.row)
        
        if MyVar.articles[indexPath.row].saved == false {
            cell.savedImage.image = UIImage(named: "004-false")
        } else {
            cell.savedImage.image = UIImage(named: "003-true")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertPopUp(selected: indexPath)
        selectedArticle = indexPath.row
        articlesTable.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondToWeb" {
            let targetVC = segue.destination as! WebKitViewController
            
            targetVC.myURL = URL(string: MyVar.articles[selectedArticle!].url)
            print(targetVC.myURL!)
            
        } else if segue.identifier == "secondToThird" {
            
            let destinationSVC = segue.destination as! SplitThirdViewController
            let targetNC = destinationSVC.viewControllers.first as! UINavigationController
            let targetVC = targetNC.topViewController as! MasterThirdTableViewController
            
            targetVC.delegate = self
        }
        
    }
    
    //MARK: - save etc.
    /***************************************************************/
    
    func alertPopUp(selected: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { _ in
            print("Action Save")
            
            self.saveHTML(position: selected.row)
            self.saveArticle(position: selected.row)
            MyVar.articles[selected.row].saved = true
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
        alert.popoverPresentationController?.sourceView = articlesTable.cellForRow(at: selected)

        present(alert, animated: true)
    }
   
    func saveHTML(position: Int) {
        print(MyVar.articles[position].url)
        let myURLString = MyVar.articles[position].url
        guard let myURL = URL(string: myURLString!) else {
            print("Error: \(String(describing: myURLString)) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("/***************************************************************/")
            print("HTML : \(myHTMLString)")
            print("/***************************************************************/")
            html = myHTMLString
            
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func saveArticle(position: Int) {
        let article = SavedArticle(context: context)
        
        article.title = MyVar.articles[position].title
        article.articleDescription = MyVar.articles[position].description
        article.author = MyVar.articles[position].author
        article.sourceID = MyVar.articles[position].sourceID
        article.publishedAt = MyVar.articles[position].publishedAt
        article.url = MyVar.articles[position].url
        article.html = html
        
        saveCore()
    }
    
    func saveCore() {
        do {
            try context.save()
            retrieveArticle()
            print("delete from CoreData")
        } catch {
            print("Error saving content::: \(error)")
        }
    }
    
    func retrieveArticle() {
        let request: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        
        do {
            MyVar.savedArticles = try context.fetch(request)
        } catch {
            print("Error fetching data from context::: \(error)")
        }
    }
    
    func deleteArticle(position: Int) {
        
        print("deleteArticle position:")
        print(position)
        print(MyVar.savedArticles![position].title!)
        context.delete(MyVar.savedArticles![position])
        
        saveCore()
    }
    
    func checkIfSaved(position: Int) {
        if (MyVar.savedArticles?.contains(where: {$0.title == MyVar.articles[position].title}))! {
            MyVar.articles[position].saved = true
        }
    }
    
    //MARK: - IBActions
    /***************************************************************/
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        MyVar.articles.removeAll()
    }
    
    @IBAction func savedButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "secondToThird", sender: self)
    }

}


extension SecondViewController: MasterThirdTableViewControllerDelegate {
    func deleteSelectedArticle(didSelect: Int) {
        print("delete")
        print(didSelect)
        
        self.deleteArticle(position: didSelect)
    }
}

