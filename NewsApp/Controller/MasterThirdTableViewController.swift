//
//  MasterThirdTableViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 09/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol MasterThirdTableViewControllerDelegate {
    func deleteSelectedArticle(didSelect: Int)
}

//protocol MasterToDetail {
//    func selectedSavedArticle(html: String)
//}

class MasterThirdTableViewController: UITableViewController {
    
    var delegate: MasterThirdTableViewControllerDelegate?
//    var delegateDetail: MasterToDetail?
    var selectedArticle: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "SavedArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "savedArticlesTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVar.savedArticles?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedArticlesTableViewCell", for: indexPath) as! SavedArticlesTableViewCell
        
        cell.delegate = self
        cell.articleTitle.text = MyVar.savedArticles?[indexPath.row].title ?? "No articles"
        cell.articleDescription.text = MyVar.savedArticles?[indexPath.row].articleDescription ?? ""
        cell.articleImage.image = UIImage(named: (MyVar.savedArticles?[indexPath.row].sourceID)!) ?? nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedArticle = indexPath.row
        performSegue(withIdentifier: "masterToDetail", sender: self)
        
//        if let detailVC = delegateDetail as? DetailThirdViewController,
//            let detailNC = detailVC.navigationController {splitViewController?.showDetailViewController(detailNC, sender: nil)}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "masterToDetail" {
            
            let targetNC = segue.destination as! UINavigationController
            let targetVC = targetNC.topViewController! as! DetailThirdViewController
            
            targetVC.myHTML = MyVar.savedArticles![selectedArticle!].html
        }
    }
    
    func unCheckSaved(position: Int) {
        if let atPosition = MyVar.articles.index(where: {$0.title == MyVar.savedArticles![position].title!}) {
            MyVar.articles[atPosition].saved = false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MasterThirdTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.unCheckSaved(position: indexPath.row)
            self.delegate?.deleteSelectedArticle(didSelect: indexPath.row)
            self.tableView.reloadData()
        }
        
        return [deleteAction]
    }
}


